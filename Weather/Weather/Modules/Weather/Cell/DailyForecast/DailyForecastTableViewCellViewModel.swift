//
//  DailyForecastTableViewCellViewModel.swift
//  Weather
//
//  Created by Emre Tanrısever on 19.07.2024.
//

import Foundation

protocol DailyForecastTableViewCellViewModelProtocol {
    var icon: String? { get set }
    var daily: Daily? { get set }
    func fetch()
}

final class DailyForecastTableViewCellViewModel {
    private var weatherService = WeatherService()
    private var view: DailyForecastTableViewCellProtocol?
    
    var icon: String?
    var daily: Daily?
    
    init(view: DailyForecastTableViewCellProtocol? = nil) {
        self.view = view
    }
}

extension DailyForecastTableViewCellViewModel: DailyForecastTableViewCellViewModelProtocol {
    
    func fetch() {
        guard let weather = daily?.weather else { return }
        for weather in weather {
            self.icon = ImageManager.shared.returnWeatherImage(imageName: weather.icon)
            view?.fillImage()
        }
    }
}

