//
//  MockHomeViewController.swift
//  WeatherTests
//
//  Created by Emre Tanrısever on 15.07.2024.
//

import Foundation
@testable import Weather

final class MockHomeViewController: HomeViewProtocol {
    
    var invokedConfigure = false
    var invokedConfigureCount = 0
    func configure() {
        invokedConfigure = true
        invokedConfigureCount += 1
    }
    
    var invokedPrepareLocation = false
    var invokedPrepareLocationCount = 0
    func prepareLocation() {
        invokedPrepareLocation = true
        invokedPrepareLocationCount += 1
    }
}
