//
//  ModelRealm.swift
//  BlackStar
//
//  Created by Андрей Мельник on 15.07.2021.
//

import RealmSwift

class ModelRealm: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var price = ""
    @objc dynamic var size = ""
    @objc dynamic var color = ""
    @objc dynamic var completed = false
}
