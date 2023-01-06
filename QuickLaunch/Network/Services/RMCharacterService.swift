//
//  RMCharacterService.swift
//  QuickLaunch
//
//  Created by Pasha Otverchenko on 05.01.2023.
//

import Foundation

protocol RMCharacterServiceProtocol {
    func fetchCharacters() async throws -> [RMCharacter]
}

final class RMCharacterService: RMCharacterServiceProtocol {
    
    //MARK: - Services -
    
    private let characterMapper: RMCharacterMapper
    
    //MARK: - Initialisation -
    
    init() {
        characterMapper = RMCharacterMapper()
    }
}

//MARK: - Fetch Method -

extension RMCharacterService {
    func fetchCharacters() async throws -> [RMCharacter] {
        // Fetch only 18 characters
        guard let urlString = URL(string:"https://rickandmortyapi.com/api/character/1,18") else { return [] }
        
        do {
            let (jsonData, _) = try await URLSession.shared.data(from: urlString)
            let characterDTOs = try JSONDecoder().decode([RMCharacterDTO].self, from: jsonData)
            return characterDTOs.map{ self.characterMapper.mapToDomainObject(dto: $0) }
        } catch {
            return []
        }
    }
}
