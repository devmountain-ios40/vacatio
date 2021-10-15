//
//  Trip.swift
//  Vacatio
//
//  Created by Andrew Saeyang on 10/6/21.
//

import Foundation

class Trip{
    
    var title: String
    var startDate: Date
    var endDate: Date
    var items: [Item]
    let uuid: String
    
    init(title: String, startDate: Date, endDate: Date, items: [Item] = [], uuid: String = UUID().uuidString ) {
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.items = items
        self.uuid = uuid
        
    }
}// End of class

extension Trip: Equatable{
    
    static func == (lhs: Trip , rhs: Trip ) -> Bool{
        
        return lhs.uuid == rhs.uuid
        
    }
}// End of Extension
