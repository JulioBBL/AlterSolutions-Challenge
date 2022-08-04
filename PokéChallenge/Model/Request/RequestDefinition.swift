//
//  RequestDefinition.swift
//  PokéChallenge
//
//  Created by Julio Brazil on 30/07/22.
//

import Foundation

enum RequestDefinition {
    case getPokemonList(startingFrom: Int, amount: Int)
    case getPokemonDetai(pokeID: Int)
    case getPokemonSpecies(pokeID: Int)
    case getEvolutionChain(evolutionChainID: Int)
    
    var url: URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "pokeapi.co"

        switch self {
        case let .getPokemonList(offset, limit):
            urlComponents.path = "/api/v2/pokemon/"
            urlComponents.queryItems = [
                URLQueryItem(name: "offset", value: String(offset)),
                URLQueryItem(name: "limit", value: String(limit))
            ]
            
        case let .getPokemonDetai(pokeID):
            urlComponents.path = "/api/v2/pokemon/\(pokeID)"
        case .getPokemonSpecies(let pokeID):
            urlComponents.path = "/api/v2/pokemon-species/\(pokeID)"
        case .getEvolutionChain(let evolutionChainID):
            urlComponents.path = "/api/v2/evolution-chain/\(evolutionChainID)"
        }
        
        return urlComponents.url!
    }
    
    var request: URLRequest {
        URLRequest(url: self.url)
    }
}
