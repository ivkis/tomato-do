//
//  SpeechRecognitionController.swift
//  tomato-do
//
//  Created by IvanLazarev on 28/07/2017.
//  Copyright © 2017 Иван Лазарев. All rights reserved.
//

import Foundation
import Speech
import UIKit


class SpeechRecognitionController: UIViewController, SFSpeechRecognizerDelegate {

    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: Settings.shared.speechRecognitionLocale.rawValue))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    private var recognizedText: String?
    private var recognizeTimeout: Timer?

    @IBOutlet weak var taskTextLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var microfoneImageView: UIImageView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.restUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        speechRecognizer?.delegate = self
        microphoneSettings()
        startAudio()
        startRecognizing()
        settingsButton.isHidden = true
    }

    deinit {
        print("Deinit SpeechRecognitionController, stopping recording")
        stopRecognizing()
        stopAudio()
    }

    // MARK: - Actions

    @IBAction func settingsButtonTapped(_ sender: Any) {
        guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
            return
        }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
        }
    }

    @IBAction func reloadButtonTapped(_ sender: Any) {
        if audioEngine.isRunning {
            recognitionRequest?.endAudio()
        }
        self.stopRecognizing()
        self.startRecognizing()
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func okButtonTapped(_ sender: Any) {
        guard let recognizedText = recognizedText else {
            return
        }
        stopRecognizing()
        CoreDataManager.shared.addTask(taskToDo: recognizedText, plannedPomodoro: 1)
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Speech Recognition

    func microphoneSettings() {
        AVAudioSession.sharedInstance().requestRecordPermission { micAuthStatus in
            SFSpeechRecognizer.requestAuthorization { (authStatus) in
                var isButtonEnabled = false

                switch AVAudioSession.sharedInstance().recordPermission() {
                case AVAudioSessionRecordPermission.granted:
                    isButtonEnabled = true
                    print("Microphone permission granted")
                case AVAudioSessionRecordPermission.denied:
                    isButtonEnabled = false
                    print("Microphone pemission denied")
                case AVAudioSessionRecordPermission.undetermined:
                    isButtonEnabled = false
                    print("Microphone permission not determined")
                default:
                    break
                }

                switch authStatus {
                case .authorized:
                    isButtonEnabled = isButtonEnabled && true
                case .denied:
                    isButtonEnabled = false
                    print("User denied access to speech recognition")
                case .restricted:
                    isButtonEnabled = false
                    print("Speech recognition restricted on this device")
                case .notDetermined:
                    isButtonEnabled = false
                    print("Speech recognition not yet authorized")
                }
                OperationQueue.main.addOperation {
                    self.okButton.isHidden = !isButtonEnabled
                    self.reloadButton.isHidden = !isButtonEnabled
                    self.settingsButton.isHidden = isButtonEnabled
                    if !self.settingsButton.isHidden {
                        self.taskTextLabel.text = "Please enable voice recognition."
                    }
                }
            }
        }
    }

    func startAudio() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }

        guard let inputNode = audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
        }

        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { [weak self] (buffer, when) in
            self?.recognitionRequest?.append(buffer)
        }
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
    }

    func stopAudio() {
        audioEngine.stop()
        audioEngine.inputNode?.removeTap(onBus: 0)
    }

    func startRecognizing() {
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        recognitionRequest.shouldReportPartialResults = true

        recognizedText = nil
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { [weak self] (result, error) in

            var isFinal = false

            if let result = result {
                self?.recognizedText = result.bestTranscription.formattedString
                self?.taskTextLabel.text = self?.recognizedText
                self?.recognizeTimeout?.invalidate()
                self?.recognizeTimeout = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { [weak self] _ in
                    self?.okButtonTapped(self!.okButton)
                }
                isFinal = result.isFinal
            }
            if error != nil || isFinal {
                if let error = error {
                    print("Error recognizing speech: \(error)")
                }
            }
        })
        taskTextLabel.text = "Say something, I'm listening!"
    }

    func stopRecognizing() {
        recognizeTimeout?.invalidate()
        recognitionTask?.cancel()
        recognitionRequest?.endAudio()
        recognizeTimeout = nil
        recognitionTask = nil
        recognitionRequest = nil
    }
}
