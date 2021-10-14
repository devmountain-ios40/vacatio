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
            static let cloudKitContainer = "CLOUDKIT_CONTAINER"
            static let googleServiceInfo = "GOOGLE_SERVICE_PLIST"
            static let firebaseEmulatorURL = "FIREBASE_EMULATOR_URL"
            static let firebaseEmulatorAuthPort = "FIREBASE_EMULATOR_AUTH_PORT"
            static let firebaseEmulatorAuthProjectID = "FIREBASE_EMULATOR_AUTH_PROJECT_ID"
            static let firebaseEmulatorFirestorePort = "FIREBASE_EMULATOR_FIRESTORE_PORT"
        }
    }
    
    // MARK: - Key Properties
    /**
     # Summary
     Tests whether the app enviroment is "Development".
     
     - Returns: `true` if the Xcode scheme is in Development, `false` otherwise.
     */
    static func inDevelopmentEnvironment() -> Bool {
        return getKey(Keys.Plist.appEnvironment) == "development"
    }
    
    static let cloudKitContainer: String = {
        print("CLOUDKIT_CONTAINER: \(getKey(Keys.Plist.googleServiceInfo))")
        return getKey(Keys.Plist.cloudKitContainer)
    }()
    
    /// GoogleService-Info.plist file name.
    static let googleServiceInfo: String = {
        return getKey(Keys.Plist.googleServiceInfo)
    }()

    /// The base URL for the Firebase Auth Emulator. This should be set to `localhost`. To change this value edit the
    /// `firebase.json` file. Remember to edit the value in ``Development.xcconfig`` as well
    static let firebaseEmulatorURL: String = {
        return getKey(Keys.Plist.firebaseEmulatorURL)
    }()
    
    /// The port that the Firebase Auth Emulator is listening on. The default is `9099`. To change this value edit the
    /// `firebase.json` file. Remember to edit the value in ``Development.xcconfig`` as well.
    static let firebaseEmulatorAuthPort: String = {
        return getKey(Keys.Plist.firebaseEmulatorAuthPort)
    }()
    
    /**
     # Summary
     The project ID that the Firebase Auth Emulator is using. To point the Auth Emulator at a different project ID, `cd` into this
     project's directory and run the following command from the terminal:
     
     ```
     $ firebase use <project-id>`
     ```
     > _Replace `<project-id>` with the name of your desired Firebase project ID_.
     > For example: `firebase use vacatio-development`
     
     # Important
     Remember to edit the value in ``Development.xcconfig`` as well.
     */
    static let firebaseEmulatorAuthProjectID: String = {
        return getKey(Keys.Plist.firebaseEmulatorAuthProjectID)
    }()
    
    /// The port that the Firebase Firestore Emulator is listening on. The default is `8080`. To change this value edit the
    /// `firebase.json` file. Remember to edit the value in ``Development.xcconfig`` as well.
    static let firebaseEmulatorFirestorePort: String = {
        return getKey(Keys.Plist.firebaseEmulatorAuthPort)
    }()
}
