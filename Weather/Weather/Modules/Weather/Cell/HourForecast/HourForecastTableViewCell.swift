//
//  HourForecastTableViewCell.swift
//  Weather
//
//  Created by Emre Tanrısever on 18.07.2024.
//

import UIKit

final class HourForecastTableViewCell: UITableViewCell {
    
    private lazy var hourForecastCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionViewLayout.itemSize = CGSize(width: contentView.frame.size.width / 5, height: 104)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.register(HourlyCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        collectionView.backgroundColor = UIColor(named: "BackgroundColor")
        return collectionView
    }()
    
    private lazy var viewModel = HourForecastTableViewCellViewModel()
    
    required init(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented.")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
}

extension HourForecastTableViewCell {
    
    func configure() {
        contentView.addSubview(hourForecastCollectionView)
        
        setConstraints()
    }

    func fillUI(hourly: [Hourly]) {
        viewModel.hourly = hourly
    }
}

extension HourForecastTableViewCell {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            hourForecastCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hourForecastCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            hourForecastCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            hourForecastCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

extension HourForecastTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = hourForecastCollectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? HourlyCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.fillUI(hourly: viewModel.hourly[indexPath.row])
        return cell
    }
}
