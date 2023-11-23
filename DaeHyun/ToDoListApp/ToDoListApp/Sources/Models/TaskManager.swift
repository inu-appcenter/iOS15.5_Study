//
//  TaskManager.swift
//  ToDoListApp
//
//  Created by 이대현 on 11/23/23.
//

import Foundation

class TaskManager {
    var todayTaskData: [Task] = []
    var upcomingTaskData: [Task] = []
    
    static let shared: TaskManager = TaskManager()
    
    private init(){}
    
    
    func fetchTaskData(key: String) -> [Task]? {
        if let taskData = UserDefaults.standard.object(forKey: key) as? Data{
            let decoder = JSONDecoder()
            if let tasks = try? decoder.decode([Task].self, from: taskData) {
                return tasks
            }
        }
        return nil
    }
    
    func saveTaskData(data: [Task], key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            UserDefaults.standard.setValue(encoded, forKey: key)
        }
    }
}
