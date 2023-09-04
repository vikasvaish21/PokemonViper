//
//  PokemonRepository.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 22/10/22.
//

import Foundation
import CoreData
protocol PokemonRepository{
    func createPokemonData(pokemon: PokemonSavedData)
    func getAll() -> [PokemonSavedData]
    func get(byIdentifier id: UUID) -> PokemonSavedData?
    func delete(record : PokemonSavedData) -> Bool
}

struct pokemonDataRepository: PokemonRepository{
   
    func createPokemonData(pokemon: PokemonSavedData) {
        let myPokemon = SpeciesDataModel(context: PersistanceStorage.shared.context)
        myPokemon.name = pokemon.name
        myPokemon.id = pokemon.id
        myPokemon.secondaryType = pokemon.secondaryType
        myPokemon.primaryType = pokemon.primaryTypes
        myPokemon.image = pokemon.sprites
        myPokemon.pokemonNo = pokemon.pokemonNo!
        PersistanceStorage.shared.saveContext()
    }
    
    func getAll() -> [PokemonSavedData] {
        let result = PersistanceStorage.shared.fetchManagedObject(managedObject: SpeciesDataModel.self)
        var pokemons : [PokemonSavedData] = []
        result?.forEach({ (SpeciesDataModel) in
//            let pokemon = PokemonSavedData(name: SpeciesDataModel.name, id: SpeciesDataModel.id, sprites: SpeciesDataModel.image, primaryTypes: SpeciesDataModel.primaryType,secondaryType: SpeciesDataModel.secondaryType)
            pokemons.append(SpeciesDataModel.convertToPokemon())
        })
        return pokemons
    }
    
    
    func get(byIdentifier id: UUID) -> PokemonSavedData? {
        let result = getPokemon(byIdentifier: id)
        guard result != nil else{return nil}
        return result?.convertToPokemon()
        
        
    }
    
    
    func update(pokemon: PokemonSavedData)  -> Bool{
        let newPokemon = getPokemon(byIdentifier: pokemon.id!)
        guard newPokemon != nil else {return false}
        newPokemon?.name = pokemon.name
        newPokemon?.image = pokemon.sprites
        newPokemon?.primaryType = pokemon.primaryTypes
        newPokemon?.secondaryType = pokemon.secondaryType
        PersistanceStorage.shared.saveContext()
        return true
    }
    
    func delete(record : PokemonSavedData) -> Bool{
        let myPokemon = getPokemon(byIdentifier: record.id!)
        guard myPokemon != nil else {return false}
        PersistanceStorage.shared.context.delete(myPokemon!)
        return true
    }
    
    func getPokemon(byIdentifier id : UUID) -> SpeciesDataModel?
    {
        
        let fetchRequest = NSFetchRequest<SpeciesDataModel>(entityName: "SpeciesDataModel")
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

           let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "SpeciesDataModel")
           let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

           do {
               try context.execute(deleteRequest)
               try context.save()
           } catch {
               print ("There was an error")
           }
       }
    
    
}
