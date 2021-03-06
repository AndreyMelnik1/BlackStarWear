//
//  BasketCard.swift
//  BlackStar
//
//  Created by Андрей Мельник on 10.07.2021.
//

import Foundation

class BasketCard {
    
    var name = ""
    var price = ""
    var colorName = ""
    var mainImage = ""
    var offers: NSArray = []
    var article = ""
    var size = ""
    
    init?(data: ItemData, sizeSelect: String, colorSelect: String, indexSize: Int) {
        guard
            let name = data.name as? String,
            let price = data.price as? String,
            let colorName = data.colorName as? String,
            colorName == colorSelect,
            let mainImage = data.mainImage as? String,
            let offers = data.offers as? NSArray,
            let sizeDictionary = offers[indexSize] as? NSDictionary,
            let size = sizeDictionary["size"] as? String,
            size == sizeSelect,
            let article = data.article as? String
            else {
            return nil
        }
        self.name = name
        self.price = price
        self.colorName = colorName
        self.mainImage = mainImage
        self.offers = offers
        self.article = article
        self.size = size
    }
}
