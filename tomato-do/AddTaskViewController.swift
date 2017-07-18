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


class AddTaskViewController: UIViewController {

    @IBOutlet weak var addTaskTextField: UITextField!
    @IBOutlet weak var addTaskTableView: FMMoveTableView!

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        navigationController?.restUI()
        CoreDataManager.shared.downloadFromCoreData()
        addTaskTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        cell.enterEditMode()
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        CoreDataManager.shared.deleteTask(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
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
        let controller = R.storyboard.main.pomodoroViewController()!
        controller.task = task
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
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
