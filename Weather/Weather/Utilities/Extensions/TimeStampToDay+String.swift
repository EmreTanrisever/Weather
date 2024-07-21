//
//  TimeStamp+String.swift
//  Weather
//
//  Created by Emre Tanrısever on 11.07.2024.
//

import Foundation

extension Double {
    
    var getDay: String {
        let date = NSDate(timeIntervalSince1970: self)
        let strDate = "\(date)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss +HHmm"
        if let formatedDate = dateFormatter.date(from: strDate) {
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "EEEE"
            let day = dayFormatter.string(from: formatedDate)
            return day
        }
        return "Empty"
    }
}
