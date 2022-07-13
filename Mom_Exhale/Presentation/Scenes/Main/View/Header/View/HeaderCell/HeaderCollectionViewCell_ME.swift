//
//  HeaderCollectionViewCell_ME.swift
//  Mom_Exhale
//
//  Created by Maxim on 01.07.2022.
//

import UIKit


final class HeaderCollectionViewCell_ME: UICollectionViewCell {
    
    static let identifier = String(describing: HeaderCollectionViewCell_ME.self)
    
    override var isHighlighted: Bool {
      didSet {
        UIView.animate(withDuration: 0.2) {
            self.alpha = self.isHighlighted ? 0.6 : 1
        }
      }
    }
}
