//
//  TaskList.swift
//  MyTodoList
//
//  Created by 이재희 on 2023/08/11.
//

import Foundation

struct TaskList {
    
    private static let database = UserDefaults.standard
    private static let key = "TaskList"
    
    static var list: [Task] {
        get {
            if let encodedTaskList = database.object(forKey: key) as? Data,
               let taskList = try? JSONDecoder().decode([Task].self, from: encodedTaskList) {
                return taskList
            }
            return []
        }
        set {
            if let encodedTaskList = try? JSONEncoder().encode(newValue) {
                database.set(encodedTaskList, forKey: key)
            }
        }
    }
    
    static var doneList: [Task] {
        return list.filter { $0.isDone }
    }
    
    static func updateIsDone(id: UUID, isDone: Bool) {
        if let index = list.firstIndex(where: { $0.id == id }) {
            list[index].isDone = isDone
            saveList()
        }
    }
    
    static func updateTask(id: UUID, title: String, date: Date) {
        if let index = list.firstIndex(where: { $0.id == id }) {
            var updatedTask = list[index]
            let (dateOnly, timeOnly) = Calendar.current.splitDateAndTime(from: date)
            updatedTask.title = title
            updatedTask.dueDate = dateOnly
            updatedTask.time = timeOnly
            list[index] = updatedTask
            saveList()
        }
    }
    
    static func deleteTask(id: UUID) {
        list.removeAll { $0.id == id }
        saveList()
    }
    
    private static func saveList() {
        if let encodedTaskList = try? JSONEncoder().encode(list) {
            database.set(encodedTaskList, forKey: key)
        }
    }
    
}
