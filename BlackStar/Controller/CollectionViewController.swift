//
//  CollectionViewController.swift
//  BlackStar
//
//  Created by Андрей Мельник on 10.07.2021.
//

import UIKit
import Foundation

class CollectionViewController: UICollectionViewController {

    @IBOutlet var collectionsView: UICollectionView!
    var categoryID = ""
    var itemData: [ItemData] = []
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingData().loadItem(itemID: categoryID) { itemData in
            self.itemData = itemData
            self.collectionsView.reloadData()
        }
     }
  }

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return itemData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! CollectionViewCell
        
        cell.itemCell(item: itemData[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = UIScreen.main.bounds.size.width/2
        return CGSize(width: w, height: w*2 )
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.index = indexPath.row
        self.performSegue(withIdentifier: "ProductCard", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ProductCard" else { return }
        guard let destination = segue.destination as? ProductCardController else { return }
        let productSelect = itemData[self.index]
        destination.product = productSelect
        destination.itemCard = itemData
    }
}
