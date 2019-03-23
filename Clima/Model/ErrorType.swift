//
//  Error.swift
//  Clima
//
//  Created by Alina Fesyk on 3/22/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation

enum ErrorType: CustomStringConvertible {

    case custom(message: String)
    case locationUnavailable
    case networkingError(statusCode: Int)
    case parsingError
    case locationDenied
    case locationRestricted
    
    var description: String {
        switch self {
        case .custom(let message):
            return message
        case .locationUnavailable:
            return "Location unavailable"
        case .networkingError(let code):
            return "Connetion issues: \(code)"
        case .parsingError:
            return "Weather data currently unavailable"
        case .locationDenied:
            return "Access to location denied. You can change it in 'Settings'"
        case .locationRestricted:
            return "Location services restricted"
        }
    }
}
