//
//  UserService.swift
//  QuickLaunch
//
//  Created by Pasha Otverchenko on 04.01.2023.
//

import Foundation

protocol UserServiceProtocol {
    func fetchUsers() async throws -> [User]
}

final class UserService: UserServiceProtocol {
    
    //MARK: - Fields -
    
    private let userMapper: UserMapper
    
    //MARK: - Initialisation -
    
    init() {
        userMapper = UserMapper()
    }
}

//MARK: - Fetch Method -

extension UserService {
    func fetchUsers() async throws -> [User] {
        guard let urlString = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            return []
        }
        do {
            let (jsonData, _) = try await URLSession.shared.data(from: urlString)
            let userDtoList = try JSONDecoder().decode([UserDTO].self, from: jsonData)
            return userDtoList.map{ self.userMapper.mapToDomainObject(dto: $0) }
        } catch {
            //TODO: throw an actual error
            return []
        }
    }
}
