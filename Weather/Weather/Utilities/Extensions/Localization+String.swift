//
//  String+Localization.swift
//  Weather
//
//  Created by Emre Tanrısever on 11.07.2024.
//

import Foundation

extension String {
    
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
