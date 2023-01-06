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
        //let characterLocation = RMLocation(name: dto.location.name, url: dto.location.url)
        return RMCharacter(
            id: dto.id,
            name: dto.name,
            status: dto.status,
            species: dto.species,
            //location: characterLocation,
            imageUrl: dto.image,
            episodes: dto.episode)
    }
}
