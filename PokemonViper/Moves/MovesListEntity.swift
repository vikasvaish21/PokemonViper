//
//  MovesListEntity.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 11/09/23.
//

import Foundation

struct MovesCountModel: Codable {
    let count: Int?
    
}

// MARK: - Result

struct ModelListModel:Codable{
    let results: [ResultList]?
}

struct ResultList: Codable {
    let name: String?
    let url: String?
}



struct MovesDetailModel: Codable {
    let accuracy: Int64?
    let id: Int64?
    let name: String?
    let power, pp, priority: Int64?
    let target, type: ContestType?

    enum CodingKeys: String, CodingKey {
        case accuracy
        case id
        case name
        case power, pp, priority
        case target, type
    }
}


struct MovesDetailSavedData{
    let accuracy: Int64?
    let id :UUID?
    let moveNo : Int64?
    let name: String?
    let power, pp, priority: Int64?
    let target, type: String?
}


