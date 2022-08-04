//
//  SpeciesResponse.swift
//  PokeChallenge
//
//  Created by Julio Brazil on 03/08/22.
//

import Foundation

struct SpeciesResponse: Decodable {
    var evolutionChain: Resource

    enum CodingKeys: String, CodingKey {
        case evolutionChain = "evolution_chain"
    }
}
