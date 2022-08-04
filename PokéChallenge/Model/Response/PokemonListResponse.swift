//
//  PokemonListResponse.swift
//  PokeChallenge
//
//  Created by Julio Brazil on 01/08/22.
//

import Foundation

struct PokemonListResponse: Decodable {
    let count: Int
    let results: [Resource]
}
