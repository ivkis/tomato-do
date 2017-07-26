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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(onPeriodFinished), name: .pomodoroStateChanged, object: nil)
        navigationItem.title = task.taskToDo
        endWorkingDay()
        updateUIToCounters()
        unexpectedTaskTextField.inputAccessoryView = PomodoroCountPickerView()
        if let timerEndDate = State.shared.timerEndDate {
            resumeCurrentTimer(timerEndDate: timerEndDate)
        }
    }

    // MARK: - IBAction

    @IBAction func startButtonPress(_ sender: Any) {
        viewClock.startClockTimer()

        State.shared.startPeriod(task: task)

        startButton.isHidden = true
        stopButton.isHidden = false
    }

    @IBAction func stopButtonPress(_ sender: Any) {
        let noAlertAction = UIAlertAction(title: NSLocalizedString("No", comment: "No"), style: .cancel, handler: nil)
        let yesAlertAction = UIAlertAction(title: NSLocalizedString("Yes", comment: "Yes"), style: .destructive) { action in
            State.shared.cancelPeriod()
            self.viewClock.stopClockTimer()
            self.updateUIToCounters()
        }
        let alertController = UIAlertController(title: NSLocalizedString("Stop Timer", comment: "Stop Timer"), message: NSLocalizedString("Are you sure you want to stop the curent pomodoro?", comment: "Are you sure you want to stop the curent pomodoro?"), preferredStyle: .alert)
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

    func onPeriodFinished() {
        updateUIToCounters()
        if !endWorkingDay() {
            autoStartRestIfNeeded()
        }

    }

    func autoStartRestIfNeeded() {
        if State.shared.counterTimer % 2 == 0 {
            startButtonPress(startButton)
        }
    }

    func setRestPomodoroUI() {
        view.backgroundColor = UIColor.Tomatodo.blue
        navigationController?.restUI()
        for button in [startButton, stopButton] {
            button?.backgroundColor = UIColor.Tomatodo.darkBlue
        }
    }

    func setPomodoroUI() {
        view.backgroundColor = UIColor.Tomatodo.red
        navigationController?.pomodoroUI()
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
        }

    @discardableResult
    func endWorkingDay() -> Bool {
        if State.shared.currentPomodoroIndex >= Settings.shared.targetPomodoros {
            State.shared.resetState()
            self.updateUIToCounters()

            let alertController = UIAlertController(title: NSLocalizedString("Reached Daily Goal", comment: "Reached Daily Goal"), message: NSLocalizedString("You've completed your target for the daty! Congratulations!", comment: "You've completed your target for the daty! Congratulations."), preferredStyle: .alert)
            let action = UIAlertAction(title: NSLocalizedString("I'm done", comment: "I'm done"), style: .destructive, handler: nil)
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
            return true
        }
        return false
    }
}


extension PomodoroViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let pomodoroCountPickerView = textField.inputAccessoryView as! PomodoroCountPickerView
        CoreDataManager.shared.addTask(taskToDo: (textField.text)!, plannedPomodoro: pomodoroCountPickerView.value)
        pomodoroCountPickerView.value = 1
        textField.text = ""
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
