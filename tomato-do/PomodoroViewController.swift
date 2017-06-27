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
    var counterTimer = 0

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resumeButton: UIButton!
    @IBOutlet weak var UnexpectedTaskTextField: UITextField!

    @IBAction func backToDoPress(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        navigationController?.navigationBar.isHidden = true
    }

    @IBAction func startButtonPress(_ sender: Any) {
        viewClock.startClockTimer()

        startButton.isHidden = true
        pauseButton.isHidden = false
    }

    @IBAction func pauseButtonPress(_ sender: Any) {
        viewClock.pauseAnimation(layer: viewClock.shapeLayer)
        viewClock.countDownTimer.invalidate()

        pauseButton.isHidden = true
        stopButton.isHidden = false
        resumeButton.isHidden = false
    }

    @IBAction func resumeButtonPress(_ sender: Any) {
        viewClock.startCoundownTimer()
        viewClock.resumeAnimation(layer: viewClock.shapeLayer)

        resumeButton.isHidden = true
        stopButton.isHidden = true
        pauseButton.isHidden = false
    }

    @IBAction func stopButtonPress(_ sender: Any) {
        let noAlertAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        let yesAlertAction = UIAlertAction(title: "Yes", style: .destructive) { action in
            self.pomodoroClock()
            self.setPomodoroUI()
        }
        let alertController = UIAlertController(title: "Stop Timer", message: "Are you sure you want to stop the curent pomodoro?", preferredStyle: .alert)
        alertController.addAction(noAlertAction)
        alertController.addAction(yesAlertAction)
        self.present(alertController, animated: true, completion: nil)
    }

    func initialStateButtons() {
        pauseButton.isHidden = true
        stopButton.isHidden = true
        resumeButton.isHidden = true
        startButton.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setPomodoroUI()
        pomodoroClock()
        clockViewDidEndTimer(viewClock)
        UnexpectedTaskTextField.delegate = self
        viewClock.delegate = self
    }

    // MARK: - ClockViewDelegate

    func clockViewDidEndTimer(_ clockView: ClockView) {
        counterTimer += 1
        if counterTimer % 8 == 0 {
            viewClock.setTimer(value: 15)
            setRestPomodoroUI()
            viewClock.startClockTimer()
        } else if counterTimer % 2 == 0 {
            viewClock.setTimer(value: 2)
            setRestPomodoroUI()
            viewClock.startClockTimer()
        } else {
            viewClock.setTimer(value: 5)
            setPomodoroUI()
            initialStateButtons()
        }
    }

    func setRestPomodoroUI() {
        view.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        for button in [startButton, pauseButton, stopButton, resumeButton] {
            button?.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        }
    }

    func setPomodoroUI() {
        view.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9354019761, green: 0.3499509096, blue: 0.1937675774, alpha: 1)
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        navigationController?.navigationBar.tintColor = UIColor.white
        for button in [startButton, pauseButton, stopButton, resumeButton] {
            button?.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        }
    }

    func pomodoroClock() {
        viewClock.setTimer(value: 5)

        self.view.addSubview(viewClock)

        viewClock.autoSetDimensions(to: CGSize(width: 250, height: 250))
        viewClock.autoPinEdge(toSuperviewEdge: .top, withInset: 105)
        viewClock.autoAlignAxis(toSuperviewAxis: .vertical)

        initialStateButtons()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        UnexpectedTaskTextField.resignFirstResponder()
        CoreDataManager.shared.addTask(taskToDo: (textField.text)!)
        UnexpectedTaskTextField.text = ""

        return true
    }
}
