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
        updateMiniPomodoros()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(onPeriodFinished), name: .pomodoroPeriodFinished, object: nil)
        navigationItem.title = task.taskToDo
        updateUIToCounters()
        unexpectedTaskTextField.inputAccessoryView = PomodoroCountPickerView()
        if let timerEndDate = State.shared.timerEndDate {
            resumeCurrentTimer(timerEndDate: timerEndDate)
        }
    }

    // MARK: - IBAction

    @IBAction func startButtonPress(_ sender: Any) {
        guard Int(task.completedPomodoro) < Constants.maximumPomodorosForTasks else {
            self.updateUIToCounters()
            let alertAction = UIAlertAction(title: NSLocalizedString("Ok", comment: "Ok"), style: .cancel, handler: nil)
            let alertController = UIAlertController(title: NSLocalizedString("Attention", comment: "Attention"), message: NSLocalizedString("A very long task, break the task into smaller", comment: "A very long task, break the task into smaller"), preferredStyle: .alert)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)

            return
        }
        startPeriod()
    }

    @IBAction func stopButtonPress(_ sender: Any) {
        let noAlertAction = UIAlertAction(title: NSLocalizedString("No", comment: "No"), style: .cancel, handler: nil)
        let yesAlertAction = UIAlertAction(title: NSLocalizedString("Yes", comment: "Yes"), style: .destructive) { action in
            State.shared.cancelPeriod()
            self.updateMiniPomodoros()
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

    func startPeriod() {
        viewClock.startClockTimer()
        State.shared.startPeriod(task: task)
        updateMiniPomodoros()
        startButton.isHidden = true
        stopButton.isHidden = false
    }

    func updateMiniPomodoros() {
        if let currentPeriodPosition = State.shared.currentPeriodPosition, !State.shared.isRestTime {
            pomodoroCollectionView.configure(plannedCount: Int(task.plannedPomodoro), finishedCount: Int(task.completedPomodoro), animatedIndex: Int(task.completedPomodoro), currentTime: currentPeriodPosition, totalDuration: TimeInterval(State.shared.periodDuration))
        } else {
            pomodoroCollectionView.configure(plannedCount: Int(task.plannedPomodoro), finishedCount: Int(task.completedPomodoro))
        }
    }

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
        autoStartRestIfNeeded()
    }

    func autoStartRestIfNeeded() {
        if State.shared.counterTimer % 2 == 0 {
            startPeriod()
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

    }


extension PomodoroViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard textField.text?.isEmpty == false else {
            return
        }
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
