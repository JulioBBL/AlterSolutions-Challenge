//
//  PokemonTypeView.swift
//  PokeChallenge
//
//  Created by Julio Brazil on 31/07/22.
//

import UIKit

class PokemonTypeView: UIView {
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = DesignSystem.Dimensions.halfMargin
        stack.setContentCompressionResistancePriority(.required, for: .vertical)

        return stack
    }()

    init() {
        super.init(frame: .zero)
    }

    override func didMoveToSuperview() {
        setupViewHierarchy()
        setupConstraints()
        additionalSetup()
    }

    public func setupWith(_ pokeTypes: [PokemonType]) {
        self.clean()

        for type in pokeTypes {
            self.addType(type)
        }
        setNeedsLayout()
        layoutIfNeeded()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViewHierarchy() {
        self.addSubview(stack)
    }

    private func setupConstraints() {
        let constraints = [
            self.stack.topAnchor.constraint(equalTo: self.topAnchor),
            self.stack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    private func additionalSetup() {
        self.setContentCompressionResistancePriority(.required, for: .vertical)
        self.addShadow()
    }

    private func addType(_ pokeType: PokemonType) {
        let label = PokemonTypeLabel(for: pokeType)
        self.stack.addArrangedSubview(label)
    }

    private func clean() {
        self.stack.arrangedSubviews.forEach(self.stack.removeArrangedSubview)
    }
}
