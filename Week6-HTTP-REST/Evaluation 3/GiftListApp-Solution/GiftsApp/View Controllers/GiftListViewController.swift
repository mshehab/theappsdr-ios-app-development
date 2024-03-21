//
//  GiftListViewController.swift
//  GiftsApp
//
//  Created by Mohamed Shehab on 3/18/24.
//

import UIKit
import Alamofire
import SwiftyJSON
import PKHUD
import Kingfisher

class GiftListViewController: UIViewController {
    let token : String = SceneDelegate.getToken()!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var overallCostLabel: UILabel!
    
    var giftList : GiftList?
    
    var products = [GiftListProduct]()
    var totalCost: Double = 0.0
    var totalCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = self.giftList!.name
        tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
        products.removeAll()
        products.append(contentsOf: giftList!.products)
        computeTotalCost()
    }
    
    func computeTotalCost(){
        totalCost = 0.0
        totalCount = 0
        for product in products {
            totalCost = totalCost + (product.price * Double(product.count))
            totalCount = totalCount + product.count
        }
        self.overallCostLabel.text = "$\(totalCost)"
    }
    
    func callAddItemAPI(gid: String, pid: String){
        
        let parameters = [
            "gid": gid,
            "pid" : pid
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "BEARER \(token)"
        ]
        
        
        HUD.show(.labeledProgress(title: "Adding Product", subtitle: "Please wait!"))
        
        AF.request("https://www.theappsdr.com/api/giftlists/add-item", method: .post, parameters: parameters,  headers: headers)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                HUD.hide()
                switch response.result {
                case .success:
                    //NotificationCenter.default.post(name: Notification.Name("ReloadGiftListNotification"), object: nil)
                    print("here")
                case let .failure(error):
                    print(error)
                }
            }
        
    }

    func callRemoveItemAPI(gid: String, pid: String){
        
        let parameters = [
            "gid": gid,
            "pid" : pid
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "BEARER \(token)"
        ]
        
        
        HUD.show(.labeledProgress(title: "Removing Product", subtitle: "Please wait!"))
        
        AF.request("https://www.theappsdr.com/api/giftlists/remove-item", method: .post, parameters: parameters,  headers: headers)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                HUD.hide()
                switch response.result {
                case .success:
                    //NotificationCenter.default.post(name: Notification.Name("ReloadGiftListNotification"), object: nil)
                    print("here")
                case let .failure(error):
                    print(error)
                }
            }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.post(name: Notification.Name("ReloadGiftListNotification"), object: nil)

    }
}



extension GiftListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        let product = products[indexPath.row]
        
        cell.productDelegate = self
        cell.giftListProduct = product
        
        cell.itemCostLabel.text = "$\(product.price)"
        cell.itemsCountLabel.text = "\(product.count)"
        cell.nameLabel.text = product.name
        
        let url = URL(string: product.img_url)
        cell.productImageView.kf.setImage(with: url)

        return cell
    }
}

extension GiftListViewController: ProductDelegate {
    func productIncrementClicked(_ product: Product) {
        
    }
    
    func productDecrementClicked(_ product: Product) {
        
    }
    
    func giftListProductIncrementClicked(_ product: GiftListProduct) {
        product.count = product.count + 1
        computeTotalCost()
        self.tableView.reloadData()
        callAddItemAPI(gid: self.giftList!.gid, pid: product.pid)
    }
    
    func giftListProductDecrementClicked(_ product: GiftListProduct) {
        if product.count > 0 {
            product.count = product.count - 1
            computeTotalCost()
            self.tableView.reloadData()
            callRemoveItemAPI(gid: self.giftList!.gid, pid: product.pid)
        }
    }
    
    
}
