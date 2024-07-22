//
//  MockMapView.swift
//  WeatherTests
//
//  Created by Emre Tanrısever on 21.07.2024.
//

import Foundation
@testable import Weather

final class MockMapView: MapViewControllerProtocol {
    
    var invokedConfigure: Bool = false
    var invokedConfigureCount = 0
    
    func configure() {
        invokedConfigure = true
        invokedConfigureCount = 1
    }
}
