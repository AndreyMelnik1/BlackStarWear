//
//  Category+CoreDataProperties.swift
//  BlackStar
//
//  Created by Андрей Мельник on 20.07.2021.
//
//

import Foundation
import CoreData

extension CD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CD> {
        return NSFetchRequest<CD>(entityName: "CD")
    }

    @NSManaged public var name: String?

}

extension CD : Identifiable {

}
