//
//  AddSubviews+UIView.swift
//  Weather
//
//  Created by Emre Tanrısever on 11.07.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
