//
//  Poke_ChallengeTests.swift
//  PokéChallengeTests
//
//  Created by Julio Brazil on 30/07/22.
//

import XCTest
@testable import PokeChallenge

class Poke_ChallengeTests: XCTestCase {

    func testResourceDataConversion() throws {
        let resources = [
            Resource(name: "test", url: "www.test.com/test/parameter/1"),
            Resource(name: "test", url: "www.test.com/test/parameter/1/"),
            Resource(name: "test", url: "www.test.com/test/parameter/1/other")
        ]

        XCTAssertEqual(
            resources[0].urlLastComponent,
            "1",
            "Expected return \"1\" from \"resources[0].urlLastComponent\", got \"\(String(describing: resources[0].urlLastComponent))\" instead"
        )
        XCTAssertEqual(
            resources[1].urlLastComponent,
            "1",
            "Expected return \"1\" from \"resources[0].urlLastComponent\", got \"\(String(describing: resources[0].urlLastComponent))\" instead"
        )
        XCTAssertEqual(
            resources[2].urlLastComponent,
            "other",
            "Expected return \"other\" from \"resources[0].urlLastComponent\", got \"\(String(describing: resources[0].urlLastComponent))\" instead"
        )
    }

    func testRequestDefinitionURLCreation() throws {
        // MARK: - getPokemonList
        XCTAssertEqual(
            RequestDefinition.getPokemonList(startingFrom: 0, amount: 10).url.absoluteString,
            "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=10"
        )
        XCTAssertEqual(
            RequestDefinition.getPokemonList(startingFrom: 1, amount: 10).url.absoluteString,
            "https://pokeapi.co/api/v2/pokemon/?offset=1&limit=10"
        )
        XCTAssertEqual(
            RequestDefinition.getPokemonList(startingFrom: 0, amount: 11).url.absoluteString,
            "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=11"
        )

        // MARK: - getPokemonDetai
        XCTAssertEqual(
            RequestDefinition.getPokemonDetai(pokeID: 1).url.absoluteString,
            "https://pokeapi.co/api/v2/pokemon/1"
        )
        XCTAssertEqual(
            RequestDefinition.getPokemonDetai(pokeID: 2).url.absoluteString,
            "https://pokeapi.co/api/v2/pokemon/2"
        )

        // MARK: - getPokemonSpecies
        XCTAssertEqual(
            RequestDefinition.getPokemonSpecies(pokeID: 1).url.absoluteString,
            "https://pokeapi.co/api/v2/pokemon-species/1"
        )
        XCTAssertEqual(
            RequestDefinition.getPokemonSpecies(pokeID: 2).url.absoluteString,
            "https://pokeapi.co/api/v2/pokemon-species/2"
        )

        // MARK: - getEvolutionChain
        XCTAssertEqual(
            RequestDefinition.getEvolutionChain(evolutionChainID: 1).url.absoluteString,
            "https://pokeapi.co/api/v2/evolution-chain/1"
        )
    }

    func testPokemonModelCrationFromPokemonResponse() throws {
        let response = PokemonResponse(
            id: .zero,
            baseExperience: .zero,
            height: .zero,
            isDefault: false,
            species: Resource(name: nil, url: ""),
            stats: [],
            types: [
                TypeElement(slot: 0, type: Resource(name: nil, url: "")),      // invalid
                TypeElement(slot: 0, type: Resource(name: "", url: "")),       // invalid
                TypeElement(slot: 0, type: Resource(name: "a", url: "")),      // invalid
                TypeElement(slot: 0, type: Resource(name: "grass", url: "")),  // valid
                TypeElement(slot: 0, type: Resource(name: "poison", url: "")), // valid
            ],
            weight: .zero
        )

        let expectedTypes: [PokemonType] = [
            .grass,
            .poison
        ]

        XCTAssertEqual(PokemonModel.init(from: response).types, expectedTypes, "PokemonModel.types should be [.grass, .poison] and nothing else")
    }
}
