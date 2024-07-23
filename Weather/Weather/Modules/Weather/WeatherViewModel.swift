//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Emre Tanrısever on 11.07.2024.
//

import Foundation

protocol WeatherViewModelProtocol {
    var daily: [Daily] { get set }
    var hourly: [Hourly] { get set }
    var today: Daily? { get set }
    var location: WeatherLocationResponse? { get set }
    
    func viewDidLoad()
    func fetchWeatherData(location: [String: Double])
    func numberOfRowsInSection() -> Int
    func returnTodayImage() -> String?
    func returnLocation(location: [String: Double])
    func returnLocationTitle() -> String
}

final class WeatherViewModel {
    private let view: WeatherViewControllerProtocol?
    private let weatherService = WeatherService()
    
    var daily: [Daily] = []
    var hourly: [Hourly] = []
    var today: Daily?
    var location: WeatherLocationResponse?
    
    init(view: WeatherViewControllerProtocol?) {
        self.view = view
    }
}

extension WeatherViewModel: WeatherViewModelProtocol {
    
    func viewDidLoad() {
   
    }
    
    func fetchWeatherData(location: [String: Double]) {
        getWeatherData(location: location)
    }
    
    func numberOfRowsInSection() -> Int {
        daily.count
    }
    
    func returnTodayImage() -> String? {
        today?.weather.first?.icon
    }
    
    func returnLocation(location: [String : Double]) {
        fetchLocation(location: location)
    }
        
    func returnLocationTitle() -> String {
        (location?.name ?? "") + ", " + (location?.sys.country ?? "") 
    }
}

extension WeatherViewModel {
    
    private func getWeatherData(location: [String: Double]) {
        view?.startSpinnerAnimation()
        weatherService.getWeatherForecast(location: location) { [weak self] result in
            switch result {
            case let .success(weather):
                DispatchQueue.main.async {
                    self?.daily = weather.daily
                    self?.hourly = weather.hourly
                    self?.today = self?.daily.first
                    self?.daily.removeFirst()
                    self?.view?.stopSpinnerAnimation()
                    self?.view?.reloadTableView()
                }
            case let .failure(err):
                switch err {
                case .badRequest:
                    self?.view?.showAlert(type: .badRequest)
                case .noData:
                    self?.view?.showAlert(type: .noData)
                case .decodeError:
                    self?.view?.showAlert(type: .decodeError)
                case .noInternetConnection:
                    self?.view?.showAlert(type: .noInternetConnection)
                }
            }
        }
    }
    
    private func fetchLocation(location: [String : Double]) {
        view?.startSpinnerAnimation()
        weatherService.getLocation(location: location) { [weak self] result in
            switch result {
            case let .success(location):
                self?.view?.stopSpinnerAnimation()
                self?.location = location
                self?.view?.reloadTableView()
            case let .failure(err):
                switch err {
                case .badRequest:
                    self?.view?.showAlert(type: .badRequest)
                case .noData:
                    self?.view?.showAlert(type: .noData)
                case .decodeError:
                    self?.view?.showAlert(type: .decodeError)
                case .noInternetConnection:
                    self?.view?.showAlert(type: .noInternetConnection)
                }
            }
        }
    }
}
