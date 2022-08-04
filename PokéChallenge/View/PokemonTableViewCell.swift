//
//  PokemonTableViewCell.swift
//  PokeChallenge
//
//  Created by Julio Brazil on 01/08/22.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    private lazy var pokeCard: PokemonCardView = {
        let view = PokemonCardView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    override func layoutSubviews() {
        setupUI()
        super.layoutSubviews()
    }

    override func prepareForReuse() {
        configureWith(viewModel: PokemonListingModel(id: -1, name: "???"))
    }

    func configureWith(viewModel: PokemonListingModel) {
            self.pokeCard.setupWith(viewModel)
            self.layoutIfNeeded()
    }

    private func setupUI() {
        self.addSubview(self.pokeCard)

        let constraints = [
            pokeCard.topAnchor.constraint(equalTo: self.topAnchor, constant: DesignSystem.Dimensions.halfMargin),
            pokeCard.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -DesignSystem.Dimensions.halfMargin),
            pokeCard.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: DesignSystem.Dimensions.margin),
            pokeCard.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -DesignSystem.Dimensions.margin),
        ]

        NSLayoutConstraint.activate(constraints)

        self.backgroundColor = .clear
    }
}
