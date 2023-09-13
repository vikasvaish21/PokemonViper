//
//  MovesManager.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 12/09/23.
//

import Foundation
import CoreData
 
struct MovesManager{
    private let _pokemonMoveRepository = PokemonMovesDataRepository()
    
    
    func createPokemonData(pokemon: MovesDetailSavedData){
        _pokemonMoveRepository.createPokemonMoveData(pokemon: pokemon)
    }
    
    func fetchMoves() -> [MovesDetailSavedData]?{
        return _pokemonMoveRepository.getAll()
    }
    
    func updateMove(employee: MovesDetailModel) -> Bool{
//        return _pokemonDataRepository.update(pokemon: <#T##PokemonSavedData#>)
        return true
    }
    
    func deleteMove(employee: MovesDetailModel) -> Bool{
//        return _pokemonDataRepository.delete(id: )
        return false
    }
    func deleteAllMove() {
        return _pokemonMoveRepository.deleteAllRecords()
    }
}
