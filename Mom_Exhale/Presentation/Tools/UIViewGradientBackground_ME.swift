//
//  UIViewGradientBackground_ME.swift
//  Mom_Exhale
//
//  Created by Maxim on 14.07.2022.
//

import UIKit


extension UIView {
    func setGradientBackground(fromColor: UIColor, toColor: UIColor,
                                location1: NSNumber, location2: NSNumber,
                                startPoint: CGPoint? = nil, endPoint: CGPoint? = nil) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [fromColor.cgColor, toColor.cgColor]
        gradientLayer.locations = [location1, location2]
        if let startPoint = startPoint,
           let endPoint = endPoint {
            gradientLayer.startPoint = startPoint
            gradientLayer.endPoint = endPoint
        }
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
