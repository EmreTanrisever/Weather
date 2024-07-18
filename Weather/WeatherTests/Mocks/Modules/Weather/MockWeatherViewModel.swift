//
//  MockWeatherViewModel.swift
//  WeatherTests
//
//  Created by Emre Tanrısever on 16.07.2024.
//

import Foundation
@testable import Weather

final class MockWeatherViewModel: WeatherViewModelProtocol {
    var daily: [Daily] = []
    var weatherForecastImages: [Data] = []
    var today: Daily?
    var location: WeatherLocationResponse?
    
    
    var invokedViewDidLoad = false
    var invokedViewDidLoadCount = 0
    func viewDidLoad() {
        invokedViewDidLoad = true
        invokedViewDidLoadCount += 1
    }
    
    var invokedFetchWeatherData = false
    var invokedFetchWeatherDataCount = 0
    func fetchWeatherData(apiKey: String, location: [String : Double]) {
        invokedFetchWeatherData = true
        invokedFetchWeatherDataCount += 1
    }
    
    var invokedNumberOfRowsInSection = false
    var invokedNumberOfRowsInSectionCount = 0
    func numberOfRowsInSection() -> Int {
        invokedNumberOfRowsInSection = true
        invokedNumberOfRowsInSectionCount += 1
        return 0
    }
    
    var invokedReturnTodayData = false
    var invokedReturnTodayDataCount = 0
    func returnTodayData() -> Daily? {
        invokedReturnTodayData = true
        invokedReturnTodayDataCount += 1
        return nil
    }
    
    var invokedReturnTodayImage = false
    var invokedReturnTodayImageCount = 0
    func returnTodayImage() -> Data? {
        invokedReturnTodayImage = true
        invokedReturnTodayImageCount += 1
        return nil
    }
    
    var invokedReturnImages = false
    var invokedReturnImagesCount = 0
    func returnImages() -> [Data]? {
        invokedReturnImages = true
        invokedReturnImagesCount += 1
        return nil
    }
    
    var invokedReturnLocation = false
    var invokedReturnLocationCount = 0
    func returnLocation(apiKey: String, location: [String : Double]) {
        invokedReturnLocation = true
        invokedReturnLocationCount += 1
    }
    
    var invokedReturnLocationTitle = false
    var invokedReturnLocationTitleCount = 0
    func returnLocationTitle() -> String {
        invokedReturnLocationTitle = true
        invokedReturnLocationTitleCount += 1
        return ""
    }
}
