//
//  PurchaseDetailsViewController.swift
//  Evaluation02
//
//  Created by Mohamed Shehab on 3/4/26.
//

import UIKit

class PurchaseDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var purchase: Purchase?
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderTableViewCell")
        self.quantityLabel.text = "Quantity: \(purchase!.totalItems())"
        self.totalLabel.text = String(format: "Total: $%.2f", purchase!.totalAmount())
    }
    

}

extension PurchaseDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.purchase!.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath) as! OrderTableViewCell
        let item = self.purchase!.items[indexPath.row]
        
        cell.nameLabel.text = item.itemName
        cell.equationLabel.text = String(format: "$%.2f x %d", item.price, item.quantity)
        cell.totalLabel.text = String(format: "$%.2f", item.price * Double(item.quantity))
        
        return cell
    }
    
    
}
