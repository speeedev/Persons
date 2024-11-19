//
//  URLErrors.swift
//  Persons
//
//  Created by Emir Bolat on 19.11.2024.
//

import Foundation

enum ValidationError: LocalizedError {
    case invalidEmailURL
    case invalidPhoneURL
    case invalidWebsiteURL
    case invalidCoordinates
    case cannotOpenURL
    
    var errorDescription: String? {
        switch self {
        case .invalidEmailURL:
            return "invalidEmailURL"
        case .invalidPhoneURL:
            return "invalidPhoneURL"
        case .invalidWebsiteURL:
            return "invalidWebsiteURL"
        case .invalidCoordinates:
            return "invalidCoordinates"
        case .cannotOpenURL:
            return "cannotOpenURL"
        }
    }
}
