//
//  Todo.swift
//  TodoAPP_project
//
//  Created by Bowon Han on 11/26/23.
//


import Foundation

struct Todo : Codable {
    let id : Int
    var title : String
    var description : String?
    var endDate : Date?
    var isFinished : Bool?
    
    var memberId : Int?
    var memberEmail : String?
    var memberPassword : String?
}




