//
//  DesignSystem.swift
//  PokéChallenge
//
//  Created by Julio Brazil on 30/07/22.
//

import UIKit

enum DesignSystem {
    enum FontSizes {
        static var largeTitle: CGFloat = 34
    }

    enum Dimensions {
        static var margin: CGFloat = 30
        static var halfMargin: CGFloat { margin/2 }
        static var cornerRadius: CGFloat = 30
        static var evolutionIconSize: CGSize = CGSize(width: 100, height: 100)
    }

    enum Color {
        static func forType(_ pokeType: PokemonType) -> UIColor {
            switch pokeType {
            case .normal: return UIColor(lightVariant: UIColor(rgb: 0xA8A878), darkVariant: UIColor(rgb: 0x6D6D4E))
            case .fighting: return UIColor(lightVariant: UIColor(rgb: 0xC03028), darkVariant: UIColor(rgb: 0x7D1F1A))
            case .flying: return UIColor(lightVariant: UIColor(rgb: 0xA890F0), darkVariant: UIColor(rgb: 0x6D5E9C))
            case .poison: return UIColor(lightVariant: UIColor(rgb: 0xA040A0), darkVariant: UIColor(rgb: 0x682A68))
            case .ground: return UIColor(lightVariant: UIColor(rgb: 0xE0C068), darkVariant: UIColor(rgb: 0x927D44))
            case .rock: return UIColor(lightVariant: UIColor(rgb: 0xB8A038), darkVariant: UIColor(rgb: 0x786824))
            case .bug: return UIColor(lightVariant: UIColor(rgb: 0xA8B820), darkVariant: UIColor(rgb: 0x6D7815))
            case .ghost: return UIColor(lightVariant: UIColor(rgb: 0x705898), darkVariant: UIColor(rgb: 0x493963))
            case .steel: return UIColor(lightVariant: UIColor(rgb: 0xB8B8D0), darkVariant: UIColor(rgb: 0x787887))
            case .fire: return UIColor(lightVariant: UIColor(rgb: 0xF08030), darkVariant: UIColor(rgb: 0x9C531F))
            case .water: return UIColor(lightVariant: UIColor(rgb: 0x6890F0), darkVariant: UIColor(rgb: 0x445E9C))
            case .grass: return UIColor(lightVariant: UIColor(rgb: 0x78C850), darkVariant: UIColor(rgb: 0x4E8234))
            case .electric: return UIColor(lightVariant: UIColor(rgb: 0xF8D030), darkVariant: UIColor(rgb: 0xA1871F))
            case .psychic: return UIColor(lightVariant: UIColor(rgb: 0xF85888), darkVariant: UIColor(rgb: 0xA13959))
            case .ice: return UIColor(lightVariant: UIColor(rgb: 0x98D8D8), darkVariant: UIColor(rgb: 0x638D8D))
            case .dragon: return UIColor(lightVariant: UIColor(rgb: 0x7038F8), darkVariant: UIColor(rgb: 0x4924A1))
            case .dark: return UIColor(lightVariant: UIColor(rgb: 0x705848), darkVariant: UIColor(rgb: 0x49392F))
            case .fairy: return UIColor(lightVariant: UIColor(rgb: 0xEE99AC), darkVariant: UIColor(rgb: 0x9B6470))
            case .unknown: return UIColor(lightVariant: UIColor(rgb: 0x68A090), darkVariant: UIColor(rgb: 0x44685E))
            }
        }
    }
}
