//
//  FavoriteCharacter+CoreDataProperties.swift
//  MarvelApp
//
//  Created by Rodrigo Córdoba on 12/05/24.
//
//

import Foundation
import CoreData


extension FavoriteCharacter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteCharacter> {
        return NSFetchRequest<FavoriteCharacter>(entityName: "FavoriteCharacter")
    }

    @NSManaged public var details: String?
    @NSManaged public var name: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var url: String?

}

extension FavoriteCharacter : Identifiable {

}
