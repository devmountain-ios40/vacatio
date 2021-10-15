//
//  DisplayNameViewController.swift
//  Vacatio
//
//  Created by Stephen Davis on 10/14/21.
//

import Firebase

class DisplayNameViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var displayNameTextField: UITextField!
    
    // MARK: - Properties
    var userController: UserController?
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let displayName = displayNameTextField.text ?? ""
        
        guard let userController = userController else { return }
        userController.updateUser(displayName: displayName)
        
        if userController.isProfileSetupComplete() {
            let storyboard = UIStoryboard(name: AppConstants.accountStoryboardFileName, bundle: Bundle.main)
            let viewController = storyboard
                .instantiateViewController(withIdentifier: AppConstants.accountViewControllerID)
                    as! AccountViewController
            viewController.userController = userController
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            let storyboard = UIStoryboard(name: AppConstants.mainStoryboardFileName, bundle: Bundle.main)
            let mainTabBarController = storyboard.instantiateViewController(withIdentifier: AppConstants.mainTabBarControllerID)
            userController.completeProfileSetup()
            AuthController.persistUserLogin()
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?
                .changeRootViewController(mainTabBarController)
        }
    }
}
