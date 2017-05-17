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

class AddTaskViewController: UIViewController, FMMoveTableViewDelegate, FMMoveTableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var addTaskTextField: UITextField!
    @IBOutlet weak var addTaskTableView: FMMoveTableView!

    @IBAction func pomodoroGoTimer(_ sender: Any) {
        let conroller = R.storyboard.main.pomodoroViewController()!
        navigationController?.pushViewController(conroller, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        CoreDataManager.shared.downloadFromCoreData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddTaskViewController()
        addTaskTextField.delegate = self
    }
    
    func setupAddTaskViewController() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func moveTableView(_ tableView: FMMoveTableView!, moveRowFrom fromIndexPath: IndexPath!, to toIndexPath: IndexPath!) {
        guard fromIndexPath.row != toIndexPath.row else {

            return
        }

        CoreDataManager.shared.rearrange(from: fromIndexPath.row, to: toIndexPath.row)
        addTaskTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.taskCell)
        let task = CoreDataManager.shared.tasks[indexPath.row]
        cell?.textLabel?.font = UIFont(name:"Courier", size:18)
        cell?.textLabel?.text = task.taskToDo

        cell?.checkBox.onTintColor = .red
        cell?.checkBox.onCheckColor = .red
        cell?.checkBox.lineWidth = 1.5

        return cell!
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return CoreDataManager.shared.tasks.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        CoreDataManager.shared.addTask(taskToDo: (textField.text)!)
        addTaskTextField.text = ""
        addTaskTableView.reloadData()
        self.view.endEditing(true)

        return true
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {

        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        CoreDataManager.shared.deleteTask(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
