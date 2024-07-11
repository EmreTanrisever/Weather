//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Emre Tanrısever on 11.07.2024.
//

import Foundation

protocol WeatherViewModelProtocol {
    
    func viewDidLoad()
    func fetchWeatherData(apiKey: String)
    func numberOfRowsInSection() -> Int
    func returnData() -> [Daily]
    func returnTodayData() -> Daily?
}

final class WeatherViewModel {
    private let view: WeatherViewControllerProtocol?
    private let weatherService = WeatherService()
    private var daily: [Daily] = []
    private var today: Daily?
    
    init(view: WeatherViewControllerProtocol?) {
        self.view = view
    }
}

extension WeatherViewModel: WeatherViewModelProtocol {
    
    func viewDidLoad() {
        view?.setTitle(title: "weatherApp")
    }
    
    func fetchWeatherData(apiKey: String) {
        getWeatherData(apiKey: apiKey)
    }
    
    func numberOfRowsInSection() -> Int {
        daily.count
    }
    
    func returnData() -> [Daily] {
        return daily
    }
    
    func returnTodayData() -> Daily? {
        today
    }
}

extension WeatherViewModel {
    
    private func getWeatherData(apiKey: String) {
        view?.startSpinnerAnimation()
        weatherService.getWeatherForecast(apiKey: apiKey) { [weak self] result in
            switch result {
            case let .success(weather):
                DispatchQueue.main.async {
                    self?.daily = weather.daily
                    self?.today = self?.daily.first
                    self?.daily.removeFirst()
                    self?.view?.stopSpinnerAnimation()
                    self?.view?.reloadTableView()
                }
            case let .failure(err):
                print(err)
            }
        }
    }
}
