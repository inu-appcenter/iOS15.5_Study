//
//  TodoRequestDTO.swift
//  ToDoListApp
//
//  Created by 이대현 on 11/30/23.
//

import Foundation

struct TodoRequestDTO: Codable {
    let content: String
    let deadLine: String
    let title: String
}
