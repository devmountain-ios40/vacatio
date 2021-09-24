//
//  Constants.swift
//  Vacatio
//
//  Created by Stephen Davis on 9/23/21.
//

import Foundation

public enum Constants {
    /// The UserDefaults key used to store the Firebase phone login verificationID.
    static let SMSVerificationID: String = "SMSVerificationID"
    
    // MARK: - Storyboard IDs
    static let mainStoryboardFileName: String = "Main"
    static let loginNavigationControllerID: String = "LoginNavigationController"
    static let smsVerificationViewControllerID: String = "SMSVerificationViewController"
    static let mainTabBarControllerID: String = "MainTabBarController"
}
