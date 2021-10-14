//
//  FirebaseDevConfig.swift
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
    }
}
