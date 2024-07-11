//
//  ViewController.swift
//  Weather
//
//  Created by Emre Tanrısever on 11.07.2024.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    
    func configure()
}

final class HomeViewController: UIViewController {
    
    private lazy var viewModel = HomeViewModel(view: self)
    
    private let apiKeyTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "api_key".localized
        textField.borderStyle = .line
        textField.textAlignment = .center
        return textField
    }()
    
    private let enterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("enter".localized, for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .gray
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.viewDidLoad()
    }
}

extension HomeViewController {
    
    @objc
    private func enterButtonTapped(_ senter: UIButton) {
        guard let text = apiKeyTextField.text else { return }
        let isEmty = viewModel.checkTextField(text: text)
        let controller = WeatherViewController()
        controller.configure(apiKey: text)
        isEmty ? navigationController?.pushViewController(controller, animated: true): print("Enter a value to TextField")
    }
}

extension HomeViewController: HomeViewProtocol {
    
    func configure() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        view.addSubviews(apiKeyTextField, enterButton)
        
        apiKeyTextField.becomeFirstResponder()
        enterButton.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
        
        
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            apiKeyTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            apiKeyTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            apiKeyTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            apiKeyTextField.heightAnchor.constraint(equalToConstant: 48),
            
            enterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            enterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            enterButton.topAnchor.constraint(equalTo: apiKeyTextField.bottomAnchor, constant: 8),
            enterButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
