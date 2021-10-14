//
//  AppConstants.swift
//  Vacatio
//
//  Created by Stephen Davis on 9/23/21.
//

import Foundation

public enum AppConstants {
    
    // MARK: - Misc
    /// The UserDefaults key used to store the Firebase phone login verificationID.
    static let authVerificationID: String = "AuthVerificationID"
    
    static let isNewUser: String = "IsNewUser"
    /**
     # Summary
     The UserDefaults key used to store the state of Vacatio profile creation.
     
     # Discussion
     If the stored value is false, then profile creation is complete. If it's true then it assumes account creation is not complete and
     the user should be prompted the next time they open the app.
     */
    static let isProfileSetupComplete: String = "IsNewUser"
    static let userIsLoggedIn: String = "UserIsLoggedIn"
    
    
    // MARK: - Storyboard Files
    static let mainStoryboardFileName: String = "Main"
    static let launchScreenStoryboardFileName: String = "LaunchScreen"
    static let loginStoryboardFileName: String = "Login"
    static let exploreStoryboardFileName: String = "Explore"
    static let tripsStoryboardFileName: String = "Trips"
    static let accountStoryboardFileName: String = "Account"
    
    
    // MARK: - Navigation controller IDs
    static let loginNavigationControllerID: String = "LoginNavigationController"
    static let verificationNavigationControllerID: String = "verificationNavigationController"
    static let exploreNavigationControllerID: String = "ExploreNavigationController"
    static let tripsNavigationControllerID: String = "TripsNavigationController"
    static let accountNavigationControllerID: String = "AccountNavigationController"
    
    
    // MARK: - View controller IDs
    static let mainTabBarControllerID: String = "MainTabBarController"
    
    // Authentication view controllers
    static let loginViewControllerID: String = "LoginViewController"
    static let verificationViewControllerID: String = "VerificationViewController"
    static let displayNameViewControllerID: String = "DisplayNameViewController"
    
    // Business view controllers
    static let exploreViewControllerID: String = "ExploreViewController"
    static let tripsViewControllerID: String = "TripsViewController"
    static let accountViewControllerID: String = "AccountViewController"
}
