//
//  PokemonMovesDetailEntity.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 08/09/23.
//

import Foundation


struct PokemonMovesDetail: Codable {
    let accuracy: Int?
    let id: Int?
    let name: String?
    let type: ContestType

    enum CodingKeys: String, CodingKey {
        case accuracy,id,name,type
    }
}

// MARK: - ContestType
struct ContestType: Codable {
    let name: String?
    let url: String?
}
