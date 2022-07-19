//
//  TitleColor_ME.swift
//  Mom_Exhale
//
//  Created by Maxim on 13.07.2022.
//

import UIKit


enum TitleColor_ME: String {
    case black = "black"
    case white = "white"
    
    func color() -> UIColor {
        switch self {
        case .black:
            return .black
        case .white:
            return .white
        }
    }
}
