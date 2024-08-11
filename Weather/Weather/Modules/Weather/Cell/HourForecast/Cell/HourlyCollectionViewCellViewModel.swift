//
//  HourlyCollectionViewCellViewModel.swift
//  Weather
//
//  Created by Emre Tanrısever on 19.07.2024.
//

import Foundation

protocol HourlyCollectionViewCellViewModelProtocol {
    var icon: String? { get set }
    
    func fetchIcon(weather: [Weather])
}

final class HourlyCollectionViewCellViewModel {
    var icon: String?
    private weak var view: HourlyCollectionViewCellProtocol?
    
    private let weatherService = WeatherService(networkManager: NetworkManager.shared)
    
    init(view: HourlyCollectionViewCellProtocol? = nil) {
        self.view = view
    }
    
}

extension HourlyCollectionViewCellViewModel: HourlyCollectionViewCellViewModelProtocol {
    
    func fetchIcon(weather: [Weather]) {
        for weather in weather {
            icon = ImageManager.shared.returnWeatherImage(imageName: weather.icon)
            view?.fillImage()
        }
    }
    
    
}
