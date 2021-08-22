//
//  BasketGoodsController.swift
//  BlackStar
//
//  Created by Андрей Мельник on 15.07.2021.
//

import UIKit
import Foundation
import AlamofireImage

class BasketGoodsController: UIViewController {

    @IBOutlet weak var shopingTableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var sendOrderButton: UIButton!
    var shopingList: [ItemData] = []
    var realmModel = StorageManager()
    var imageUrl  = URL(string: "https://blackstarshop.ru/")

    override func  viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        totalPriceCount()
        shopingTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendOrderButton.layer.cornerRadius = 20
        realmModel.taskList = realm.objects(ModelRealm.self)
        totalPriceCount()
    }
    
    @IBAction func sendOrderButton(_ sender: Any) {
        print("Спасибо за покупку, но это не настоящий магазин! ")
    }
}

extension BasketGoodsController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return  realmModel.taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketCell", for: indexPath) as! BasketCell
        cell.itemcell(item: realmModel.taskList[indexPath.row])
        
        return  cell
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "Удалить из корзины?", message: .none, preferredStyle: .alert)
        
        let deleteOrder = UIAlertAction(title: "Да", style: .default) { _ in
            let task = self.realmModel.taskList[indexPath.row]
            
            try! self.realmModel.taskList.realm?.write{
                self.realmModel.taskList.realm?.delete(task)
                self.shopingTableView.reloadData()
                self.totalPriceCount()
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive)
        alert.addAction(deleteOrder)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func totalPriceCount(){
        var priseFormated = 0
        for index in 0..<realmModel.taskList.count {
            let a = Int(Double(realmModel.taskList[index].price)!)
            priseFormated += a
        }
        self.totalPriceLabel.text = "\(priseFormated) руб."
    }
}
