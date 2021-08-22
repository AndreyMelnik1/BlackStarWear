//
//  Category+CoreDataClass.swift
//  BlackStar
//
//  Created by Андрей Мельник on 20.07.2021.
//
//

import Foundation
import CoreData

@objc(Category)
public class CD: NSManagedObject {
    
    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "CD"),
              insertInto: CoreDataManager.instance.context)
    }
}
