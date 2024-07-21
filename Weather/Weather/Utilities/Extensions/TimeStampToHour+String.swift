//
//  TimeStamp+String.swift
//  Weather
//
//  Created by Emre Tanrısever on 19.07.2024.
//

import Foundation

extension Double {
    
    var getHour: String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let hourString = dateFormatter.string(from: date)
        return hourString
    }
}
