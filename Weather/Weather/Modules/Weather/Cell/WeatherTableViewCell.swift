//
//  WeatherTableViewCell.swift
//  Weather
//
//  Created by Emre Tanrısever on 11.07.2024.
//

import UIKit

protocol WeatherTableViewCellProtocol: AnyObject {
    func showImage()
}

class WeatherTableViewCell: UITableViewCell {
    
    static let weatherTableViewIdentifier = "WeatherTableViewIdentifier"
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let minTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let maxTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var viewModel = WeatherCellViewModel(view: self)
    
    required init(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented.")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
}

extension WeatherTableViewCell {
    
    func configure() {
        contentView.addSubviews(dayLabel, minTempLabel, maxTempLabel, iconImageView)
        
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            dayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            dayLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dayLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            minTempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            minTempLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            minTempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            maxTempLabel.trailingAnchor.constraint(equalTo: minTempLabel.leadingAnchor, constant: -24),
            maxTempLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            maxTempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            iconImageView.trailingAnchor.constraint(equalTo: maxTempLabel.leadingAnchor, constant: -24),
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            iconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func fill(daily: Daily) {
        viewModel.daily = daily
        viewModel.fetchImage()
        dayLabel.text = "\(daily.dt.getDay)"
        minTempLabel.text = daily.temp.min.deleteDecimal + "°"
        maxTempLabel.text = daily.temp.max.deleteDecimal + "°"
    }
}

extension WeatherTableViewCell: WeatherTableViewCellProtocol {
    
    func showImage() {
        DispatchQueue.main.async {
            if let image = self.viewModel.images {
                self.iconImageView.image = UIImage(data: image)
            }
        }
    }
}
