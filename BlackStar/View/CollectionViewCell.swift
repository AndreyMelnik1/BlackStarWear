//
//  CollectionViewCell.swift
//  BlackStar
//
//  Created by Андрей Мельник on 10.07.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCollection: UIImageView!
    @IBOutlet weak var nameCollection: UILabel!
    @IBOutlet weak var priceCollection: UILabel!
    
    func itemCell(item: ItemData) {
        let imageFullUrl = "https://blackstarshop.ru/\(item.mainImage)"
        imageCollection.image = imagUrlToImage(imageUrl: imageFullUrl)
        nameCollection.text = item.name
        let priseFormated = Int(Double(item.price)!)
        priceCollection.text = "\(priseFormated) руб. "
    }
    
    func imagUrlToImage (imageUrl:String)-> UIImage? {
        let imageUrl = URL(string: imageUrl)!
        let imageData = try! Data(contentsOf: imageUrl)
        return UIImage(data: imageData)
    }
    
}
