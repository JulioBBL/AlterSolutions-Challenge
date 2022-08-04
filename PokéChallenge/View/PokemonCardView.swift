//
//  PokemonCardView.swift
//  PokeChallenge
//
//  Created by Julio Brazil on 31/07/22.
//

import UIKit

class PokemonCardView: UIView {
    private lazy var pokeImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.addShadow()

        return view
    }()

    private lazy var pokeName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .largeTitle).bold()
        label.textColor = .systemBackground
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.allowsDefaultTighteningForTruncation = true

        return label
    }()

    private lazy var pokeNumber: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .largeTitle).bold()
        label.alpha = 0.5
        label.textColor = .systemBackground
        label.setContentCompressionResistancePriority(.required, for: .horizontal)

        return label
    }()

    private lazy var pokeTypeView: PokemonTypeView = {
        let view = PokemonTypeView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    init() {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToSuperview() {
        self.stupUI()
    }

    public func setupWith(_ viewmodel: PokemonModel) {
        UIView.animate(withDuration: 0.3) {
            self.pokeName.text = viewmodel.name.localizedCapitalized
            self.pokeNumber.text = "#\(viewmodel.id)"
            self.pokeTypeView.setupWith(viewmodel.types)

            if let primaryType = viewmodel.types.first {
                self.backgroundColor = DesignSystem.Color.forType(primaryType)
            }

            self.pokeImageView.setupForPokemon(withID: viewmodel.id)
        }
    }

    public func setupWith(_ viewmodel: PokemonListingModel) {
        self.pokeName.text = viewmodel.name.localizedCapitalized
        self.pokeNumber.text = "#\(viewmodel.id)"
        self.pokeTypeView.setupWith([])

        self.pokeImageView.setupForPokemon(withID: viewmodel.id)

    }

    private func stupUI(){
        setupViewHierarchy()
        setupConstraints()
        setupAditional()
    }

    private func setupViewHierarchy() {
        self.addSubview(self.pokeName)
        self.addSubview(self.pokeNumber)
        self.addSubview(self.pokeImageView)
        self.addSubview(self.pokeTypeView)
    }

    private func setupConstraints() {
        let constraints = [
            self.pokeName.topAnchor.constraint(equalTo: self.topAnchor, constant: DesignSystem.Dimensions.margin),
            self.pokeName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: DesignSystem.Dimensions.margin),
            self.pokeName.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -DesignSystem.Dimensions.margin),

            self.pokeNumber.topAnchor.constraint(equalTo: self.pokeName.lastBaselineAnchor),
            self.pokeNumber.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: DesignSystem.Dimensions.margin),

            self.pokeImageView.topAnchor.constraint(equalTo: self.pokeName.lastBaselineAnchor),
            self.pokeImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -DesignSystem.Dimensions.halfMargin),
            self.pokeImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -DesignSystem.Dimensions.halfMargin),
            self.pokeImageView.heightAnchor.constraint(equalTo: self.pokeImageView.widthAnchor),
            self.pokeImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 3/7),

            self.pokeTypeView.topAnchor.constraint(greaterThanOrEqualTo: self.pokeNumber.bottomAnchor, constant: DesignSystem.Dimensions.halfMargin),
            self.pokeTypeView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -DesignSystem.Dimensions.halfMargin),
            self.pokeTypeView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: DesignSystem.Dimensions.halfMargin),
            self.pokeTypeView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -DesignSystem.Dimensions.halfMargin),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    private func setupAditional() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .systemGray2
        self.layer.cornerRadius = DesignSystem.Dimensions.cornerRadius
        self.addShadow()
    }
}
