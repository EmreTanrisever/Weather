//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Emre Tanrısever on 11.07.2024.
//

import Foundation

protocol WeatherViewModelProtocol {
    
    func viewDidLoad()
    func fetchWeatherData(apiKey: String, location: [String: Double])
    func numberOfRowsInSection() -> Int
    func returnData() -> [Daily]
    func returnTodayData() -> Daily?
    func returnTodayImage() -> Data?
    func returnImages() -> [Data]?
    func returnLocation(apiKey: String, location: [String: Double])
    func returnLocationTitle() -> String
}

final class WeatherViewModel {
    private let view: WeatherViewControllerProtocol?
    private let weatherService = WeatherService()
    private var daily: [Daily] = []
    private var today: Daily?
    private var imageDatas: [Data] = []
    private var location: WeatherLocationResponse?
    
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
    
    func returnData() -> [Daily] {
        daily
    }
    
    func returnTodayData() -> Daily? {
        today
    }
    
    func returnTodayImage() -> Data? {
        imageDatas.first
    }
    
    func returnImages() -> [Data]? {
        return imageDatas
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
                    self?.today = self?.daily.first
                    self?.fetchIcon()
                    self?.daily.removeFirst()
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
                        self?.imageDatas.append(data)
                    case let .failure(err):
                        print(err)
                    }
                }
            }
        }
        view?.stopSpinnerAnimation()
        view?.reloadTableView()
    }
    
    private func fetchLocation(apiKey: String, location: [String : Double]) {
        weatherService.getLocation(apiKey: apiKey, location: location) { [weak self] result in
            switch result {
            case let .success(location):
                self?.location = location
            case let .failure(err):
                print(err)
            }
        }
    }
}
