//
//  AddTaskViewController.swift
//  tomato-do
//
//  Created by Иван Лазарев on 01/05/2017.
//  Copyright © 2017 Иван Лазарев. All rights reserved.
//

import UIKit
import CoreData
import FMMoveTableView
import AVFoundation


class AddTaskViewController: UIViewController {

    lazy var endPlayer: AVAudioPlayer = {
        return try? AVAudioPlayer(contentsOf: R.file.endClockSoundMp3()!)
        }()!

    @IBOutlet weak var addTaskTextField: UITextField!
    @IBOutlet weak var addTaskTableView: FMMoveTableView!
    @IBOutlet weak var pomodoroCollectionView: MiniPomodoroCollectionView!

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        updateMiniPomodoros()
        navigationController?.restUI()
        CoreDataManager.shared.downloadFromCoreData()
        addTaskTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(onPomodoroPeriodFinished), name: .pomodoroPeriodFinished, object: nil)
        addTaskTableView.contentInset.top = 20
        view.backgroundColor = UIColor.Tomatodo.blue
        addTaskTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Add a to-do", comment: "Add a to-do"), attributes: [NSForegroundColorAttributeName: UIColor.Tomatodo.grey])
        addTaskTextField.inputAccessoryView = PomodoroCountPickerView()
    }

    func setTask(at indexPath: IndexPath, completed: Bool) {
        let task = CoreDataManager.shared.tasks[indexPath.row]
        CoreDataManager.shared.updateCheckBox(indexPath.row, value: completed)
        var newIndex: Int!
        if completed {
            newIndex = CoreDataManager.shared.moveCompletedTask(indexPath.row)
        } else {
            newIndex = CoreDataManager.shared.moveСancelExecutionTask(indexPath.row)
        }
        let newIndexPath = IndexPath(row: newIndex, section: 0)
        let cell = addTaskTableView.cellForRow(at: indexPath) as! TableViewCell
        cell.configure(with: task)
        addTaskTableView.moveRow(at: indexPath, to: newIndexPath)
    }

    func updateMiniPomodoros() {
        if let currentPeriodPosition = State.shared.currentPeriodPosition, !State.shared.isRestTime {
            pomodoroCollectionView.configure(plannedCount: Int(Settings.shared.targetPomodoros), finishedCount: Int(State.shared.currentPomodoroIndex), animatedIndex: Int(State.shared.currentPomodoroIndex), currentTime: currentPeriodPosition, totalDuration: TimeInterval(State.shared.periodDuration))
        } else {
            pomodoroCollectionView.configure(plannedCount: Int(Settings.shared.targetPomodoros), finishedCount: Int(State.shared.currentPomodoroIndex))
        }
    }

    func onPomodoroPeriodFinished() {
        endPlayer.play()
        addTaskTableView.reloadData()
        checkWorkingDayEnded()
    }

    func checkWorkingDayEnded() {
        if State.shared.currentPomodoroIndex == Settings.shared.targetPomodoros && State.shared.isRestTime {
            let alertController = UIAlertController(title: NSLocalizedString("Reached Daily Goal", comment: "Reached Daily Goal"), message: NSLocalizedString("You've completed your target for the daty! Congratulations!", comment: "You've completed your target for the daty! Congratulations."), preferredStyle: .alert)
            let action = UIAlertAction(title: NSLocalizedString("Ok", comment: "Ok"), style: .destructive, handler: nil)
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
    }

    func openPomodoroViewController(for task: Task) {
        let controller = R.storyboard.main.pomodoroViewController()!
        controller.task = task
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
}


extension AddTaskViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.taskCell)
        let task = CoreDataManager.shared.tasks[indexPath.row]
        cell?.delegate = self
        cell?.configure(with: task)

        return cell!
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.shared.tasks.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = CoreDataManager.shared.tasks[indexPath.row]
        openPomodoroViewController(for: task)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let edit =  UITableViewRowAction(style: .default, title: "Edit") { _, indexPath in
            let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
            cell.enterEditMode()
            tableView.setEditing(false, animated: true)
        }
        let delete = UITableViewRowAction(style: .default, title: "Delete") { _, indexPath in
            CoreDataManager.shared.deleteTask(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        edit.backgroundColor = UIColor.Tomatodo.darkBlue
        delete.backgroundColor = UIColor.Tomatodo.orange
        return [delete, edit]
    }
}


extension AddTaskViewController: TableViewCellDelegate {

    func tableViewCell(_ cell: TableViewCell, didChangeLabelText text: String, didChangePomodoroIndex plannedPomodoro: Int) {
        guard let indexPath = addTaskTableView.indexPath(for: cell) else {
            return
        }
        CoreDataManager.shared.updateTaskAt(indexPath.row, text: text, plannedPomodoro: plannedPomodoro)
        addTaskTableView.reloadRows(at: [indexPath], with: .fade)
    }

    func tableViewCell(_ cell: TableViewCell, didChangeCheckBox value: Bool) {
        guard let indexPath = addTaskTableView.indexPath(for: cell) else {
            return
        }
        setTask(at: indexPath, completed: value)
    }

    func tableViewCellDidTapPomodoroButton(_ cell: TableViewCell) {
        guard let indexPath = addTaskTableView.indexPath(for: cell) else {
            return
        }
        let task = CoreDataManager.shared.tasks[indexPath.row]
        openPomodoroViewController(for: task)
    }
}


extension AddTaskViewController: FMMoveTableViewDataSource, FMMoveTableViewDelegate {
    func moveTableView(_ tableView: FMMoveTableView!, moveRowFrom fromIndexPath: IndexPath!, to toIndexPath: IndexPath!) {
        guard fromIndexPath.row != toIndexPath.row else {
            return
        }
        CoreDataManager.shared.rearrange(from: fromIndexPath.row, to: toIndexPath.row)
        addTaskTableView.moveRow(at: fromIndexPath, to: toIndexPath)
        addTaskTableView.reloadData()
    }
}


extension AddTaskViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard textField.text?.isEmpty == false else {
            return
        }
        let index = NSIndexPath(row: 0, section: 0)
        let pomodoroCountPickerView = textField.inputAccessoryView as! PomodoroCountPickerView
        CoreDataManager.shared.addTask(taskToDo: (textField.text)!, plannedPomodoro: pomodoroCountPickerView.value)
        pomodoroCountPickerView.value = 1
        textField.text = ""

        addTaskTableView.insertRows(at: [index as IndexPath], with: .fade)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


extension AddTaskViewController: PomodoroViewControllerDelegate {
    func pomodoroViewController(_ controller: PomodoroViewController, didComplete task: Task) {
        let taskIndex = CoreDataManager.shared.tasks.index(of: task)
        let indexPath = IndexPath(row: taskIndex!, section: 0)
        let cell = addTaskTableView.cellForRow(at: indexPath) as! TableViewCell
        cell.checkBox.setOn(true, animated: true)
    }
}
