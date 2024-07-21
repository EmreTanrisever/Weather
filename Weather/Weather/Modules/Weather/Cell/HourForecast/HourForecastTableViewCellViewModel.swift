//
//  Hoırlyviewmode.swift
//  Weather
//
//  Created by Emre Tanrısever on 19.07.2024.
//

import Foundation

protocol HourForecastTableViewCellViewModelProtocol {
    var hourly: [Hourly] { get set }
    
    func numberOfItemsInSection() -> Int
}

final class HourForecastTableViewCellViewModel {
    var hourly: [Hourly] = []
}

extension HourForecastTableViewCellViewModel: HourForecastTableViewCellViewModelProtocol {
    
    func numberOfItemsInSection() -> Int {
        hourly.count
    }
}
