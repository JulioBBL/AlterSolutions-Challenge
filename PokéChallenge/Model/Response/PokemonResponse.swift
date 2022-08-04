//
//  PokemonResponse.swift
//  PokeChallenge
//
//  Created by Julio Brazil on 31/07/22.
//

import Foundation

struct PokemonResponse: Decodable {
    let id: Int
    let baseExperience: Int
    let height: Int
    let isDefault: Bool
    let species: Resource
    let stats: [Stat]
    let types: [TypeElement]
    let weight: Int

    enum CodingKeys: String, CodingKey {
        case id
        case baseExperience = "base_experience"
        case height
        case isDefault = "is_default"
        case species
        case stats
        case types
        case weight
    }
}

// MARK: - Ability
struct Ability: Decodable {
    let ability: Resource
    let isHidden: Bool
    let slot: Int

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

// MARK: - Species
struct Resource: Decodable {
    let name: String?
    let url: String

    var urlLastComponent: String? {
        guard let substring = url.split(separator: "/").last else { return nil }
        return String(substring)
    }
}

// MARK: - Stat
struct Stat: Decodable {
    let baseStat: Int
    let effort: Int
    let stat: Resource

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat
    }
}

// MARK: - TypeElement
struct TypeElement: Decodable {
    let slot: Int
    let type: Resource
}
