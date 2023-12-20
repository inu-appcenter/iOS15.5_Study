//
//  Todo.swift
//  ToDoListApp
//
//  Created by 이대현 on 2023/11/14.
//

import Foundation

enum TodoSection: Int {
    case Today
    case Upcoming
}

struct Todo: Hashable, Codable {
    let id: String
    let name: String
    var isCompleted: Bool
    var deadLine: Date
    var content: String
    
    init(id: String,
         name: String,
         isCompleted: Bool,
         deadLine: Date,
         content: String = ""
    ) {
        self.id = id
        self.name = name
        self.isCompleted = isCompleted
        self.deadLine = deadLine
        self.content = content
    }
}

