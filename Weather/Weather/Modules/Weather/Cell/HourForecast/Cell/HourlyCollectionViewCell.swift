//
//  CollectionViewCell.swift
//  Weather
//
//  Created by Emre Tanrısever on 19.07.2024.
//

import UIKit

protocol HourlyCollectionViewCellProtocol: AnyObject {
    func fillImage()
}

final class HourlyCollectionViewCell: UICollectionViewCell {
    
    private let hourLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var viewModel = HourlyCollectionViewCellViewModel(view: self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
        contentView.layer.borderColor = UIColor.systemGray6.cgColor
        contentView.layer.borderWidth = 2
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
}

extension HourlyCollectionViewCell {
    
    func configure() {
        contentView.addSubviews(hourLabel, weatherIconImageView,temperatureLabel)
        
        contentView.backgroundColor = UIColor(named: "BackgroundColor")
        
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            hourLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            hourLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            weatherIconImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherIconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherIconImageView.widthAnchor.constraint(equalToConstant: 40),
            weatherIconImageView.heightAnchor.constraint(equalToConstant: 40),
            
            temperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}

extension HourlyCollectionViewCell {
    
    func fillUI(hourly: Hourly) {
        viewModel.fetchIcon(weather: hourly.weather)
        hourLabel.text = "\(hourly.dt.getHour)"
        temperatureLabel.text = "\(hourly.temp.deleteDecimal)°"
    }
}

extension HourlyCollectionViewCell: HourlyCollectionViewCellProtocol {
    
    func fillImage() {
        if let imageName = viewModel.icon {
            DispatchQueue.main.async { [weak self] in
                self?.weatherIconImageView.image = UIImage(named: imageName)
            }
        }
    }
}
