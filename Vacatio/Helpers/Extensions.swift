//
//  Extensions.swift
//  Vacatio
//
//  Created by Andrew Saeyang on 10/14/21.
//

import Foundation

///This exenstion lets us manually put in a date.
extension Date{
    init(_ dateString:String){
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let date = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:date)
    }
} // End of Extension
