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

    func addTask(taskToDo: String, plannedPomodoro: Int) {
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: context)
        let taskObject = NSManagedObject(entity: entity!, insertInto: context) as! Task
        taskObject.taskToDo = taskToDo
        taskObject.plannedPomodoro = Int64(plannedPomodoro)
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

    func moveCompletedTask(_ index: Int) -> Int {
        let newIndex = (tasks.count) - 1
        tasks.rearrange(from: index, to: newIndex)
        saveArrayInCoreData()
        return newIndex
    }

    func moveСancelExecutionTask(_ index: Int) -> Int {
        let newIndex = 0
        tasks.rearrange(from: index, to: newIndex)
        saveArrayInCoreData()
        return newIndex
    }

    func updateTaskAt(_ index: Int, text: String, plannedPomodoro: Int) {
        let taskToUpdate = tasks[index]
        taskToUpdate.taskToDo = text
        taskToUpdate.plannedPomodoro = Int64(plannedPomodoro)
        saveContext(context: context)
    }

    func incrementCompletedPomodoros(for task: Task) {
        task.completedPomodoro += 1
        saveContext(context: context)
    }

    func getTaskById(_ objectId: String) -> Task? {
        guard let uri = URL(string: objectId), let objectID = context.persistentStoreCoordinator!.managedObjectID(forURIRepresentation: uri) else {
            return nil
        }
        do {
            return try context.existingObject(with: objectID) as? Task
        } catch {
            return nil
        }
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
