//
//  PomodoroViewController.swift
//  tomato-do
//
//  Created by IvanLazarev on 11/05/2017.
//  Copyright © 2017 Иван Лазарев. All rights reserved.
//

import UIKit
import PureLayout


protocol PomodoroViewControllerDelegate: class {
    func pomodoroViewController(_ controller: PomodoroViewController, didComplete task: Task)
}


class PomodoroViewController: UIViewController {

    weak var delegate: PomodoroViewControllerDelegate?
    var task: Task!

    @IBOutlet weak var viewClock: ClockView!
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
        navigationItem.title = task.taskToDo
        viewClock.delegate = self
        State.shared.checkIfPeriodEnded()
        endWorkingDay()
        updateUIToCounters()
        pomodoroCollectionView.updateFinishedPomodorosState()
        if let timerEndDate = State.shared.timerEndDate {
            resumeCurrentTimer(timerEndDate: timerEndDate)
        }
    }

    // MARK: - IBAction

    @IBAction func startButtonPress(_ sender: Any) {
        viewClock.startClockTimer()
        if !State.shared.isRestTime {
            pomodoroCollectionView.currentPomodoro.startAnimation(totalDuration: TimeInterval(State.shared.periodDuration))
        }

        State.shared.startPeriod(task: task)

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

    @IBAction func finishTaskTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.delegate?.pomodoroViewController(self, didComplete: self.task)
        }
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

    @discardableResult
    func endWorkingDay() -> Bool {
        if State.shared.currentPomodoroIndex >= Constants.dailyPomodoros {
            State.shared.resetState()
            self.updateUIToCounters()
            pomodoroCollectionView.updateFinishedPomodorosState()

            let alertController = UIAlertController(title: "Reached Daily Goal", message: "You've completed your target for the daty! Congratulations.", preferredStyle: .alert)
            let action = UIAlertAction(title: "I'm done", style: .destructive, handler: nil)
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
            return true
        }
        return false
    }
}


extension PomodoroViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        CoreDataManager.shared.addTask(taskToDo: (textField.text)!)
        textField.text = ""
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


extension PomodoroViewController: ClockViewDelegate {
    func clockViewDidEndTimer(_ clockView: ClockView) {
        State.shared.finishPeriod()
        updateUIToCounters()
        if !endWorkingDay() {
            autoStartRestIfNeeded()
        }
    }
}
