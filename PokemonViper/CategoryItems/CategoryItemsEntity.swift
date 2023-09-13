//
//  CategoryItemsEntity.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 13/09/23.
//

import Foundation

struct CategoryItemsModel: Codable {
    let id: Int
    let items: [Pocket]
    let name: String
    let names: [ItemName]
    let pocket: Pocket
}

// MARK: - Pocket
struct Pocket: Codable {
    let name: String
    let url: String
}

// MARK: - Name
struct ItemName: Codable {
    let language: Pocket
    let name: String
}


