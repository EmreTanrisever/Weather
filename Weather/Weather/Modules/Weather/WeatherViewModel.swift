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
    var weatherForecastImages: [Data] { get set }
    var today: Daily? { get set }
    var location: WeatherLocationResponse? { get set }
    
    func viewDidLoad()
    func fetchWeatherData(apiKey: String, location: [String: Double])
    func numberOfRowsInSection() -> Int
    func returnTodayImage() -> Data?
    func returnLocation(apiKey: String, location: [String: Double])
    func returnLocationTitle() -> String
}

final class WeatherViewModel {
    private let view: WeatherViewControllerProtocol?
    private let weatherService = WeatherService()
    
    var daily: [Daily] = []
    var hourly: [Hourly] = []
    var weatherForecastImages: [Data] = []
    var today: Daily?
    var location: WeatherLocationResponse?
    
    init(view: WeatherViewControllerProtocol?) {
        self.view = view
    }
}

extension WeatherViewModel: WeatherViewModelProtocol {
    
    
    func viewDidLoad() {
        view?.setTitle(title: "weatherApp")
    }
    
    func fetchWeatherData(apiKey: String, location: [String: Double]) {
        getWeatherData(apiKey: apiKey, location: location)
    }
    
    func numberOfRowsInSection() -> Int {
        daily.count
    }
    
    func returnTodayImage() -> Data? {
        weatherForecastImages.first
    }
    
    func returnLocation(apiKey: String, location: [String : Double]) {
        fetchLocation(apiKey: apiKey, location: location)
    }
        
    func returnLocationTitle() -> String {
        (location?.name ?? "") + ", " + (location?.sys.country ?? "") 
    }
}

extension WeatherViewModel {
    
    private func getWeatherData(apiKey: String, location: [String: Double]) {
        view?.startSpinnerAnimation()
        weatherService.getWeatherForecast(apiKey: apiKey, location: location) { [weak self] result in
            switch result {
            case let .success(weather):
                DispatchQueue.main.async {
                    self?.daily = weather.daily
                    self?.hourly = weather.hourly
                    self?.today = self?.daily.first
                    self?.fetchIcon()
                    self?.daily.removeFirst()
                    self?.view?.stopSpinnerAnimation()
                    self?.view?.reloadTableView()
                }
            case let .failure(err):
                print(err)
            }
        }
    }
    
    private func fetchIcon() {
        view?.startSpinnerAnimation()
        for day in self.daily {
            for weather in day.weather {
                weatherService.getWeatherIcon(icon: weather.icon) { [weak self] result in
                    switch result {
                    case let .success(data):
                        self?.weatherForecastImages.append(data)
                        self?.view?.stopSpinnerAnimation()
                        self?.view?.reloadTableView()
                    case let .failure(err):
                        print(err)
                    }
                }
            }
        }
    }
    
    private func fetchLocation(apiKey: String, location: [String : Double]) {
        view?.startSpinnerAnimation()
        weatherService.getLocation(apiKey: apiKey, location: location) { [weak self] result in
            switch result {
            case let .success(location):
                self?.view?.stopSpinnerAnimation()
                self?.location = location
                self?.view?.reloadTableView()
            case let .failure(err):
                print(err)
            }
        }
    }
}
