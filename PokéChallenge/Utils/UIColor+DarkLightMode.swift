//
//  UIColor+DarkLightMode.swift
//  PokeChallenge
//
//  Created by Julio Brazil on 31/07/22.
//

import UIKit

extension UIColor {
    convenience init(lightVariant: UIColor, darkVariant: UIColor) {
        self.init { collection in
            return collection.userInterfaceStyle == .light ? lightVariant : darkVariant
        }
    }
}
