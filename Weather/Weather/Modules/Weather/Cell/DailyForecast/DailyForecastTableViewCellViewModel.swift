//
//  DailyForecastTableViewCellViewModel.swift
//  Weather
//
//  Created by Emre Tanrısever on 19.07.2024.
//

import Foundation

protocol DailyForecastTableViewCellViewModelProtocol {
    var icon: Data? { get set }
    var daily: Daily? { get set }
    func fetch()
}

final class DailyForecastTableViewCellViewModel {
    private var weatherService = WeatherService()
    private var view: DailyForecastTableViewCellProtocol?
    
    var icon: Data?
    var daily: Daily?
    
    init(view: DailyForecastTableViewCellProtocol? = nil) {
        self.view = view
    }
}

extension DailyForecastTableViewCellViewModel: DailyForecastTableViewCellViewModelProtocol {
    
    func fetch() {
        guard let weather = daily?.weather else { return }
        for weather in weather {
            self.weatherService.getWeatherIcon(icon: weather.icon) { [weak self] result in
                switch result {
                case let .success(iconData):
                    self?.icon = iconData
                    self?.view?.fillImage()
                case let .failure(err):
                    print(err)
                }
            }
        }
    }
}

