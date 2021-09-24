//
//  AccountViewController.swift
//  Vacatio
//
//  Created by Andrew Saeyang on 9/24/21.
//

import UIKit
import Firebase

class AccountViewController: UIViewController {
    
    // MARK: - Outlets
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func logoutButtonTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
        print("The Logout button was tapped from the Explore tab. Current user uid is: \(Auth.auth().currentUser?.uid ?? "not set")")
        
        // Clear phone verificationID from UserDefaults.
        UserDefaults.standard.set(nil, forKey: Constants.SMSVerificationID)
        
        let storyboard = UIStoryboard(name: Constants.mainStoryboardFileName, bundle: Bundle.main)
        let loginNavigationController = storyboard.instantiateViewController(identifier: Constants.loginNavigationControllerID)
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavigationController)
    }
    
    // MARK: - Helper Methods
    
}
