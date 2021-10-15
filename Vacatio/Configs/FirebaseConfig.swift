//
//  FirebaseConfig.swift
//  Vacatio
//
//  Created by Stephen Davis on 10/14/21.
//

import Firebase

class FirebaseConfig {
    
    /**
     # Summary
     Handles all of the Google Firebase configuration stuff.
     */
    static func setup() {
        // MARK: - Configure GoogleService-Info.plist
        let googleServicePlistFilePath = Bundle.main
            .path(forResource: Environment.googleServiceInfo, ofType: "plist")
        guard let firebaseOptions = FirebaseOptions(contentsOfFile: googleServicePlistFilePath!)
        else { assert(false, "Error: couldn't load config \(Environment.googleServiceInfo) file") }
        
        // TODO: set api rules to mitigate problems described in the following links:
        // - https://firebase.google.com/docs/projects/api-keys#apply-restrictions-password-based-auth
        // - https://developers.google.com/maps/api-security-best-practices#restrict_apikey
        // - https://stackoverflow.com/questions/37482366/is-it-safe-to-expose-firebase-apikey-to-the-public
        // - https://jsmobiledev.com/article/hide-firebase-api/
        // - https://firebase.google.com/support/guides/security-checklist
        // - https://medium.com/@eclipse0xe/securing-firebase-api-keys-e316a481dd51
        // - https://cloud.google.com/functions/docs/configuring/secrets
        FirebaseApp.configure(options: firebaseOptions)
        
        // MARK: - Firebase Development setup
        if Environment.inDevelopmentEnvironment() {
            // TODO: This needs to be tested more before it's ready to be uncommented.
            //setupFirestoreEmulator()
            setupAuthEmulator()
        }
    }
    
    /**
     # Summary
     This function configures the app to use the Firebase Emulator Suite.
     
     # Declaration
     ```
     func setupFirebaseFirestoreEmulator() -> Void
     ```
     
     # Discussion
     This setup function configures both the Firestore and Functions emulators. However, the Auth emulator is managed
     separately by the function ``setupFirebaseAuthEmulator()``.
     */
    static func setupFirestoreEmulator() {
        guard let authPort = Int(Environment.firebaseEmulatorFirestorePort) else {
            fatalError("Error: something when wrong with retrieving the Firebase Firestore Emulator port number")
        }
        
        let settings = Firestore.firestore().settings
        settings.host = "\(Environment.firebaseEmulatorURL):\(authPort)"
        settings.isPersistenceEnabled = false
        settings.isSSLEnabled = false
        Firestore.firestore().settings = settings
        
        print("""
        🔥 Connected to Firebase Firestore Emulator, running at: \
        http://\(Environment.firebaseEmulatorURL):\(authPort)
        """)
    }
    
    /**
     # Summary
     This function configures the app to use the Firebase Auth Emulator.
     
     # Declaration
     ```
     func setupFirebaseAuthEmulator() -> Void
     ```
     
     # Discussion
     This setup function instructs this app to use the Firebase Auth emulator. By default it is running on `localhost` at
     port `9099`. To initialize the other Firebase emulators run the function ``setupFirebaseFirestoreEmulator()``.
     
     # Important
     To change the default port that the Auth emulator listens on, modify the following JSON in the `firebase.json`
     file in the root of this project:
     
     ```json
     "emulators": {
     ...
     "auth": {
     "port": 9099
     },
     ...
     ```
     */
    static func setupAuthEmulator() {
        guard let authPort = Int(Environment.firebaseEmulatorAuthPort) else {
            fatalError("Error: something when wrong with retrieving the Firebase Auth Emulator port number")
        }
        Auth.auth().useEmulator(withHost: Environment.firebaseEmulatorURL, port: authPort)
        
        print("""
        👤 Connected to Firebase Auth Emulator, running at: \
        http://\(Environment.firebaseEmulatorURL):\(authPort)
        """)
    }
}
