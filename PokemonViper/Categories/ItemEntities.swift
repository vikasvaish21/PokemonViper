//
//  ItemEntities.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 13/09/23.
//

import Foundation

struct ItemCategoryCountModel: Codable {
    let count: Int

}

struct ItemCategoryModel: Codable {
    let results: [ItemResult]
}

struct ItemResult: Codable {
    let name: String
    let url: String
}
