//
//  WeatherViewController.swift
//  Weather
//
//  Created by Emre Tanrısever on 11.07.2024.
//

import UIKit

protocol WeatherViewControllerProtocol: AnyObject {
    func configure(apiKey: String, location: [String: Double])
    func startSpinnerAnimation()
    func stopSpinnerAnimation()
    func reloadTableView()
    func setTitle(title: String)
}

final class WeatherViewController: UIViewController {
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private lazy var weatherTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.weatherTableViewIdentifier)
        tableView.rowHeight = 40
        return tableView
    }()
    
    lazy var viewModel: WeatherViewModelProtocol = WeatherViewModel(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
}

// MARK: - WeatherViewController extension
extension WeatherViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            weatherTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            weatherTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - WeatherViewControllerProtocol
extension WeatherViewController: WeatherViewControllerProtocol {
    
    func configure(apiKey: String, location: [String: Double]) {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        viewModel.fetchWeatherData(apiKey: apiKey, location: location)
        viewModel.returnLocation(apiKey: apiKey, location: location)
        
        view.addSubviews(weatherTableView, spinner)
        setConstraints()
    }
    
    func startSpinnerAnimation() {
        DispatchQueue.main.async {
            self.spinner.startAnimating()
        }
    }
    
    func stopSpinnerAnimation() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
        }
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.weatherTableView.reloadData()
        }
    }
    
    func setTitle(title: String) {
        self.title = title.localized
    }
}

// MARK: - UITableViewDelegate
extension WeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height / 3))
        
        let iconImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        let tempLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 40, weight: .light)
            return label
        }()
        
        let locationLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            return label
        }()
        
        if let today = viewModel.today {
            tempLabel.text =  "\(today.temp.day.deleteDecimal)" + "°"
        }
        
        headerView.addSubviews(iconImageView, tempLabel, locationLabel)
        
        locationLabel.text = viewModel.returnLocationTitle()
        
        if let data = self.viewModel.returnTodayImage() {
            iconImageView.image = UIImage(data: data)
        }
        
        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
            
            tempLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 32),
            tempLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            
            locationLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            locationLabel.bottomAnchor.constraint(equalTo: iconImageView.topAnchor, constant: -32)
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        view.frame.height / 3
    }
}

// MARK: - UITableViewDataSource
extension WeatherViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = weatherTableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.weatherTableViewIdentifier) as? WeatherTableViewCell else { return UITableViewCell() }
        cell.fill(daily: viewModel.daily[indexPath.row])
        return cell
    }
}
