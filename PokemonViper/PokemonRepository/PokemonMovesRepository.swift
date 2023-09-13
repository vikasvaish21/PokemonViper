//
//  PokemonMovesRepository.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 11/09/23.
//

import Foundation
import CoreData
protocol PokemonMovesRepository{
    func createPokemonMoveData(pokemon: MovesDetailSavedData)
    func getAll() -> [MovesDetailSavedData]
    func get(byIdentifier id: UUID) -> MovesDetailSavedData?
    func delete(record : MovesDetailSavedData) -> Bool
}


struct PokemonMovesDataRepository:PokemonMovesRepository{
    func createPokemonMoveData(pokemon: MovesDetailSavedData) {
        let pokemonMoves = MovesDataModel(context: PersistanceStorage.shared.context)
        pokemonMoves.name = pokemon.name
        pokemonMoves.accuracy = pokemon.accuracy ?? 0
        pokemonMoves.power = pokemon.power ?? 0
        pokemonMoves.pp = pokemon.pp ?? 0
        pokemonMoves.target = pokemon.target
        pokemonMoves.type = pokemon.type
        pokemonMoves.moveNo = pokemon.moveNo ?? 0
        PersistanceStorage.shared.saveContext()
    }

    func getAll() -> [MovesDetailSavedData] {
        let result = PersistanceStorage.shared.fetchManagedObjectForMoves(managedObject: MovesDataModel.self)
        var pokemons : [MovesDetailSavedData] = []
        result?.forEach({ (MovesDataModel) in
            pokemons.append(MovesDataModel.convertToPokemonMoves())
        })
        return pokemons
    }
    
    func get(byIdentifier id: UUID) -> MovesDetailSavedData? {
        let result = getPokemon(byIdentifier: id)
        guard result != nil else{return nil}
        return result?.convertToPokemonMoves()
    }
    

    func update(pokemon: MovesDetailSavedData)  -> Bool{
        let pokemonMoves = getPokemon(byIdentifier: pokemon.id!)
        guard pokemonMoves != nil else {return false}
        pokemonMoves?.name = pokemon.name
        pokemonMoves?.accuracy = pokemon.accuracy ?? 0
        pokemonMoves?.power = pokemon.power ?? 0
        pokemonMoves?.pp = pokemon.pp ?? 0
        pokemonMoves?.target = pokemon.target
        pokemonMoves?.type = pokemon.type
        PersistanceStorage.shared.saveContext()
        return true
    }
    
    func delete(record : MovesDetailSavedData) -> Bool{
        let myPokemon = getPokemon(byIdentifier: record.id!)
        guard myPokemon != nil else {return false}
        PersistanceStorage.shared.context.delete(myPokemon!)
        return true
    }
    
    
    func getPokemon(byIdentifier id : UUID) -> MovesDataModel?
    {
        
        let fetchRequest = NSFetchRequest<MovesDataModel>(entityName: "MovesDataModel")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = predicate
        do {
            let result = try PersistanceStorage.shared.context.fetch(fetchRequest).first
            guard result != nil else{return nil}
            return result
        } catch let error {
            debugPrint(error)
        }
        return nil
    }
    
    
    func deleteAllRecords() {
           //delete all data
        let context = PersistanceStorage.shared.persistentContainer.viewContext

           let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "MovesDataModel")
           let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

           do {
               try context.execute(deleteRequest)
               try context.save()
           } catch {
               print ("There was an error")
           }
       }
    
    
}
