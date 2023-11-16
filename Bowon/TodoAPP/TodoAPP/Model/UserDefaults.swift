//
//  UserDefaults.swift
//  todoAPP
//
//  Created by Bowon Han on 11/16/23.
//

import Foundation

class SaveData {
    static let shared = SaveData()
    
    var dataSource : [SettingSection] = []
    
    private init() {}

    func saveAllData() {
        let userDefaults = UserDefaults.standard

        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(dataSource){
            userDefaults.set(encoded, forKey: "todoList")
        }
    }
            
    func loadAllData() {
        let userDefaults = UserDefaults.standard
            
        if let savedData = userDefaults.object(forKey: "todoList") as? Data{
            let decoder = JSONDecoder()
            if let savedObject = try? decoder.decode([SettingSection].self, from: savedData){
                dataSource = savedObject
                print(dataSource)
            }
        }
    }
}
