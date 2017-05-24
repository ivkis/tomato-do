//
//  CoreDataManager.swift
//  tomato-do
//
//  Created by IvanLazarev on 17/05/2017.
//  Copyright © 2017 Иван Лазарев. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {

    static let shared = CoreDataManager()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private(set) var tasks = [Task]()

    func addTask(taskToDo: String) {
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: context)
        let taskObject = NSManagedObject(entity: entity!, insertInto: context) as! Task
        taskObject.taskToDo = taskToDo
        tasks.insert(taskObject, at: 0)
        saveArrayInCoreData()
    }

    func deleteTask(at index: Int) {
        let taskToDelete = tasks[index]
        context.delete(taskToDelete)

        do {
            try context.save()
            tasks.remove(at: index)
        } catch let error as NSError {
            print("Error: \(error), description \(error.userInfo)")
        }
    }

    func updateCheckBox(_ index: Int, value: Bool) {
        let checkBoxToUpdate = tasks[index]
        checkBoxToUpdate.checkBoxValue = value
        saveContext(context: context)
    }

    func moveCompletedTask(_ index: Int) {
        tasks.rearrange(from: index, to: (tasks.count)-1)
        saveArrayInCoreData()
    }

    func moveСancelExecutionTask(_ index: Int) {
        tasks.rearrange(from: index, to: 0)
        saveArrayInCoreData()
    }

    func updateTaskAt(_ index: Int, text: String) {
        let taskToUpdate = tasks[index]
        taskToUpdate.taskToDo = text
        saveContext(context: context)
    }

    func saveArrayInCoreData() {
        for (index, task) in tasks.enumerated() {
            task.positionTask = Int16(index)
        }
        saveContext(context: context)
    }

    func downloadFromCoreData() {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "positionTask", ascending: true)]

        do {
            tasks = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }

    func saveContext(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    func rearrange(from: Int, to: Int) {
        tasks.rearrange(from: from, to: to)
        saveArrayInCoreData()
    }
}
