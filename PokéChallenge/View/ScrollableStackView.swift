//
//  ScrollableStackView.swift
//  PokeChallenge
//
//  Created by Julio Brazil on 03/08/22.
//

import UIKit

class ScrollableStackView: UIView {
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentInsetAdjustmentBehavior = .always
        view.clipsToBounds = false

        return view
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    public lazy var internalStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = DesignSystem.Dimensions.margin

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

    private func setupUI() {
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.containerView)
        self.containerView.addSubview(self.internalStack)

        let constraints = [
            self.scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            self.containerView.topAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.topAnchor),
            self.containerView.bottomAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.bottomAnchor),
            self.containerView.leadingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.leadingAnchor),
            self.containerView.trailingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.trailingAnchor),
            self.containerView.widthAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.widthAnchor),

            self.internalStack.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: DesignSystem.Dimensions.margin),
            self.internalStack.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -DesignSystem.Dimensions.margin),
            self.internalStack.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: DesignSystem.Dimensions.margin),
            self.internalStack.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -DesignSystem.Dimensions.margin),
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
