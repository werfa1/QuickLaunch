//
//  RMCharacterMapper.swift
//  QuickLaunch
//
//  Created by Pasha Otverchenko on 05.01.2023.
//

import Foundation

final class RMCharacterMapper: MapperProtocol {
    
    //MARK: - Typealiases
    
    typealias TDto = RMCharacterDTO
    typealias TDomainObject = RMCharacter
    
    //MARK: - Mapping Method -
    
    func mapToDomainObject(dto: RMCharacterDTO) -> RMCharacter {
        return RMCharacter(
            id: dto.id,
            name: dto.name,
            status: getStatus(from: dto.status),
            species: dto.species,
            //location: characterLocation,
            imageUrl: dto.image,
            episodes: dto.episode)
    }
}

//MARK: - Helpers -

extension RMCharacterMapper {
    private func getStatus(from string: String) -> RMStatus {
        switch string {
        case "Alive":
            return .alive
        case "Dead":
            return .dead
        default:
            return .unknown
        }
    }
}
