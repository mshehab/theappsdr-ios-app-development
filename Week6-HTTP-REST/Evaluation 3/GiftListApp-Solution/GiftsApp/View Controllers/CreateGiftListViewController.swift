//
//  CreateGiftListViewController.swift
//  GiftsApp
//
//  Created by Mohamed Shehab on 3/18/24.
//

import UIKit
import Alamofire
import SwiftyJSON
import PKHUD
import Kingfisher

class CreateGiftListViewController: UIViewController {
    let token : String = SceneDelegate.getToken()!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var overallCostLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var products = [Product]()
    var totalCost: Double = 0.0
    var totalCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
        getProducts()
    }
    
    func getProducts(){
        let headers: HTTPHeaders = [
            "Authorization": "BEARER \(token)"
        ]
        
        
        HUD.show(.labeledProgress(title: "Getting Products", subtitle: "Please wait!"))
        
        AF.request("https://www.theappsdr.com/api/giftlists/products", method: .get, headers: headers)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                HUD.hide()
                switch response.result {
                case .success:
                    print("Validation Successful")
                    if let data = response.data{
                        if let json = try? JSON(data: data){
                            self.products.removeAll()
                            let productsArray = json["products"].arrayValue
                            for item in productsArray {
                                let product = Product(item)
                                self.products.append(product)
                            }
                            self.tableView.reloadData()
                            self.computeTotalCost()
                        }
                    }
                case let .failure(error):
                    print(error)
                }
            }
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
    
    
    func callAddNewAPI(name: String, productIds: String){
        
        let parameters = [
            "productIds": productIds,
            "name" : name
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "BEARER \(token)"
        ]
        
        
        HUD.show(.labeledProgress(title: "Creating Gift List", subtitle: "Please wait!"))
        
        AF.request("https://www.theappsdr.com/api/giftlists/new", method: .post, parameters: parameters,  headers: headers)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                HUD.hide()
                switch response.result {
                case .success:
                    
                    NotificationCenter.default.post(name: Notification.Name("ReloadGiftListNotification"), object: nil)
                    
                    self.dismiss(animated: true)
                case let .failure(error):
                    print(error)
                }
            }
        
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        let name = self.nameTextField.text!
        if name.isEmpty {
            print("Name is required !!")
        } else if totalCount == 0 {
            print("Please add productions !!")
        } else {
            var ids = [String]()
            for product in products {
                print("\(product.count)")
                for i in 0..<product.count {
                    ids.append(product.pid)
                }
            }
            let productIds = ids.joined(separator: ",")
            self.callAddNewAPI(name: name, productIds: productIds)
            
            
        }
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension CreateGiftListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        let product = products[indexPath.row]
        
        cell.productDelegate = self
        cell.product = product
        
        cell.itemCostLabel.text = "$\(product.price)"
        cell.itemsCountLabel.text = "\(product.count)"
        cell.nameLabel.text = product.name
        
        let url = URL(string: product.img_url)
        cell.productImageView.kf.setImage(with: url)

        return cell
    }
    
    
}

extension CreateGiftListViewController: ProductDelegate {
    func productIncrementClicked(_ product: Product) {
        product.count = product.count + 1
        computeTotalCost()
        self.tableView.reloadData()
    }
    
    func productDecrementClicked(_ product: Product) {
        if product.count > 0 {
            product.count = product.count - 1
            computeTotalCost()
            self.tableView.reloadData()
        }
    }
    
    func giftListProductIncrementClicked(_ product: GiftListProduct) {
        
    }
    
    func giftListProductDecrementClicked(_ product: GiftListProduct) {
        
    }
    
}
