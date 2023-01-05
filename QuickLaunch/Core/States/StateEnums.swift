//
//  SwitchStateEnum.swift
//  QuickLaunch
//
//  Created by Pasha Otverchenko on 04.01.2023.
//

import Foundation

/// Enum that represents if *anything  (e.g. loader, error view, etc)* should be switched on or off
public enum SwitchState {
    case on
    case off
}

/// Enum that represents different web request results. Used for UI
public enum LoadedState {
    /// Request was successful and data is received
    case successfullyLoaded
    
    /// Request failed with error
    case failed
    
    /// Request was successful but no data is received
    case zeroData
}
