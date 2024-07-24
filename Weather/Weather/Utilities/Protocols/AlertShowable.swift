//
//  AlertShowable.swift
//  Weather
//
//  Created by Emre Tanrısever on 22.07.2024.
//

import UIKit

protocol AlertShowable {
    func showAlert(type: NetworkErrors)
}

extension AlertShowable where Self: UIViewController {
    
    func showAlert(type: NetworkErrors) {
        DispatchQueue.main.async { [weak self] in
        let errorDescription = ErrorDescriptions()
        let alert = UIAlertController()
        
        switch type {
        case .noInternetConnection:
            alert.title = errorDescription.connectionErrorTitle
            alert.message = errorDescription.connectionErrorDescription
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
                exit(0)
            }))
        case .badRequest:
            alert.title = errorDescription.badRequestTitle
            alert.message = errorDescription.badRequestDescription
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
                exit(0)
            }))
        case .noData:
            alert.title = errorDescription.noDataErrorTitle
            alert.message = errorDescription.noDataErrorDescription
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
                
            }))
        case .decodeError:
            alert.title = errorDescription.decodeErrorTitle
            alert.message = errorDescription.decodeErrorDescription
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
                exit(0)
            }))
        }
        
        
            guard let self = self else { return }
            self.present(alert, animated: true)
        }
    }
}
