//
//  HourlyCollectionViewCellViewModel.swift
//  Weather
//
//  Created by Emre Tanrısever on 19.07.2024.
//

import Foundation

protocol HourlyCollectionViewCellViewModelProtocol {
    var icon: Data? { get set }
    
    func fetchIcon(weather: [Weather])
}

final class HourlyCollectionViewCellViewModel {
    var icon: Data?
    private weak var view: HourlyCollectionViewCellProtocol?
    
    private let weatherService = WeatherService()
    
    init(view: HourlyCollectionViewCellProtocol? = nil) {
        self.view = view
    }
    
}

extension HourlyCollectionViewCellViewModel: HourlyCollectionViewCellViewModelProtocol {
    
    func fetchIcon(weather: [Weather]) {
        for weather in weather {
            weatherService.getWeatherIcon(icon: weather.icon) { [weak self] result in
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
