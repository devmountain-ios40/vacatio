//
//  Environment.swift
//  Vacatio
//
//  Created by Stephen Davis on 9/24/21.
//

import Foundation

public enum Environment {
    
    // MARK: - Helper methods
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Info.plist file not found")
        }
        return dict
    }()
    
    static func getKey(_ key: String) -> String {
        guard let result = Environment.infoDictionary[key] as? String else {
            fatalError("Error: \(key) is not set in Info.plist for this environment")
        }
        return result
    }
    
    // MARK: - Info.plist mappings
    enum Keys {
        enum Plist {
            static let appEnvironment = "APP_ENVIRONMENT"
            static let googleServiceInfo = "GOOGLE_SERVICE_PLIST"
        }
    }
    
    // MARK: - Key Properties
    /// The name of the app, which depends on the environment (e.g. development, staging, production).
    static let appEnvironment: String = {
        return getKey(Keys.Plist.appEnvironment)
    }()
    
    /// GoogleService-Info.plist file name.
    static let googleServiceInfo: String = {
        return getKey(Keys.Plist.googleServiceInfo)
    }()
}

