//
//  CategoryTableViewController.swift
//  BlackStar
//
//  Created by Андрей Мельник on 09.07.2021.
//

import UIKit
import Foundation

class CategoryTableViewController: UITableViewController {
    
    @IBOutlet var tableViewCategory: UITableView!
    @IBOutlet weak var allItam: UIBarButtonItem!
    var categoryShop: [CategoryInfo] = []
    var selectedSubcategories: [Subcategory] = []
    let imageUrlString =  "https://blackstarshop.ru/"
    var category_ID = ""
    var tableIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingData().loadCategory {  category in
            if let count = try? category.get() {
                self.categoryShop.append(count.man)
                self.categoryShop.append(count.wooman)
                self.categoryShop.append(count.children)
                self.categoryShop.append(count.accessories)
                self.categoryShop.append(count.sale)
                self.categoryShop.append(count.marketplace)
                self.categoryShop.append(count.newItems)
                self.selectedSubcategories.append(contentsOf: count.man.subcategories)
                self.selectedSubcategories.append(contentsOf: count.wooman.subcategories)
                self.selectedSubcategories.append(contentsOf: count.children.subcategories)
                self.selectedSubcategories.append(contentsOf: count.accessories.subcategories)
                self.selectedSubcategories.append(contentsOf: count.sale.subcategories)
                self.selectedSubcategories.append(contentsOf: count.marketplace.subcategories)
                self.selectedSubcategories.append(contentsOf: count.newItems.subcategories)
            }
            self.tableView.reloadData()
        }
        allItam.isEnabled = false
        allItam.tintColor = UIColor.clear
    }
    
    @IBAction func back(_ sender: Any) {
        tableIndex = 0
        tableViewCategory.reloadData()
        allItam.isEnabled = false
        allItam.tintColor = UIColor.clear
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var index = 0
        
        if tableIndex == 0 {
            index = categoryShop.count
        } else if tableIndex == 1 {
            index = selectedSubcategories.count}
        return index
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell = CategoryCell()
        
        if tableIndex == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! CategoryCell
            let category = categoryShop[indexPath.row]
            cell.nameCategory.text = category.name
            let imageFullUrl = "\(imageUrlString)\(category.iconImage)"
            cell.imgCategory.image = BasketCell().imagUrlToImage(imageUrl: imageFullUrl)
        } else if tableIndex == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CategoryCell
            let category = selectedSubcategories[indexPath.row]
            cell.nameCategory.text = category.name
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tableIndex == 0 {
            tableIndex = 1
            self.selectedSubcategories = self.categoryShop[indexPath.row].subcategories
            allItam.isEnabled = true
            allItam.tintColor = UIColor.blue
        } else if tableIndex == 1{
            let goods = self.selectedSubcategories[indexPath.row]
            switch goods.id {
            case .string(let id):
                category_ID = id
            default:
                return
            }
            self.performSegue(withIdentifier: "goodsList", sender: category_ID)
        }
        tableViewCategory.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "goodsList" else { return }
        guard let destination = segue.destination as? CollectionViewController else { return }
        destination.categoryID = category_ID
    }
}
