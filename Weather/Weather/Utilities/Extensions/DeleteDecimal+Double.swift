//
//  DeleteDecimal+Double.swift
//  Weather
//
//  Created by Emre Tanrısever on 11.07.2024.
//

import Foundation

extension Double {
    
    var deleteDecimal: String {
        String(format: "%0.f", self)
    }
}
