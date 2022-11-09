//
//  UserDTO.swift
//  QuickLaunch
//
//  Created by Pasha Otverchenko on 09.11.2022.
//

import Foundation

struct UserDTO: Decodable {
    let id: Int
    let name: String
    let email: String
    let phone: String
}
