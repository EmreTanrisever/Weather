//
//  HomeViewModel.swift
//  Weather
//
//  Created by Emre Tanrısever on 11.07.2024.
//

import Foundation

protocol HomeViewModelProtocol {
    
    func viewDidLoad()
    func checkTextField(text: String) -> Bool
    func addLocation(lat: Double, lon: Double)
    func returnLocation() -> [String: Double]
}

final class HomeViewModel {
    private weak var view: HomeViewProtocol?
    private var location: [String: Double] = [:]
    
    init(view: HomeViewProtocol? = nil) {
        self.view = view
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    
    func viewDidLoad() {
        view?.configure()
        view?.prepareLocation()
    }
    
    func checkTextField(text: String) -> Bool {
        if text.isEmpty {
            return false
        }
        return true
    }
    
    func addLocation(lat: Double, lon: Double) {
        location["lat"] = lat
        location["lon"] = lon
    }
    
    func returnLocation() -> [String : Double] {
        return location
    }
}
