//
//  UIImageView+SetupForPokemon.swift
//  PokeChallenge
//
//  Created by Julio Brazil on 01/08/22.
//

import UIKit
import SDWebImage

extension UIImageView {
    func setupForPokemon(withID pokeID: Int) {
        self.sd_imageIndicator = SDWebImageActivityIndicator.large
        self.tintColor = .clear
        self.sd_setImage(
            with: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(pokeID).png"),
            placeholderImage: UIImage(systemName: "questionmark")
        )
    }
}
