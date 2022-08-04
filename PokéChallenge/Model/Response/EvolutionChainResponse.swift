//
//  EvolutionChainResponse.swift
//  PokeChallenge
//
//  Created by Julio Brazil on 03/08/22.
//

import Foundation

struct EvolutionChainResponse: Decodable {
    var chain: EvolutionChainItem
}

struct EvolutionChainItem: Decodable {
    var evolvesTo: [EvolutionChainItem]
    var species: Resource

    enum CodingKeys: String, CodingKey {
        case evolvesTo = "evolves_to"
        case species
    }
}
