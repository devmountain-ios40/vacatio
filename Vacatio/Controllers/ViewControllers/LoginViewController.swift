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
//        guard
//            let phoneNumber = enterPhoneNumberTextField.text,
//            !phoneNumber.isEmpty
//        else { return }
        
        // XXX: This is ONLY for testing!
        let testPhoneNumber: String = "+11234567890"
        
        #if DEBUG
            Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        #endif
        
        PhoneAuthProvider.provider().verifyPhoneNumber(testPhoneNumber, uiDelegate: nil) { verificationID, error in
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
