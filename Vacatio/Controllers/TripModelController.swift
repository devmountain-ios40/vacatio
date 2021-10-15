//
//  TripModelController.swift
//  Vacatio
//
//  Created by Andrew Saeyang on 10/6/21.
//

import Foundation
import CoreLocation

class TripModelController{
    
    // MARK: - Propteries
    static let shared = TripModelController()
    
    var trips: [Trip] = []
    
    ///This is sample data to use for testing
    var samepleTrips: [Trip] = [
        Trip(title: "France", startDate: Date("2020-06-06"), endDate: Date(), items:[
            Item(name: "First Item", phoneNumber: "555-555-5555", url: "www.Test.com", category: ["Cafe"], address: "12345 Apple Ave, California, WA", location: CLLocationCoordinate2D(latitude: 47.2180, longitude: -122.3383)),
            Item(name: "Second Item", phoneNumber: "555-555-5555", url: "www.Test.com", category: ["Cafe"], address: "12345 Apple Ave, California, WA", location: CLLocationCoordinate2D(latitude: 47.4180, longitude: -122.3383)),
            Item(name: "Third Item", phoneNumber: "555-555-5555", url: "www.Test.com", category: ["Cafe"], address: "12345 Apple Ave, California, WA", location: CLLocationCoordinate2D(latitude: 47.6180, longitude: -122.3383)),
            Item(name: "Fourth Item", phoneNumber: "555-555-5555", url: "www.Test.com", category: ["Cafe"], address: "12345 Apple Ave, California, WA", location: CLLocationCoordinate2D(latitude: 47.8180, longitude: -122.3383))
        ]),
        Trip(title: "Germany", startDate: Date(), endDate: Date(), items: [
            Item(name: "First Item", phoneNumber: "555-555-5555", url: "www.Test.com", category: ["Cafe"], address: "12345 Apple Ave, California, WA", location: CLLocationCoordinate2D(latitude: 47.2180, longitude: -122.3383)),
            Item(name: "Second Item", phoneNumber: "555-555-5555", url: "www.Test.com", category: ["Cafe"], address: "12345 Apple Ave, California, WA", location: CLLocationCoordinate2D(latitude: 47.4180, longitude: -122.3383)),
            Item(name: "Third Item", phoneNumber: "555-555-5555", url: "www.Test.com", category: ["Cafe"], address: "12345 Apple Ave, California, WA", location: CLLocationCoordinate2D(latitude: 47.6180, longitude: -122.3383)),
            Item(name: "Fourth Item", phoneNumber: "555-555-5555", url: "www.Test.com", category: ["Cafe"], address: "12345 Apple Ave, California, WA", location: CLLocationCoordinate2D(latitude: 47.8180, longitude: -122.3383))
        ]),
        Trip(title: "Brazil", startDate: Date(), endDate: Date(), items: [
            Item(name: "First Item", phoneNumber: "555-555-5555", url: "www.Test.com", category: ["Cafe"], address: "12345 Apple Ave, California, WA", location: CLLocationCoordinate2D(latitude: 47.2180, longitude: -122.3383)),
            Item(name: "Second Item", phoneNumber: "555-555-5555", url: "www.Test.com", category: ["Cafe"], address: "12345 Apple Ave, California, WA", location: CLLocationCoordinate2D(latitude: 47.4180, longitude: -122.3383)),
            Item(name: "Third Item", phoneNumber: "555-555-5555", url: "www.Test.com", category: ["Cafe"], address: "12345 Apple Ave, California, WA", location: CLLocationCoordinate2D(latitude: 47.6180, longitude: -122.3383)),
            Item(name: "Fourth Item", phoneNumber: "555-555-5555", url: "www.Test.com", category: ["Cafe"], address: "12345 Apple Ave, California, WA", location: CLLocationCoordinate2D(latitude: 47.8180, longitude: -122.3383))
        ]),
        Trip(title: "Switzerland", startDate: Date(), endDate: Date(), items: [
            Item(name: "First Item", phoneNumber: "555-555-5555", url: "www.Test.com", category: ["Cafe"], address: "12345 Apple Ave, California, WA", location: CLLocationCoordinate2D(latitude: 47.2180, longitude: -122.3383)),
            Item(name: "Second Item", phoneNumber: "555-555-5555", url: "www.Test.com", category: ["Cafe"], address: "12345 Apple Ave, California, WA", location: CLLocationCoordinate2D(latitude: 47.4180, longitude: -122.3383)),
            Item(name: "Third Item", phoneNumber: "555-555-5555", url: "www.Test.com", category: ["Cafe"], address: "12345 Apple Ave, California, WA", location: CLLocationCoordinate2D(latitude: 47.6180, longitude: -122.3383)),
            Item(name: "Fourth Item", phoneNumber: "555-555-5555", url: "www.Test.com", category: ["Cafe"], address: "12345 Apple Ave, California, WA", location: CLLocationCoordinate2D(latitude: 47.8180, longitude: -122.3383))
        ])
    ]
    
    // MARK: - CRUD
    func createTrip(with title: String, startDate: Date, endDate: Date){
        let newTrip = Trip(title: title, startDate: startDate, endDate: endDate)
        trips.append(newTrip)
    }
    
    func updateTrip(for trip: Trip, title: String, startDate: Date, endDate: Date){
        trip.title = title
        trip.startDate = startDate
        trip.endDate = endDate
        
    }
    
    func delete(_ trip: Trip){
        if let index = trips.firstIndex(of: trip){
            trips.remove(at: index)
        }
    }
    
} // End of class
