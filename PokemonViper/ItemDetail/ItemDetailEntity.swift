//
//  ItemDetailEntity.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 13/09/23.
//

struct ItemDetailModel: Codable {
    let cost: Int
    let effectEntries: [EffectEntry]
    let id: Int
    let name: String
    let names: [Name]
    let sprites: Sprite

    enum CodingKeys: String, CodingKey {
        case cost
        case effectEntries = "effect_entries"
        case id, name, names, sprites
    }
}

// MARK: - Category
struct Category: Codable {
    let name: String
    let url: String
}

// MARK: - GameIndex
struct GameIndex: Codable {
    let gameIndex: Int
    let generation: Category

    enum CodingKeys: String, CodingKey {
        case gameIndex = "game_index"
        case generation
    }
}

struct Sprite: Codable {
    let spritesDefault: String

    enum CodingKeys: String, CodingKey {
        case spritesDefault = "default"
    }
}
