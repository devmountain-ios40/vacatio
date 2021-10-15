//
//  User.swift
//  Vacatio
//
//  Created by Stephen Davis on 10/14/21.
//

import Firebase

struct User {
    private(set) var uid: String? = nil
    var displayName: String? = nil
    
    init() {}
    
    init(firebaseUser: Firebase.User) {
        self.uid = firebaseUser.uid
    }
}
