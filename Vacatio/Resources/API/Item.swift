//
//  Item.swift
//  Vacatio
//
//  Created by Andrew Saeyang on 10/6/21.
//

import Foundation
import CoreLocation

class Item{
    var name: String
    var phoneNumber: String
    var url: String
    var category: [String]
    var address: String
    var location: CLLocationCoordinate2D
    let uuid: String
    
    
    init(name: String, phoneNumber: String, url: String, category:[String], address: String, location: CLLocationCoordinate2D, uuid: String = UUID().uuidString){
        self.name = name
        self.phoneNumber = phoneNumber
        self.url = url
        self.category = category
        self.address = address
        self.location = location
        self.uuid = uuid
        
    }
    
    
}// End of class

extension Item:Equatable{
    
    static func == (lhs: Item, rhs: Item ) -> Bool{
        
        return lhs.uuid == rhs.uuid
        
    }
}// End of Extension
