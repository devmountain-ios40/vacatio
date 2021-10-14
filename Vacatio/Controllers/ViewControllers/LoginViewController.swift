//
//  LoginViewController.swift
//  Vacatio
//
//  Created by Stephen Davis on 9/15/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var enterPhoneNumberTextField: UITextField!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Actions
    @IBAction func continueButtonIsTapped(_ sender: UIButton) {
        // TODO: For now, Assumes the number is a U.S. number.
        var phoneNumber = "+1\(enterPhoneNumberTextField.text ?? "")"
        
        // WARNING: This should ONLY execute when the "development" scheme is set.
        if Environment.inDevelopmentEnvironment() {
            // This is ONLY for testing! It's assumed this number has been set in the Auth Emulator.
            Auth.auth().settings?.isAppVerificationDisabledForTesting = true
            if phoneNumber == "+1" { phoneNumber = "+11234567890" }
        }
        
        AuthController.verifyPhoneNumber(phoneNumber) { result in
            switch result {
                case .success(let message):
                    print(message)
                    let storyboard = UIStoryboard(name: AppConstants.mainStoryboardFileName, bundle: Bundle.main)
                    let viewController = storyboard
                        .instantiateViewController(withIdentifier:AppConstants.verificationViewControllerID)
                        as! VerificationViewController
                    self.navigationController?.pushViewController(viewController, animated: true)
                case .failure(let authErrorCode):
                    // TODO: The following Firebase AuthErrorCodes need to be handled differently.
                    switch authErrorCode {
                        case .missingPhoneNumber:
                            // FIRAuthErrorCodeMissingPhoneNumber: Indicates that a phone number
                            // was not provided.
                            break
                        case .invalidPhoneNumber:
                            // FIRAuthErrorCodeInvalidPhoneNumber: Indicates that the phone number
                            // provided is invalid.
                            break
                        case .captchaCheckFailed:
                            // FIRAuthErrorCodeCaptchaCheckFailed: Indicates that thereCAPTCHA
                            // token obtained by the Firebase Auth is invalid or has expired.
                            break
                        case .quotaExceeded:
                            // FIRAuthErrorCodeQuotaExceeded: Indicates that the phone
                            // verification quota for this project has been exceeded.
                            break
                        default:
                            break
                    }
            }
        }
    }
}
