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
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var unexpectedTaskTextField: UITextField!
    @IBOutlet weak var pomodoroCollectionView: MiniPomodoroCollectionView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        pomodoroClock()
        unexpectedTaskTextField.delegate = self
        viewClock.delegate = self
        State.shared.checkIfPeriodEnded()
        updateUIToCounters()
        pomodoroCollectionView.updateFinishedPomodorosState()
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
        if !State.shared.isRestTime {
            pomodoroCollectionView.currentPomodoro.startAnimation(totalDuration: TimeInterval(State.shared.periodDuration))
        }

        State.shared.startPeriod()

        startButton.isHidden = true
        stopButton.isHidden = false
    }

    @IBAction func stopButtonPress(_ sender: Any) {
        let noAlertAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        let yesAlertAction = UIAlertAction(title: "Yes", style: .destructive) { action in
            State.shared.cancelPeriod()
            self.pomodoroCollectionView.currentPomodoro.stopAnimation()
            self.viewClock.stopClockTimer()
            self.updateUIToCounters()
        }
        let alertController = UIAlertController(title: "Stop Timer", message: "Are you sure you want to stop the curent pomodoro?", preferredStyle: .alert)
        alertController.addAction(noAlertAction)
        alertController.addAction(yesAlertAction)
        self.present(alertController, animated: true, completion: nil)
    }

    // MARK: - ClockViewDelegate

    func clockViewDidEndTimer(_ clockView: ClockView) {
        State.shared.finishPeriod()
        updateUIToCounters()
        autoStartRestIfNeeded()
    }

    // MARK: - Customizing timerUI

    func updateUIToCounters() {
        viewClock.setTimer(value: State.shared.periodDuration)
        if State.shared.isRestTime {
            setRestPomodoroUI()
        } else {
            setPomodoroUI()
        }
        startButton.isHidden = State.shared.timerEndDate != nil
        stopButton.isHidden = State.shared.timerEndDate == nil
    }

    func autoStartRestIfNeeded() {
        if State.shared.counterTimer % 2 == 0 {
            startButtonPress(startButton)
        }
    }

    func setRestPomodoroUI() {
        view.backgroundColor = UIColor.Tomatodo.blue
        navigationController?.navigationBar.barTintColor = UIColor.Tomatodo.darkBlue
        for button in [startButton, stopButton] {
            button?.backgroundColor = UIColor.Tomatodo.darkBlue
        }
    }

    func setPomodoroUI() {
        view.backgroundColor = UIColor.Tomatodo.red
        navigationController?.navigationBar.barTintColor = UIColor.Tomatodo.orange
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        navigationController?.navigationBar.tintColor = UIColor.white
        for button in [startButton, stopButton] {
            button?.backgroundColor = UIColor.Tomatodo.orange
        }
    }

    // MARK: - Configure location timer

    func pomodoroClock() {
        self.view.addSubview(viewClock)

        viewClock.autoSetDimensions(to: CGSize(width: 250, height: 250))
        viewClock.autoPinEdge(toSuperviewEdge: .top, withInset: 98)
        viewClock.autoAlignAxis(toSuperviewAxis: .vertical)
    }

    func resumeCurrentTimer(timerEndDate: Date) {
        let remainingTime = timerEndDate.timeIntervalSinceNow
        let totalDuration = TimeInterval(viewClock.timerValue)
        let currentPosition = totalDuration - remainingTime

        viewClock.setTimer(value: Int(remainingTime))
        viewClock.startCoundownTimer()
        viewClock.startAnimation(totalDuration: totalDuration, currentPosition: currentPosition)
        if !State.shared.isRestTime {
            pomodoroCollectionView.currentPomodoro.startAnimation(totalDuration: totalDuration, currentPosition: currentPosition)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        unexpectedTaskTextField.resignFirstResponder()
        CoreDataManager.shared.addTask(taskToDo: (textField.text)!)
        unexpectedTaskTextField.text = ""

        return true
    }
}
