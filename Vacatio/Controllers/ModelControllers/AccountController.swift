//
//  AccountController.swift
//  Vacatio
//
//  Created by Erik Jimenez on 9/30/21.
//

import Foundation


struct CLB {
    var name: String
    var body: String
}

class CLBController {
    
    static public var allCLB: [CLB] {
        
        let contact = CLB(name: "Contact", body: "Insert contact body here")
        
        let privacy = CLB(name: "Privacy", body: "Insert privacy body here")
        
        let aboutUs = CLB(name: "About Us", body: "Insert about us body here")
        
        return [contact, privacy, aboutUs]
    }
}
// create an update views func in the Account View Controller to call and display CLB
