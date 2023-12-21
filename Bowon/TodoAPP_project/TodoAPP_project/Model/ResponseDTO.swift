//
//  ResponseDTO.swift
//  TodoAPP_project
//
//  Created by Bowon Han on 12/21/23.
//

import Foundation

struct ResponseDTO : Decodable {
    let id : Int
    let title : String
    let description : String
    let isFinished : Bool
}
