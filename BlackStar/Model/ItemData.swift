//
//  ItemData.swift
//  BlackStar
//
//  Created by Андрей Мельник on 10.07.2021.
//

import Foundation

    class ItemData {

        var name,price,colorName,mainImage,article,englishName,description,colorImageURL: String
        var offers: NSArray = []
        var productImages: NSArray = []

        init?(data: NSDictionary) {

            guard
                let name = data["name"] as? String,
                let englishName = data["englishName"] as? String,
                let description = data["description"] as? String,
                let mainImage = data["mainImage"] as? String,
                let price = data["price"] as? String,
                let colorName = data["colorName"]  as? String,
                let colorImageURL = data["colorImageURL"]  as? String,
                let article = data["article"] as? String,
                let offers = data["offers"] as? NSArray,
                offers.count !=  0,
                let productImages = data["productImages"] as? NSArray
                else {
                    return nil
            }
            
            self.name = name
            self.englishName = englishName
            self.description = description
            self.mainImage = mainImage
            self.price = price
            self.offers = offers
            self.colorImageURL = colorImageURL
            self.colorName = colorName
            self.productImages = productImages
            self.article = article
    }
}

