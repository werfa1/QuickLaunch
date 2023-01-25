//
//  Character.swift
//  QuickLaunch
//
//  Created by Pasha Otverchenko on 05.01.2023.
//

import Foundation

struct RMCharacter {
    let id       : Int
    let name     : String
    let status   : RMStatus
    let species  : String
    let location : RMLocation
    let imageUrl : String
    let episodes : [String]
}

//MARK: - Nested Typers -

struct RMLocation {
    let name: String
    let url: String
}

enum RMStatus: String {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
