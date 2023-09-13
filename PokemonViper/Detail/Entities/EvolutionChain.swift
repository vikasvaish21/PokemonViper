//
//  EvolutionChain.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 23/08/23.
//

import Foundation


struct PokemonEvolutionChain: Codable {
    let chain: Chain?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case chain, id
    }
}

// MARK: - Chain
struct Chain: Codable {
    let evolutionDetails: [EvolutionDetail]?
    let evolvesTo: [Chain]?
    let isBaby: Bool?
    let species: Species?

    enum CodingKeys: String, CodingKey {
        case evolutionDetails = "evolution_details"
        case evolvesTo = "evolves_to"
        case isBaby = "is_baby"
        case species
    }
}

// MARK: - EvolutionDetail
struct EvolutionDetail: Codable {
    let item,heldItem: Item?
    let minLevel: Int?
    let minHappiness: Int?
    let needsOverworldRain: Bool?
    let timeOfDay: String?
    let trigger: Item?
    let turnUpsideDown: Bool?

    enum CodingKeys: String, CodingKey {
        case item
        case minLevel = "min_level"
        case heldItem = "held_item"
        case needsOverworldRain = "needs_overworld_rain"
        case minHappiness = "min_happiness"
        case timeOfDay = "time_of_day"
        case trigger
        case turnUpsideDown = "turn_upside_down"
    }
}

// MARK: - Item
struct Item: Codable {
    let name: String
    let url: String
}
