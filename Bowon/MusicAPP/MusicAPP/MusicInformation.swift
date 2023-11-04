//
//  Model.swift
//  MusicAPP
//
//  Created by Bowon Han on 11/2/23.
//

import Foundation

struct MusicService: Codable {
    let resultCount : Int
    let results : [Music]
}

struct Music: Codable {
    let imageName : String
    
    enum CodingKeys: String, CodingKey {
        case imageName = "artworkUrl100"
    }
}


