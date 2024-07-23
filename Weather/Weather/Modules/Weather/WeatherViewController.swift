//
//  WeatherViewController.swift
//  Weather
//
//  Created by Emre Tanrısever on 11.07.2024.
//

import UIKit

protocol WeatherViewControllerProtocol: AnyObject, AlertShowable {
    func configure(location: [String: Double])
    func startSpinnerAnimation()
    func stopSpinnerAnimation()
    func reloadTableView()
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
        tableView.register(TodayForecastTableViewCell.self, forCellReuseIdentifier: "TodayForecastTableViewCell")
        tableView.register(HourForecastTableViewCell.self, forCellReuseIdentifier: "HourForecastTableViewCell")
        tableView.register(TodayForecastTableViewCell.self, forCellReuseIdentifier: "DailyForecastTableViewCell")
        tableView.rowHeight = 40
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
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
    
    func configure(location: [String: Double]) {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        viewModel.fetchWeatherData(location: location)
        viewModel.returnLocation(location: location)
        
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
}

// MARK: - UITableViewDelegate
extension WeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 500
        case 1:
            return 112
        case 2:
            return 72
        default:
            return 0
        }
    }
}

// MARK: - UITableViewDataSource
extension WeatherViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return viewModel.daily.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = TodayForecastTableViewCell()
            if let image = viewModel.returnTodayImage(), let today = viewModel.today {
                cell.configure(image: image, location: viewModel.returnLocationTitle(), todayTemperature: today.temp.day.deleteDecimal, today: viewModel.today?.weather)
            }
            cell.selectionStyle = .none
            cell.delegate = self
            cell.backgroundColor = UIColor.clear
            return cell
        case 1:
            let cell = HourForecastTableViewCell()
            cell.selectionStyle = .none
            cell.fillUI(hourly: viewModel.hourly)
            cell.backgroundColor = UIColor.clear
            return cell
        case 2:
            let cell = DailyForecastTableViewCell()
            cell.selectionStyle = .none
            cell.fillUI(daily: viewModel.daily[indexPath.row])
            cell.backgroundColor = UIColor.clear
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension WeatherViewController: CellDelegate {
    
    func labelTapped() {
        tabBarController?.selectedIndex = 1
    }
}
