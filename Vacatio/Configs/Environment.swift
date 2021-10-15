//
//  Environment.swift
//  Vacatio
//
//  Created by Stephen Davis on 9/24/21.
//

import Foundation

public enum Environment {
    // MARK: - Keys
    enum Keys {
        enum Plist {
            static let googleServiceInfo = "GOOGLE_SERVICE_PLIST"
        }
    }
    
    // MARK: - Plist dictionary reference
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Info.plist file not found")
        }
        return dict
    }()
    
    // MARK: - Plist values
    static let googleServiceInfo: String = {
        guard let googleServiceInfo = Environment.infoDictionary[Keys.Plist.googleServiceInfo] as? String else {
            fatalError("Error: is not set in Info.plist for this environment")
        }
        return googleServiceInfo
    }()
}
