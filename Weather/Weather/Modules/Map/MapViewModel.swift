//
//  MapViewModel.swift
//  Weather
//
//  Created by Emre Tanrısever on 17.07.2024.
//

import Foundation

protocol MapViewModelProtocol {

    func viewDidLoad()
}

final class MapViewModel {
    private var view: MapViewControllerProtocol?
    
    init(view: MapViewControllerProtocol? = nil) {
        self.view = view
    }
}

extension MapViewModel: MapViewModelProtocol {
    
    func viewDidLoad() {
        view?.configure()
    }
}
