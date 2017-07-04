//
//  PomodoroViewController.swift
//  tomato-do
//
//  Created by IvanLazarev on 11/05/2017.
//  Copyright © 2017 Иван Лазарев. All rights reserved.
//

import UIKit
import PureLayout

class PomodoroViewController: UIViewController, UITextFieldDelegate, ClockViewDelegate {

    let viewClock = ClockView()
    let miniViewClock = MiniPomodoroView()

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resumeButton: UIButton!
    @IBOutlet weak var unexpectedTaskTextField: UITextField!
    @IBOutlet weak var pomodoroCollectionView: MiniPomodoroCollectionView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        pomodoroClock()
        updateUIToCounters()
        unexpectedTaskTextField.delegate = self
        viewClock.delegate = self
        if let timerEndDate = State.shared.timerEndDate {
            resumeCurrentTimer(timerEndDate: timerEndDate)
        }
    }

    // MARK: - IBAction

    @IBAction func backToDoPress(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func startButtonPress(_ sender: Any) {
        viewClock.startClockTimer()
        pomodoroCollectionView.currentPomodoro.startAnimation(totalDuration: TimeInterval(Constants.pomodoroTime))

        State.shared.sheduleTimerEnd(in: TimeInterval(Constants.pomodoroTime))

        startButton.isHidden = true
        pauseButton.isHidden = false
    }

    @IBAction func pauseButtonPress(_ sender: Any) {
        viewClock.pauseAnimation()
        pomodoroCollectionView.currentPomodoro.pauseAnimation()
        viewClock.countDownTimer.invalidate()

        pauseButton.isHidden = true
        stopButton.isHidden = false
        resumeButton.isHidden = false
    }

    @IBAction func resumeButtonPress(_ sender: Any) {
        viewClock.startCoundownTimer()
        viewClock.resumeAnimation()
        pomodoroCollectionView.currentPomodoro.resumeAnimation()

        let date = Date(timeInterval: TimeInterval(viewClock.timerValue), since: Date())
        State.shared.timerEndDate = date

        resumeButton.isHidden = true
        stopButton.isHidden = true
        pauseButton.isHidden = false
    }

    @IBAction func stopButtonPress(_ sender: Any) {
        let noAlertAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        let yesAlertAction = UIAlertAction(title: "Yes", style: .destructive) { action in
            self.pomodoroClock()
            self.pomodoroCollectionView.currentPomodoro.stopAnimation()
            self.setPomodoroUI()
        }
        let alertController = UIAlertController(title: "Stop Timer", message: "Are you sure you want to stop the curent pomodoro?", preferredStyle: .alert)
        alertController.addAction(noAlertAction)
        alertController.addAction(yesAlertAction)
        self.present(alertController, animated: true, completion: nil)
    }

    // MARK: - ClockViewDelegate

    func clockViewDidEndTimer(_ clockView: ClockView) {
        State.shared.timerEndDate = nil
        State.shared.counterTimer += 1
        updateUIToCounters()
        autoStartRestIfNeeded()
    }

    // MARK: - Customizing timerUI

    func updateUIToCounters() {
        if State.shared.counterTimer % 8 == 0 {
            viewClock.setTimer(value: Constants.longRestTime)
            setRestPomodoroUI()
        } else if State.shared.counterTimer % 2 == 0 {
            viewClock.setTimer(value: Constants.restTime)
            setRestPomodoroUI()
        } else {
            viewClock.setTimer(value: Constants.pomodoroTime)
            setPomodoroUI()
            initialStateButtons()
        }
    }

    func autoStartRestIfNeeded() {
        if State.shared.counterTimer % 2 == 0 {

            State.shared.sheduleTimerEnd(in: TimeInterval(viewClock.timerValue))

            viewClock.startClockTimer()
        }
    }

    func setRestPomodoroUI() {
        view.backgroundColor = UIColor.Tomatodo.blue
        navigationController?.navigationBar.barTintColor = UIColor.Tomatodo.darkBlue
        for button in [startButton, pauseButton, stopButton, resumeButton] {
            button?.backgroundColor = UIColor.Tomatodo.darkBlue
        }
    }

    func setPomodoroUI() {
        view.backgroundColor = UIColor.Tomatodo.red
        navigationController?.navigationBar.barTintColor = UIColor.Tomatodo.orange
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        navigationController?.navigationBar.tintColor = UIColor.white
        for button in [startButton, pauseButton, stopButton, resumeButton] {
            button?.backgroundColor = UIColor.Tomatodo.orange
        }
    }

    func initialStateButtons() {
        pauseButton.isHidden = true
        stopButton.isHidden = true
        resumeButton.isHidden = true
        startButton.isHidden = false
    }

    // MARK: - Configure location timer

    func pomodoroClock() {
        viewClock.setTimer(value: Constants.pomodoroTime)

        self.view.addSubview(viewClock)

        viewClock.autoSetDimensions(to: CGSize(width: 250, height: 250))
        viewClock.autoPinEdge(toSuperviewEdge: .top, withInset: 98)
        viewClock.autoAlignAxis(toSuperviewAxis: .vertical)

        initialStateButtons()
    }

    func resumeCurrentTimer(timerEndDate: Date) {
        let currentDate = Date()
        let remainingTime = timerEndDate.timeIntervalSinceNow
        let totalDuration = TimeInterval(viewClock.timerValue)
        let currentPosition = totalDuration - remainingTime

        if currentDate.compare(timerEndDate) == .orderedAscending {
            viewClock.setTimer(value: Int(remainingTime))
            viewClock.startCoundownTimer()
            viewClock.startAnimation(totalDuration: totalDuration, currentPosition: currentPosition)
            if !State.shared.isRestTime {
                pomodoroCollectionView.currentPomodoro.startAnimation(totalDuration: totalDuration, currentPosition: currentPosition)
            }
        } else {
            State.shared.counterTimer += 1
            State.shared.timerEndDate = nil
            pomodoroCollectionView.updateFinishedPomodorosState()
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        unexpectedTaskTextField.resignFirstResponder()
        CoreDataManager.shared.addTask(taskToDo: (textField.text)!)
        unexpectedTaskTextField.text = ""

        return true
    }
}
