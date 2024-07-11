//
//  HomeViewModel.swift
//  Weather
//
//  Created by Emre Tanrısever on 11.07.2024.
//

import Foundation

protocol HomeViewModelProtocol {
    
    func viewDidLoad()
}

final class HomeViewModel {
    private weak var view: HomeViewProtocol?
    
    init(view: HomeViewProtocol? = nil) {
        self.view = view
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    
    func viewDidLoad() {
        view?.configure()
    }
    
    func checkTextField(text: String) -> Bool {
        if text.isEmpty {
            return false
        }
        return true
    }
}
