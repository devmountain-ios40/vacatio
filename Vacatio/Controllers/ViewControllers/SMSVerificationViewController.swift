//
//  VerificationCodeViewController.swift
//  Vacatio
//
//  Created by Stephen Davis on 9/23/21.
//

import UIKit
import Firebase

class SMSVerificationViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var verificationCodeTextField: UITextField!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func confirmButtonTapped(_ sender: Any) {
        //        guard let verificationID = verificationID,
        //              !verificationID.isEmpty
        //        else { return }
        
        let testVerificationCode: String = "123456"
        guard let verificationID = UserDefaults.standard.string(forKey: Constants.SMSVerificationID) else { return }
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: testVerificationCode
        )
        
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print("Error: could not sign in: \(error): \(error.localizedDescription)")
                return
            }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabBarController = storyboard.instantiateViewController(identifier: Constants.mainTabBarControllerID)
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        }
    }
}
