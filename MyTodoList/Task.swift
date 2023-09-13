//
//  Task.swift
//  MyTodoList
//
//  Created by 이재희 on 2023/08/11.
//

import Foundation

let imageNames = ["Image 2", "Image 4", "Image 5", "Image 6", "Image 7"]

struct Task: Codable {
    var id = UUID()
    var title: String
    var image = imageNames.randomElement()
    var isDone = false
    var dueDate: Date
    var time: Date
}
