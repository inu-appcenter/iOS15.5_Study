//
//  SettingSection.swift
//  TodoUI
//
//  Created by Bowon Han on 11/7/23.
//

import UIKit

struct SettingSection {
    var list : [TodoListModel]
    let sectionName : String
}

struct TodoListModel {
    let todoNameLabel : String?
}
