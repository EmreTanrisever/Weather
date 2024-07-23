//
//  TodayForecastTableViewCellViewModel.swift
//  Weather
//
//  Created by Emre Tanrısever on 23.07.2024.
//

import Foundation

protocol TodayForecastTableViewCellViewModelProtocol {
    var view: TodayForecastTableViewCellProtocol? { get set }
    var today: [Weather]? { get set }
    
    func changeUI()
    func returnDate() -> String
}

final class TodayForecastTableViewCellViewModel {
    weak var view: TodayForecastTableViewCellProtocol?
    var today: [Weather]? = []
    
    init(view: TodayForecastTableViewCellProtocol? = nil) {
        self.view = view
    }
}

extension TodayForecastTableViewCellViewModel: TodayForecastTableViewCellViewModelProtocol {
    
    func changeUI() {
        view?.changeUI()
    }
    
    func returnDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy "
        return formatter.string(from: date)
    }
}
