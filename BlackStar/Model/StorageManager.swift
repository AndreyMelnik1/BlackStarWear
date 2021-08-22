//
//  StorageManager.swift
//  
//
//  Created by Андрей Мельник on 15.07.2021.
//

import RealmSwift

let realm = try! Realm()

struct StorageManager {
    
    var taskList: Results<ModelRealm>! 
    
    static func  save(task: ModelRealm) {
        try! realm.write {
            realm.add(task)
        }
    }
}

