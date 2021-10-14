//
//  ViewController.swift
//  Vacatio
//
//  Created by Stephen Davis on 9/15/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var enterPhoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func continueButtonIsTapped(_ sender: UIButton) {
        // TODO: For now, Assumes the number is a U.S. number.
        var phoneNumber = "+1\(enterPhoneNumberTextField.text ?? "")"
        
        // WARNING: This should ONLY execute when the "development" scheme is set.
        if Environment.inDevelopmentEnvironment() {
            // This is ONLY for testing! It's assumed this number has been set in the Auth Emulator.
            Auth.auth().settings?.isAppVerificationDisabledForTesting = true
            if phoneNumber == "+1" { phoneNumber = "+11234567890" }
        }
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
            if let error = error {
                let authError = error as NSError
                print("Error: could not verify phone number: \(authError): \(authError.localizedDescription)")
                return
            }
            
            guard let verificationID = verificationID else {
                print ("Error: could not generate verification ID")
                return
            }
            
            UserDefaults.standard.set(verificationID, forKey: Constants.SMSVerificationID)
            
            let storyBoard: UIStoryboard = UIStoryboard(name: Constants.mainStoryboardFileName, bundle: Bundle.main)
            let viewController = storyBoard.instantiateViewController(withIdentifier: Constants.smsVerificationViewControllerID)
                as! SMSVerificationViewController
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
