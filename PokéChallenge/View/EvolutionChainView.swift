//
//  EvolutionChainView.swift
//  PokeChallenge
//
//  Created by Julio Brazil on 03/08/22.
//

import UIKit


class EvolutionChainView: UIView {
    private lazy var arrowImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "chevron.right")
        view.contentMode = .scaleAspectFit
        view.tintColor = .label

        return view
    }()

    private lazy var pokemonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = DesignSystem.Dimensions.cornerRadius
        view.addShadow()

        return view
    }()

    private lazy var pokeImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit

        return view
    }()

    private lazy var pokeName: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center

        return view
    }()

    private lazy var mainStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = DesignSystem.Dimensions.halfMargin

        return view
    }()

    private lazy var evolutionStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = DesignSystem.Dimensions.halfMargin

        return view
    }()

    init() {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        self.setupUI()
    }

    func configureWith(viewModel: EvolutionModel) {
        self.pokeName.text = viewModel.pokemon.name.localizedCapitalized
        self.pokeImage.setupForPokemon(withID: viewModel.pokemon.id)

        if viewModel.evolvesTo.isEmpty == false {
            for evolution in viewModel.evolvesTo {
                let chainView = EvolutionChainView()
                chainView.configureWith(viewModel: evolution)

                self.evolutionStack.addArrangedSubview(chainView)
            }
        }

        self.layoutIfNeeded()
    }

    private func setupUI() {
        self.addSubview(self.mainStack)
        self.mainStack.addArrangedSubview(self.pokemonView)
        self.mainStack.addArrangedSubview(self.evolutionStack)
        self.pokemonView.addSubview(self.arrowImageView)
        self.pokemonView.addSubview(self.pokeImage)
        self.pokemonView.addSubview(self.pokeName)

        var constraints = [
            self.mainStack.topAnchor.constraint(equalTo: self.topAnchor),
            self.mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            self.arrowImageView.leadingAnchor.constraint(equalTo: self.pokemonView.leadingAnchor, constant: DesignSystem.Dimensions.halfMargin),
            self.arrowImageView.centerYAnchor.constraint(equalTo: self.pokeImage.centerYAnchor),
            self.arrowImageView.widthAnchor.constraint(equalToConstant: DesignSystem.Dimensions.halfMargin),

            self.pokeImage.leadingAnchor.constraint(equalTo: self.arrowImageView.trailingAnchor, constant: DesignSystem.Dimensions.halfMargin),
            self.pokeImage.trailingAnchor.constraint(equalTo: self.pokemonView.trailingAnchor, constant: -DesignSystem.Dimensions.halfMargin),
            self.pokeImage.topAnchor.constraint(equalTo: self.pokemonView.topAnchor, constant: DesignSystem.Dimensions.halfMargin),
            self.pokeImage.widthAnchor.constraint(equalToConstant: DesignSystem.Dimensions.evolutionIconSize.width),
            self.pokeImage.heightAnchor.constraint(equalToConstant: DesignSystem.Dimensions.evolutionIconSize.height),

            self.pokeName.centerXAnchor.constraint(equalTo: self.pokeImage.centerXAnchor),
            self.pokeName.widthAnchor.constraint(equalTo: self.pokeImage.widthAnchor),
            self.pokeName.topAnchor.constraint(equalTo: self.pokeImage.bottomAnchor),
            self.pokeName.bottomAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -DesignSystem.Dimensions.margin)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}

class EvolutionGraphView: UIView {
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentInsetAdjustmentBehavior = .always
        view.clipsToBounds = false

        return view
    }()

    private lazy var evolutionView: EvolutionChainView = {
        let view = EvolutionChainView()
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
        self.setupUI()
    }

    func configureWith(viewModel: EvolutionModel) {
        self.evolutionView.configureWith(viewModel: viewModel)
    }

    private func setupUI() {
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.evolutionView)

        let constraints = [
            self.scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            self.evolutionView.topAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.topAnchor),
            self.evolutionView.bottomAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.bottomAnchor),
            self.evolutionView.leadingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.leadingAnchor),
            self.evolutionView.trailingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.trailingAnchor),
            self.evolutionView.heightAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.heightAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
