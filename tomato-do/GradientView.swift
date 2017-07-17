//
//  GradientView.swift
//  tomato-do
//
//  Created by IvanLazarev on 17/07/2017.
//  Copyright © 2017 Иван Лазарев. All rights reserved.
//

import Foundation
import UIKit


class GradientView: UIView {
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    override func awakeFromNib() {
        super .awakeFromNib()
        setupGradient()
    }

    func setupGradient() {
        backgroundColor = .clear
        isOpaque = false
        isUserInteractionEnabled = false
        let color = UIColor.Tomatodo.blue
        let transparentColor = UIColor.Tomatodo.blue.withAlphaComponent(0)
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = [color.cgColor, transparentColor.cgColor]
    }
}
