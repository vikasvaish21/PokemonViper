//
//  PokemonManager.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 22/10/22.
//

import Foundation
import CoreData
 
struct PokemonManager{
    private let _pokemonDataRepository = pokemonDataRepository()
    
    
    func createPokemonData(pokemon: PokemonSavedData){
        _pokemonDataRepository.createPokemonData(pokemon: pokemon)
    }
    
    func fetchPokemon() -> [PokemonSavedData]?{
        return _pokemonDataRepository.getAll()
    }
    
    func updatePokemon(employee: SinglePokemon) -> Bool{
//        return _pokemonDataRepository.update(pokemon: <#T##PokemonSavedData#>)
        return true
    }
    
    func deletePokemon(employee: SinglePokemon) -> Bool{
//        return _pokemonDataRepository.delete(id: )
        return false
    }
    func deleteAllPokemon() {
        return _pokemonDataRepository.deleteAllRecords()
    }
}
