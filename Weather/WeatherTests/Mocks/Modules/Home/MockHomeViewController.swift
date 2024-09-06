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
    
    var invokedConfigureAnimation = false
    var invokedConfigureAnimationCount = 0
    func configureAnimation(animationName: String) {
        invokedConfigureAnimation = true
        invokedConfigureAnimationCount = 1
    }
    
    var invokedPlayAnimation = false
    var invokedPlayAnimationCount = 0
    func playAnimation() {
        invokedPlayAnimation = true
        invokedPlayAnimationCount = 1
    }
    
    var invokedStopAnimation = false
    var invokedStopAnimationCount = 0
    func stopAnimation() {
        invokedStopAnimation = true
        invokedStopAnimationCount = 1
    }
    
    var invokedAlert = false
    var invokedAlertCount = 0
    func showAlert(type: NetworkErrors) {
        invokedAlert = true
        invokedAlertCount = 1
    }
}
