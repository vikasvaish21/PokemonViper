//
//  SinglePokemon.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 19/10/22.
//

import Foundation

enum PokemonType: String,Equatable{
    case Electric = "electric"
    case Grass = "glass"
    case Dragon = "dragon"
    case Fight = "fighting"
    case Flying = "flying"
    case Fairy = "fairy"
    case Ghost = "ghost"
    case Fire = "fire"
    case Ground = "ground"
    case Poison = "poison"
    case Normal = "normal"
    case Psychic = "psychic"
    case Steel = "steel"
    case Rock = "rock"
    case Water = "water"
    case Dark = "dark"
    case Bug = "bug"
    case Ice = "ice"
}

struct SinglePokemon: Codable {

    let name: String?
    let sprites: Sprites?
    let moves: [Move]
    let id: Int64?
    let types: [TypeElement]?
    let stats: [Stat]
    
    enum CodingKeys: String, CodingKey {
        case  name,sprites,id,types,stats,moves
    }
}


// MARK: - Stat
struct Stat: Codable {
    let baseStat, effort: Int
    let stat: Species

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}



// MARK: - Sprites
class Sprites: Codable {

    let other: Other?

    enum CodingKeys: String, CodingKey {
        case other
    }
}

// MARK: - Other
struct Other: Codable {
    let dreamWorld: DreamWorld?
    let home: Home?
    let officialArtwork: OfficialArtwork?

    enum CodingKeys: String, CodingKey {
        case dreamWorld = "dream_world"
        case home
        case officialArtwork = "official-artwork"
    }
}
// MARK: - DreamWorld
struct DreamWorld: Codable {
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

// MARK: - Home
struct Home: Codable {
    let frontDefault: String?
    let frontShiny: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
        
    }
}

// MARK: - OfficialArtwork
struct OfficialArtwork: Codable {
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let slot: Int?
    let type: Species?
}

// MARK: - Species
struct Species: Codable {
    let name: String?
    let url: String
}

//MARK: - Moves
struct Move: Codable {
    let move: Species
    let versionGroupDetails: [VersionGroupDetail]

    enum CodingKeys: String, CodingKey {
        case move
        case versionGroupDetails = "version_group_details"
    }
}

// MARK: - VersionGroupDetail
struct VersionGroupDetail: Codable {
    let levelLearnedAt: Int
    let moveLearnMethod, versionGroup: Species

    enum CodingKeys: String, CodingKey {
        case levelLearnedAt = "level_learned_at"
        case moveLearnMethod = "move_learn_method"
        case versionGroup = "version_group"
    }
}


struct PokemonSavedData{
    var name: String?
    var id: UUID?
    var pokemonNo: Int64?
    var sprites:String?
    var primaryTypes: String?
    var secondaryType: String?
    
}







typealias PokemonData = [SinglePokemon?]

