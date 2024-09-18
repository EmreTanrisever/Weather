//
//  MockWeatherViewController.swift
//  WeatherTests
//
//  Created by Emre Tanrısever on 15.07.2024.
//

import Foundation
@testable import Weather

final class MockWeatherViewController: WeatherViewControllerProtocol {
    
    var invokedConfigure = false
    var invokedConfigureCount = 0
    func configure(location: [String : Double]?, from isDetail: Bool) {
        invokedConfigure = true
        invokedConfigureCount += 1
    }
    
    var invokedStartSpinnerAnimation = false
    var invokedStartSpinnerAnimationCount = 0
    func startSpinnerAnimation() {
        invokedStartSpinnerAnimation = true
        invokedStartSpinnerAnimationCount += 1
    }
    
    var invokedStopSpinnerAnimation = false
    var invokedStopSpinnerAnimationCount = 0
    func stopSpinnerAnimation() {
        invokedStopSpinnerAnimation = true
        invokedStopSpinnerAnimationCount += 1
    }
    
    var invokedReloadTableView = false
    var invokedReloadTableViewCount = 0
    func reloadTableView() {
        invokedReloadTableView = true
        invokedReloadTableViewCount += 1
    }
    
    var invokedSetTitle = false
    var invokedSetTitleCount = 0
    func setTitle(title: String) {
        invokedSetTitle = true
        invokedSetTitleCount = 1
    }
    
    var invokedStopRefreshing = false
    var invokedStoprefreshingCount = 0
    func stopRefreshing() {
        invokedStopRefreshing = true
        invokedStoprefreshingCount = 1
    }
    
    var invokedShowAlert = false
    var invokedShowAlertCount = 0
    func showAlert(type: NetworkErrors) {
        invokedShowAlert = true
        invokedShowAlertCount = 1
    }
    
    var invokedShowLocationPersmissionView = false
    var invokedShowLocationPersmissionViewCount = 0
    func showLocationPermissionView() {
        invokedShowLocationPersmissionView = true
        invokedShowLocationPersmissionViewCount = 1
    }
    
    var invokedShowWeatherView = false
    var invokedShowWeatherViewCount = 0
    func showWeatherView() {
        invokedShowWeatherView = true
        invokedShowWeatherViewCount = 1
    }
    
    var invokedHideWeatherView = false
    var invokedHideWeatherViewCount = 0
    func hideWeatherView() {
        invokedHideWeatherView = true
        invokedHideWeatherViewCount = 1
    }
    
    var invokedHideLocationPermission = false
    var invokedHideLocationPermissionCount = 0
    func hideLocationPermissionView() {
        invokedHideLocationPermission = true
        invokedHideLocationPermissionCount = 1
    }
}
