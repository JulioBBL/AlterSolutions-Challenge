//
//  EvolutionModel.swift
//  PokeChallenge
//
//  Created by Julio Brazil on 03/08/22.
//

import Foundation

struct EvolutionModel {
    var pokemon: PokemonListingModel
    var evolvesTo: [EvolutionModel]

    static func from(_ chainItem: EvolutionChainItem) -> EvolutionModel? {
        guard let lastURLComponent = chainItem.species.urlLastComponent, let id = Int(lastURLComponent) else { return nil }

        let evolutions: [EvolutionModel] = chainItem.evolvesTo.compactMap{ EvolutionModel.from($0) }

        return EvolutionModel(
            pokemon: PokemonListingModel(
                id: id,
                name: chainItem.species.name ?? ""
            ),
            evolvesTo: evolutions
        )
    }
}
