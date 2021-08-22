//
//  CategoryLoader.swift
//  BlackStar
//
//  Created by Андрей Мельник on 09.07.2021.
//

import Alamofire
import SVProgressHUD

class LoadingData {
    
    func loadCategory(completion: @escaping (Result<Category,Error>) -> Void) {
        SVProgressHUD.show(withStatus: "Loading")
        
        guard let url = URL(string: "http://blackstarshop.ru/index.php?route=api/v1/categories") else { return }
        URLSession.shared.dataTask(with: url) { (data, _ , _) in
            guard let data = data else { return }
            do {
                let category = try JSONDecoder().decode(Category.self, from: data)
               
                    DispatchQueue.main.async {
                        completion(.success(category))
                        SVProgressHUD.dismiss()
                    }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func loadItem (itemID: String, completion: @escaping ([ItemData]) -> Void)  {
        
        SVProgressHUD.show()
        let itemID = itemID
        let item_url = "http://blackstarshop.ru/index.php?route=api/v1/products&cat_id=\(itemID)"
        
        _ =  AF.request(item_url).responseJSON
            { response in

                if let objects = try? response.result.get(), let jsonDict = objects as? NSDictionary
                {
                    let dictionaryList = jsonDict
                    var itemData : [ItemData] = []
                    for (_ , item) in dictionaryList {
                        if let currentData = ItemData(data: item as! NSDictionary){
                            itemData.append(currentData)
                                
                        }
                      }
                    DispatchQueue.main.async {
                        completion(itemData)
                        SVProgressHUD.dismiss()
                }
            }
        }
    }
}
