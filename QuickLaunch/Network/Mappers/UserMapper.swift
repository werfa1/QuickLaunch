//
//  UserMapper.swift
//  QuickLaunch
//
//  Created by Pasha Otverchenko on 04.01.2023.
//

import Foundation

final class UserMapper: MapperProtocol {
    
    //MARK: - Typealiases -
    
    typealias TDto = UserDTO
    typealias TDomainObject = User
    
    //MARK: - Mapping Method -
    
    func mapToDomainObject(dto: UserDTO) -> User {
        return User(
            id: dto.id,
            name: dto.name,
            email: dto.email,
            phone: dto.email)
    }
}
