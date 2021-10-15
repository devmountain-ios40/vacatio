//
//  AuthController.swift
//  Vacatio
//
//  Created by Stephen Davis on 10/14/21.
//

import Firebase

class AuthController {
    
    static func verifyPhoneNumber(_ phoneNumber: String, completion: @escaping (Result<String, AuthErrorCode>) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
            if let error = error as NSError? {
                if let errorCode = AuthErrorCode(rawValue: error.code) {
                    completion(.failure(errorCode))
                }
            }
            
            guard let validVerificationID = verificationID else {
                return completion(.failure(.missingVerificationID))
            }
            storeAuthVerificationID(validVerificationID)
            
            completion(.success("Successfully generated a verification ID"))
        }
    }
    
    /**
     This saves the Auth Verfication ID to local persistent app storage so that it
     can be recalled when the user leaves the app to get the SMS TOTP.
     
     # TODO
     Replace with secure form of local persistence storage, such Keychain.
     See: https://developer.apple.com/documentation/security/certificate_key_and_trust_services/keys/storing_keys_in_the_keychain
     */
    static func storeAuthVerificationID(_ verificationID: String) {
        UserDefaults.standard.set(verificationID, forKey: AppConstants.authVerificationID)
    }
    
    func signIn(with verificationCode: String, completion: @escaping (Result<AuthDataResult, AuthErrorCode>) -> Void) {
        guard let verificationID = UserDefaults.standard.string(forKey: AppConstants.authVerificationID)
        else { return completion(.failure(.missingVerificationID)) }
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: verificationCode
        )
        
        Auth.auth().signIn(with: credential) { authDataResult, error in
            if let error = error as NSError? {
                if let errorCode = AuthErrorCode(rawValue: error.code) {
                    // TODO: This needs to be handled.
                    completion(.failure(errorCode))
                }
            }
            
            guard let authDataResult = authDataResult else { return }
            completion(.success(authDataResult))
        }
    }
    
    static func signOut() {
        let fireBaseAuth = Auth.auth()
        do {
            try fireBaseAuth.signOut()
            UserDefaults.standard.setValue(nil, forKey: AppConstants.userIsLoggedIn)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    static func persistUserLogin() {
        UserDefaults.standard.setValue(true, forKey: AppConstants.userIsLoggedIn)
    }
    
    /**
     Defaults to `false` if the key doesn't exist.
     
     See ``UserDefaults.standard.bool``
     
     # TODO
     Needs to be changed to a more secure form of persistant storage such as keychain.
     */
    static func userIsLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: AppConstants.userIsLoggedIn)
    }
    
}
