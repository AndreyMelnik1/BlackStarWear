//
//  BasketCell.swift
//  BlackStar
//
//  Created by Андрей Мельник on 15.07.2021.
//

import UIKit

class BasketCell: UITableViewCell {

    @IBOutlet weak var nameBasketCell: UILabel!
    @IBOutlet weak var imageBasketCell: UIImageView!
    @IBOutlet weak var colorBasketCell: UILabel!
    @IBOutlet weak var sizeBasketCell: UILabel!
    @IBOutlet weak var priceBasketCell: UILabel!
    
    func itemcell(item: ModelRealm) {

//        let imageFullUrl = "https://blackstarshop.ru/\(item2.mainImage)"
//        imageBasketCell.image = loadImageFromPath(imageFullUrl as NSString)
        colorBasketCell.text = "Цвет:\(item.color)"
        nameBasketCell.text = item.name
        sizeBasketCell.text = "Размер:\(item.size)"
        let priseFormated = Int(Double(item.price)!)
        priceBasketCell.text = "\(priseFormated) руб."
    }
    
    func imagUrlToImage (imageUrl:String)-> UIImage? {
        let imageUrl = URL(string: imageUrl)!
        let imageData = try! Data(contentsOf: imageUrl)
        return UIImage(data: imageData)
    }
    func loadImageFromPath(_ path: NSString) -> UIImage? {

          let image = UIImage(contentsOfFile: path as String)

          if image == nil {
              return UIImage()
          } else{
              return image
          }
  }
}
