//
//  SpeciesDataModel+CoreDataProperties.swift
//  PokemonViper
//
//  Created by Vikas Vaish on 22/10/22.
//
//

import Foundation
import CoreData


extension SpeciesDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SpeciesDataModel> {
        return NSFetchRequest<SpeciesDataModel>(entityName: "SpeciesDataModel")
    }
    @NSManaged public var id: UUID?
    @NSManaged public var pokemonNo: Int64
    @NSManaged public var name: String?
    @NSManaged public var image: String?
    @NSManaged public var primaryType: String?
    @NSManaged public var secondaryType: String?
    
    func convertToPokemon() -> PokemonSavedData{
        return PokemonSavedData(name: self.name, id: self.id, pokemonNo: self.pokemonNo, sprites: self.image, primaryTypes: self.primaryType,secondaryType: self.secondaryType)
    }
    

}

extension SpeciesDataModel : Identifiable {

}
