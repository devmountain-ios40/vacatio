//
//  VerificationViewController.swift
//  Vacatio
//
//  Created by Stephen Davis on 9/23/21.
//

import UIKit
import Firebase

class VerificationViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var verificationCodeTextField: UITextField!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func confirmButtonTapped(_ sender: Any) {
        var verificationCode = verificationCodeTextField.text ?? ""
        
        // WARNING: This should ONLY execute when the "development" scheme is set.
        if Environment.inDevelopmentEnvironment() && verificationCode == "" {
            verificationCode = VerificationCodeController.shared.getVerificationCodeFromAuthEmulator()
        }
        
        let authController = AuthController()
        authController.signIn(with: verificationCode) { result in
            switch result {
                case .success(let authDataResult):
                    guard let additionalUserInfo = authDataResult.additionalUserInfo else { return }
                    let firebaseUser = authDataResult.user
                    let userController = UserController()
                    userController.createUser(firebaseUser: firebaseUser, isNew: additionalUserInfo.isNewUser)
                    
                    guard let isNewUser = userController.isNewUser
                    else { fatalError("Error: UserController.isNewUser has not been instantiated") }

                    let storyboard = UIStoryboard(name: AppConstants.mainStoryboardFileName, bundle: Bundle.main)
                    if isNewUser || !userController.isProfileSetupComplete() {
                        let viewController = storyboard
                            .instantiateViewController(withIdentifier: AppConstants.displayNameViewControllerID)
                            as! DisplayNameViewController
                        
                        viewController.userController = userController
                        
                        self.navigationController?.pushViewController(viewController, animated: true)
                    } else {
                        let mainTabBarController = storyboard
                            .instantiateViewController(withIdentifier: AppConstants.mainTabBarControllerID)
                        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?
                            .changeRootViewController(mainTabBarController)
                        
                        AuthController.persistUserLogin()
                    }
                case .failure(let authErrorCode):
                    // TODO: The following Firebase AuthErrorCodes need to be handled differently.
                    switch authErrorCode {
                        case .missingVerificationCode,.missingVerificationID:
                            // FIRAuthErrorCodeMissingVerificationCode: Indicates that the phone
                            // auth credential was created with an empty verification code.
                            
                            // FIRAuthErrorCodeMissingVerificationID: Indicates that the phone
                            // auth credential was created with an empty verification ID.
                            break
                        case .invalidCredential,.invalidVerificationCode,.invalidVerificationID:
                            // FIRAuthErrorCodeInvalidCredential: Indicates the supplied credential
                            // is invalid. This could happen if it has expired or it is malformed.
                            
                            // FIRAuthErrorCodeInvalidVerificationCode: Indicates that the phone
                            // auth credential was created with an invalid verification Code.
                            
                            // FIRAuthErrorCodeInvalidVerificationID: Indicates that the phone
                            // auth credential was created with an invalid verification ID.
                            break
                        case .userDisabled:
                            // FIRAuthErrorCodeUserDisabled: Indicates the user's account is disabled.
                            break
                        case .operationNotAllowed:
                            // FIRAuthErrorCodeOperationNotAllowed: Indicates that accounts with
                            // the identity provider represented by the credential are not enabled.
                            // Enable them in the Auth section of the Firebase console.
                            break
                        case .sessionExpired:
                            // FIRAuthErrorCodeSessionExpired: Indicates that the SMS code has expired.
                            break
                        default:
                            break
                    }
            }
        }
    }
}
