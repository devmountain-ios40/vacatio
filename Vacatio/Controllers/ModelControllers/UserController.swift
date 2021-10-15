//
//  UserController.swift
//  Vacatio
//
//  Created by Stephen Davis on 10/14/21.
//

import Firebase

protocol UserService {
    func createUser(firebaseUser: Firebase.User, isNew: Bool)
    func updateUser(displayName: String)
    func completeProfileSetup()
}

class UserController: UserService {
    var user: User?
    var isNewUser: Bool?
    
    func createUser(firebaseUser: Firebase.User, isNew: Bool = false) {
        self.user = User(firebaseUser: firebaseUser)
        self.isNewUser = isNew
    }

    /**
     # Summary
     This controller method updates the properties of a ``User`` object.
     
     # Discussion
     Firebase's `createProfileChangeRequest` must be called in order to change the profile information of a
     `Firebase.User`.
     
     For reference on how to use `createProfileChangeRequest` see:
     [User.createProfileChangeRequest](https://firebase.google.com/docs/reference/swift/firebaseauth/api/reference/Classes/User#createprofilechangerequest)
     */
    func updateUser(displayName: String) {
        Auth.auth().addStateDidChangeListener { _, firebaseUser in
            guard let firebaseUser = firebaseUser,
                  var user = self.user else { return }
            
            user.displayName = displayName
            self.user = user
            
            let changeRequest: UserProfileChangeRequest = firebaseUser.createProfileChangeRequest()
            changeRequest.displayName = (user.displayName ?? "")
                .condenseWhitespace().trimmingCharacters(in: .whitespaces)
            changeRequest.commitChanges { error in
                if let error = error {
                    print(error)
                    return
                }
            }
        }
    }
    
    func completeProfileSetup() {
        UserDefaults.standard.setValue(true, forKey: AppConstants.isProfileSetupComplete)
    }
    
    func isProfileSetupComplete() -> Bool {
        return UserDefaults.standard.bool(forKey: AppConstants.isProfileSetupComplete)
    }
}
