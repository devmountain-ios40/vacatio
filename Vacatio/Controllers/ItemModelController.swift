//
//  ItemModelController.swift
//  Vacatio
//
//  Created by Andrew Saeyang on 10/6/21.
//

import Foundation
import CoreLocation

class ItemModelController{
    
    // MARK: - CRUD functions
    
    func createItem(for trip: Trip, name: String, phoneNumber: String, url: String, category: [String], address: String, location: CLLocationCoordinate2D){
        let newItem = Item(name: name, phoneNumber: phoneNumber, url: url, category: category, address: address, location: location)
        
        trip.items.append(newItem)
        
    }
    
    func update(_ item: Item, with name: String, phoneNumber: String, url: String, category: [String], address: String, location: CLLocationCoordinate2D ){
        
        item.name = name
        item.phoneNumber = phoneNumber
        item.url = url
        item.category = category
        item.address = address
        item.location = location
    }
    
    func delete(_ item: Item, from trip: Trip){
        if let index = trip.items.firstIndex(of: item){
            trip.items.remove(at: index)
        }
    }
    
}// End of class
