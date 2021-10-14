//
//  ConfigError.swift
//  Vacatio
//
//  Created by Stephen Davis on 10/14/21.
//

import Foundation

enum ConfigError: LocalizedError {
    case ckError(Error)
    case couldNotUnwrap
    case noConfig
    
    var errorDescription: String? {
        switch self {
            case .ckError(let error):
                return "Error: \(error): \(error.localizedDescription)"
            case .couldNotUnwrap:
                return "Error: could not unwrap Secret info from CloudKit"
            case .noConfig:
                return "Error: unable to retrieve config; it does not exist"
        }
    }
}
