//
//  Task.swift
//  ToDoListApp
//
//  Created by 이대현 on 2023/11/14.
//

import Foundation

enum TaskSection: Int {
    case Today
    case Upcoming
}

struct Task: Hashable, Codable {
    let id: String
    let name: String
    var isCompleted: Bool
    var deadLine: Date
    init(id: String, name: String, isCompleted: Bool, deadLine: Date) {
        self.id = id
        self.name = name
        self.isCompleted = isCompleted
        self.deadLine = deadLine
    }
}

