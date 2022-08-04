//
//  PokemonTypeLabel.swift
//  PokeChallenge
//
//  Created by Julio Brazil on 31/07/22.
//

import UIKit

class PokemonTypeLabel: UILabel {

    private var topInset: CGFloat = 5
    private var bottomInset: CGFloat = 5
    private var leftInset: CGFloat = 10
    private var rightInset: CGFloat = 10

    init(for pokeType: PokemonType) {
        super.init(frame: .zero)

        self.text = pokeType.rawValue
        self.backgroundColor = DesignSystem.Color.forType(pokeType)
        self.textColor = .white
        self.clipsToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = frame.height/2
    }

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
}
