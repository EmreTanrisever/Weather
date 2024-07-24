//
//  DailyForecastTableViewCell.swift
//  Weather
//
//  Created by Emre Tanrısever on 18.07.2024.
//

import UIKit

protocol DailyForecastTableViewCellProtocol: AnyObject {
    
    func fillImage()
}

final class DailyForecastTableViewCell: UITableViewCell {

    private let dayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let minTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .right
        return label
    }()
    
    private let maxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .right
        return label
    }()
    
    private let weatherIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var viewModel = DailyForecastTableViewCellViewModel(view: self)
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
}

extension DailyForecastTableViewCell {
    
    func configure() {
        contentView.addSubviews(dayLabel, minTemperatureLabel, maxTemperatureLabel, weatherIconImageView)
        contentView.backgroundColor = UIColor(named: "BackgroundColor")
        setConstraints()
    }
    
    func fillUI(daily: Daily) {
        viewModel.daily = daily
        viewModel.fetch()
        dayLabel.text = daily.dt.getDay
        minTemperatureLabel.text = daily.temp.min.deleteDecimal + "°"
        maxTemperatureLabel.text = daily.temp.max.deleteDecimal + "°"
    }
}

extension DailyForecastTableViewCell {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            dayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dayLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dayLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            minTemperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            minTemperatureLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            minTemperatureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            minTemperatureLabel.widthAnchor.constraint(equalToConstant: 48),
            
            maxTemperatureLabel.trailingAnchor.constraint(equalTo: minTemperatureLabel.leadingAnchor),
            maxTemperatureLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            maxTemperatureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            maxTemperatureLabel.widthAnchor.constraint(equalToConstant: 48),
            
            weatherIconImageView.trailingAnchor.constraint(equalTo: maxTemperatureLabel.leadingAnchor),
            weatherIconImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            weatherIconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            weatherIconImageView.widthAnchor.constraint(equalToConstant: 64)
        ])
    }
}

extension DailyForecastTableViewCell: DailyForecastTableViewCellProtocol {
    
    func fillImage() {
        if let iconName = viewModel.icon {
            DispatchQueue.main.async { [weak self] in
                self?.weatherIconImageView.image = UIImage(named: iconName)
            }
        }
    }
}
