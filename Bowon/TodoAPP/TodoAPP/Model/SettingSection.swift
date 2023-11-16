//
//  SettingSection.swift
//  TodoUI
//
//  Created by Bowon Han on 11/7/23.
//

import UIKit

struct SettingSection : Codable {
    var list : [TodoListModel]
    let sectionName : String
}

struct TodoListModel : Codable {
    var success : Bool = false
    let todoNameLabel : String
    let startDate : Date?
    let deadlineDate : Date?
}
