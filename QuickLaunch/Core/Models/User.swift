//
//  User.swift
//  QuickLaunch
//
//  Created by Pasha Otverchenko on 09.11.2022.
//

import Foundation

final class User {
    
    //MARK: - Properties -
    
    let id: Int
    let fullName: String
    let email: String
    let phone: String
    
    //MARK: - Initialisation -
    
    init(id: Int, name: String, email: String, phone: String) {
        self.id = id
        self.fullName = name
        self.email = email
        self.phone = phone
    }
}

//MARK: - Extension Variables -

extension User {
    var firstName: String {
        return fullName.components(separatedBy: " ")[0]
    }
    
    var lastName: String {
        return fullName.components(separatedBy: " ")[1]
    }
}
