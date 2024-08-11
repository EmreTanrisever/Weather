//
//  MockWeatherViewModel.swift
//  WeatherTests
//
//  Created by Emre Tanrısever on 16.07.2024.
//

import Foundation
@testable import Weather

final class MockWeatherViewModel: WeatherViewModelProtocol {
    var hourly: [Hourly] = []
    var spesificLocation: [String : Double] = [:]
    var daily: [Daily] = []
    var weatherForecastImages: [Data] = []
    var today: Daily?
    var location: WeatherLocationResponse?
    
    var invokedViewDidLoad = false
    var invokedViewDidLoadCount = 0
    func viewDidLoad() {
        invokedViewDidLoad = true
        invokedViewDidLoadCount = 1
    }
    
    var invokedFetchWeatherData = false
    var invokedFetchWeatherDataCount = 0
    func fetchWeatherData(location: [String : Double]) {
        invokedFetchWeatherData = true
        invokedFetchWeatherDataCount = 1
    }
    
    var invokedNumberOfRows = false
    var invokedNumberOfRowsCount = 0
    func numberOfRowsInSection() -> Int {
        invokedNumberOfRows = true
        invokedNumberOfRowsCount = 1
        return 0
    }
    
    var invokedReturnTodayImage = false
    var invokedReturnTodayImageCount = 0
    func returnTodayImage() -> String? {
        invokedReturnTodayImage = true
        invokedReturnTodayImageCount = 1
        return ""
    }
    
    var invokedReturnLocation = false
    var invokedReturnLocationCount = 0
    func returnLocation(location: [String : Double]) {
        invokedReturnLocation = true
        invokedReturnLocationCount = 1
    }
    
    var invokedReturnLocationTitle = false
    var invokedReturnLocationTitleCount = 0
    func returnLocationTitle() -> String {
        invokedReturnLocationTitle = true
        invokedReturnLocationTitleCount = 1
        return ""
    }
    
}
