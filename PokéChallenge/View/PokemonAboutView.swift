//
//  PokemonAboutView.swift
//  PokeChallenge
//
//  Created by Julio Brazil on 03/08/22.
//

import Foundation
import UIKit

class PokemonAboutView: UIView {
    public lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = DesignSystem.Dimensions.margin

        return view
    }()

    init() {
        super.init(frame: .zero)
        self.stupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setupWith(_ viewmodel: PokemonModel) {
        self.stackView.addArrangedSubview(PokemonAboutItem(key: "Height:", value: "\(viewmodel.height) dm"))
        self.stackView.addArrangedSubview(PokemonAboutItem(key: "Weight:", value: "\(viewmodel.weight) hg"))
        self.stackView.addArrangedSubview(PokemonAboutItem(key: "Base Experience:", value: "\(viewmodel.baseExperience)"))

        for statModel in viewmodel.stats {
            let statItem = PokemonStatBarItem(for: statModel)
            self.stackView.addArrangedSubview(statItem)
            self.stackView.setCustomSpacing(10, after: statItem)
        }
    }

    private func stupUI(){
        setupViewHierarchy()
        setupConstraints()
        setupAditional()
    }

    private func setupViewHierarchy() {
        self.addSubview(self.stackView)
    }

    private func setupConstraints() {
        let constraints = [
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: DesignSystem.Dimensions.margin),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -DesignSystem.Dimensions.margin),
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: DesignSystem.Dimensions.margin),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -DesignSystem.Dimensions.margin),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    private func setupAditional() {
        self.backgroundColor = .systemGray6
        self.layer.cornerRadius = DesignSystem.Dimensions.cornerRadius
        self.addShadow()
    }
}

class PokemonAboutItem: UIView {
    public lazy var keyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0.5

        return label
    }()

    public lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    init(key: String, value: String) {
        super.init(frame: .zero)
        self.stupUI()

        self.keyLabel.text = key
        self.valueLabel.text = value
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func stupUI(){
        setupViewHierarchy()
        setupConstraints()
    }

    private func setupViewHierarchy() {
        self.addSubview(self.keyLabel)
        self.addSubview(self.valueLabel)
    }

    private func setupConstraints() {
        let constraints = [
            self.keyLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.keyLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.keyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),

            self.valueLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.valueLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.valueLabel.leadingAnchor.constraint(equalTo: self.keyLabel.trailingAnchor, constant: DesignSystem.Dimensions.halfMargin),
            self.valueLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
    }
}

class PokemonStatBarItem: UIView {
    private let statsColors: [UIColor] = [
        .systemRed,
        .systemOrange,
        .systemYellow,
        .systemGreen,
        .systemCyan,
        .systemBlue
    ]
    public lazy var keyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0.5

        return label
    }()

    public lazy var statBar: UIProgressView = {
        let view = UIProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    init(for statModel: Stat) {
        super.init(frame: .zero)
        self.stupUI()

        self.keyLabel.text = statModel.stat.name?.capitalized.replacingOccurrences(of: "-", with: " ")

        if let statID = Int(statModel.stat.urlLastComponent ?? "0") {
            self.statBar.progressTintColor = self.statsColors[statID - 1]
        }

        self.statBar.setProgress(Float(statModel.baseStat) / Float(255), animated: true)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func stupUI(){
        setupViewHierarchy()
        setupConstraints()
    }

    private func setupViewHierarchy() {
        self.addSubview(self.keyLabel)
        self.addSubview(self.statBar)
    }

    private func setupConstraints() {
        let constraints = [
            self.keyLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.keyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),

            self.statBar.topAnchor.constraint(equalTo: self.keyLabel.bottomAnchor, constant: 5),
            self.statBar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.statBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: DesignSystem.Dimensions.halfMargin),
            self.statBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            self.statBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
