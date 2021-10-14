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
    @IBOutlet weak var displayNameLabel: UILabel!
    
    // MARK: - Properties
    var userController: UserController?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let userController = userController,
              let user = userController.user
        else {
            print("Error: UserController has not been instantiated")
            return
        }
        displayNameLabel.text = user.displayName
    }
    
    // MARK: - Actions
    @IBAction func logoutButtonTapped(_ sender: Any) {
        AuthController.signOut()
        let storyboard = UIStoryboard(name: AppConstants.mainStoryboardFileName, bundle: Bundle.main)
        let loginNavigationController = storyboard
            .instantiateViewController(identifier: AppConstants.loginNavigationControllerID)
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?
            .changeRootViewController(loginNavigationController)
    }
}
