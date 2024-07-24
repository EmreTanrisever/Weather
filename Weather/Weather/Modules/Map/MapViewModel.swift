//
//  MapViewModel.swift
//  Weather
//
//  Created by Emre Tanrısever on 17.07.2024.
//

import Foundation

protocol MapViewModelProtocol {
    var coordinate: Coord? { get set }
    
    func viewDidLoad()
}

final class MapViewModel {
    private weak var view: MapViewControllerProtocol?
    private let weatherService = WeatherService()
    var coordinate: Coord?
    
    init(view: MapViewControllerProtocol? = nil) {
        self.view = view
    }
}

extension MapViewModel: MapViewModelProtocol {
    
    func viewDidLoad() {
        view?.configure()
    }
    
    func fetchCountryData(text: String) {
        weatherService.getCountryData(text: text) { [weak self] result in
            switch result {
            case let .success(weather):
                self?.coordinate = weather.coord
                self?.view?.showSearchedLocationWeather()
            case let .failure(err):
                switch err {
                case .badRequest:
                    self?.view?.showAlert(type: .badRequest)
                case .noData:
                    self?.view?.showAlert(type: .noData)
                case .decodeError:
                    self?.view?.showAlert(type: .noData)
                case .noInternetConnection:
                    self?.view?.showAlert(type: .noInternetConnection)
                }
            }
        }
    }
}
