//
//  TaskList.swift
//  MyTodoList
//
//  Created by 이재희 on 2023/08/11.
//

import UIKit
import CoreData

let imageNames = ["Image 2", "Image 4", "Image 5", "Image 6", "Image 7"]

class TaskList {
    
    static let shared = TaskList()
    
    var context: NSManagedObjectContext
    
    private init() {
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func fetchTasks() -> [Task]? {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        do {
            let tasks = try context.fetch(fetchRequest)
            return tasks
        } catch {
            print("Error fetching tasks: \(error)")
            return nil
        }
    }
    
    func addTask(title: String, image: String?, isDone: Bool, dueDate: Date, time: Date) {
        let newTask = Task(context: context)
        newTask.id = UUID()
        newTask.title = title
        newTask.image = image ?? imageNames.randomElement()
        newTask.isDone = isDone
        newTask.dueDate = dueDate
        newTask.time = time
        
        saveContext()
    }
    
    func updateTask(task: Task, title: String, dueDate: Date) {
        task.title = title
        task.dueDate = dueDate
        saveContext()
    }
    
    func deleteTask(task: Task) {
        context.delete(task)
        saveContext()
    }
    
    private func saveContext() {
        do {
            try context.save()
            print("-------saved----------")
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    static var doneList: [Task] {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        request.predicate = NSPredicate(format: "isDone == true")
        do {
            let tasks = try shared.context.fetch(request)
            return tasks
        } catch {
            fatalError("Unresolved error \(error), \(error.localizedDescription)")
        }
    }

    static func updateIsDone(task: Task, isDone: Bool) {
        task.isDone = isDone
        shared.saveContext()
    }
}
