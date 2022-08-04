//
//  PokemonModel.swift
//  PokeChallenge
//
//  Created by Julio Brazil on 01/08/22.
//

import Foundation

struct PokemonListingModel {
    let id: Int
    let name: String
}

struct PokemonModel {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let isDefault: Bool
    let baseExperience: Int
    let stats: [Stat]
    let types: [PokemonType]

    init(from response: PokemonResponse) {
        self.id = response.id
        self.name = response.species.name ?? ""
        self.height = response.height
        self.weight = response.weight
        self.isDefault = response.isDefault
        self.baseExperience = response.baseExperience
        self.stats = response.stats
        self.types = response.types.compactMap({ PokemonType(rawValue: $0.type.name ?? "") })
    }
}
