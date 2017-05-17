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
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var tasks: [Task] = []
    
    override func viewWillAppear(_ animated: Bool) {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "positionTask", ascending: true)]
        
        do {
            tasks = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddTaskViewController()
        addTaskTextField.delegate = self
    }
    
    func moveTableView(_ tableView: FMMoveTableView!, moveRowFrom fromIndexPath: IndexPath!, to toIndexPath: IndexPath!) {
        guard fromIndexPath.row != toIndexPath.row else {
            return
        }
        tasks.rearrange(from: fromIndexPath.row, to: toIndexPath.row)
        saveArrayInCoreData()
        addTaskTableView.reloadData()
    }

    func setupAddTaskViewController() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func saveArrayInCoreData() {
        for (index, task) in tasks.enumerated() {
            task.positionTask = Int16(index)
        }
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.taskCell)
        let task = tasks[indexPath.row]
        cell?.textLabel?.font = UIFont(name:"Courier", size:18)
        cell?.textLabel?.text = task.taskToDo

        cell?.checkBox.onTintColor = .red
        cell?.checkBox.onCheckColor = .red
        cell?.checkBox.lineWidth = 1.5

        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.saveTask(taskToDo: (textField.text)!)
        addTaskTextField.text = ""
        addTaskTableView.reloadData()
        self.view.endEditing(true)

        return true
    }
    
    func saveTask(taskToDo: String) {
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: context)
        let taskObject = NSManagedObject(entity: entity!, insertInto: context) as! Task
        taskObject.taskToDo = taskToDo
        tasks.insert(taskObject, at: 0)
        saveArrayInCoreData()
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {

        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let taskToDelete = tasks[indexPath.row]
        context.delete(taskToDelete)

        do {
            try context.save()
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } catch let error as NSError {
            print("Error: \(error), description \(error.userInfo)")
        }
    }
}
