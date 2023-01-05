//
//  MapperInterface.swift
//  QuickLaunch
//
//  Created by Pasha Otverchenko on 04.01.2023.
//

import Foundation

protocol MapperProtocol{
    associatedtype TDto
    associatedtype TDomainObject
    
    func mapToDomainObject(dto: TDto) -> TDomainObject
}
