//
//  TaskManager.swift
//  ToDoListApp
//
//  Created by 이대현 on 11/23/23.
//

import Foundation

class TaskManager {
    var todayTaskData: [Todo] = []
    var upcomingTaskData: [Todo] = []
    
    static let shared: TaskManager = TaskManager()
    
    private init(){}
    
    
    func fetchTaskData(key: String) -> [Todo]? {
        if let taskData = UserDefaults.standard.object(forKey: key) as? Data{
            let decoder = JSONDecoder()
            if let tasks = try? decoder.decode([Todo].self, from: taskData) {
                return tasks
            }
        }
        return nil
    }
    
    func saveTaskData(data: [Todo], key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            UserDefaults.standard.setValue(encoded, forKey: key)
        }
    }
}
