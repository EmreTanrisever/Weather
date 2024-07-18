//
//  WeatherCellViewModel.swift
//  Weather
//
//  Created by Emre Tanrısever on 17.07.2024.
//

import Foundation

protocol WeatherCellViewModelProtocol {
    var daily: Daily? { get set }
    var images: Data? { get set }
    func fetchImage()
}

final class WeatherCellViewModel: WeatherCellViewModelProtocol {
    var daily: Daily?
    var images: Data?
    private weak var view: WeatherTableViewCellProtocol?
    
    private let weatherService = WeatherService()

    init(view: WeatherTableViewCellProtocol? = nil) {
        self.view = view
    }
    
    func fetchImage() {
        guard let weather = daily?.weather else { return }
        for weather in weather {
            weatherService.getWeatherIcon(icon: weather.icon) { [weak self] result in
                switch result {
                case let .success(data):
                    self?.images = data
                    self?.view?.showImage()
                case let .failure(err):
                    print(err)
                }
            }
        }
    }
}
