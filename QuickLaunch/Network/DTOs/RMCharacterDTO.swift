//
//  RMCharacterDTO.swift
//  QuickLaunch
//
//  Created by Pasha Otverchenko on 05.01.2023.
//

import Foundation

struct RMCharacterDTO: Decodable {
    let id      : Int
    let name    : String
    let status  : String
    let species : String
    let type    : String
    let gender  : String
    let origin  : RMLocationDTO
    let location: RMLocationDTO
    let image   : String
    let episode : [String]
    let url     : String
    let created : String
}

//MARK: - Nested Types -

struct RMLocationDTO: Decodable {
    let name: String
    let url: String
}
