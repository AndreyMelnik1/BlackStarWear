//
//  ProductCardController.swift
//  BlackStar
//
//  Created by Андрей Мельник on 10.07.2021.
//

import UIKit
import Foundation

class ProductCardController: UIViewController {
    
    @IBOutlet weak var addToCart: UIButton!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    
    var product = ItemData(data: [:])
    var itemCard: [ItemData] = []
    var similarItem: [ItemData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDateInUI()
        addToCart.layer.cornerRadius = 10
        similarItem = similarProducts(article: product!.article)
    }
    
    func addDateInUI(){
        let priseFormated = Int(Double(product!.price)!)
        itemPrice.text = "\(priseFormated) руб. "
        itemName.text = product?.name
        itemDescription.text = product?.description
        let img = String(product!.mainImage)
        let imgFullUrl = "https://blackstarshop.ru/\(img)"
        itemImage.image = BasketCell().imagUrlToImage(imageUrl: imgFullUrl)
    }
    
    func similarProducts(article: String) -> [ItemData] {
        let article = article
        var similarProducts: [ItemData] = []
        for index in 0..<itemCard.count {
            if article == itemCard[index].article {
                similarProducts.append(itemCard[index])
            }
        }
        return similarProducts
    }

    @IBAction func addToCart(_ sender: Any) {
        let popUpVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "popUpVCid") as! PopUPViewController
        popUpVc.item = self.similarItem
        self.addChild(popUpVc)
        popUpVc.view.frame = self.view.frame
        self.view.addSubview(popUpVc.view)
        popUpVc.didMove(toParent:  self)
    }
    
}
