//
//  MovesDetailEntity.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 12/09/23.
//

import Foundation

struct MoveDescriptionModel: Codable {
    
    let effectEntries: [EffectEntry]
 

    enum CodingKeys: String, CodingKey {
        case effectEntries = "effect_entries"
    }
}


// MARK: - EffectEntry
struct EffectEntry: Codable {
    let effect: String
    let language: ContestType
    let shortEffect: String

    enum CodingKeys: String, CodingKey {
        case effect, language
        case shortEffect = "short_effect"
    }
}

