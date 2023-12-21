//
//  TodoResponseDTO.swift
//  ToDoListApp
//
//  Created by 이대현 on 11/29/23.
//

import Foundation

struct TodoResponseDTO: Decodable {
    var id: Int
    var title: String
    var isCompleted: Bool
    var deadLine: String
    var content: String
    
    func toTodo() -> Todo {
        return Todo(id: String(self.id), 
                    name: self.title,
                    isCompleted: self.isCompleted,
                    deadLine: self.deadLineDate,
                    content: self.content
        )
    }
    
    var deadLineDate: Date {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ko-KR")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            if let date = dateFormatter.date(from: self.deadLine) {
                return date
            } else { return Date() }
            
        }
    }
}
