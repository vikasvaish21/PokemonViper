//
//  MovesDataModel+CoreDataProperties.swift
//  
//
//  Created by Vikas Vaish on 12/09/23.
//
//

import Foundation
import CoreData


extension MovesDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovesDataModel> {
        return NSFetchRequest<MovesDataModel>(entityName: "MovesDataModel")
    }

    @NSManaged public var accuracy: Int64
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var power: Int64
    @NSManaged public var pp: Int64
    @NSManaged public var priority: Int64
    @NSManaged public var target: String?
    @NSManaged public var type: String?
    @NSManaged public var moveNo: Int64
    
    func convertToPokemonMoves() -> MovesDetailSavedData{
        return MovesDetailSavedData(accuracy: self.accuracy, id: self.id, moveNo: self.moveNo, name: self.name, power: self.power, pp: self.pp, priority: self.priority, target: self.target, type: self.type)
    }
    

}
