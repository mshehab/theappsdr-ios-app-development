//
//  PurchasesViewController.swift
//  Evaluation02
//
//  Created by Mohamed Shehab on 3/4/26.
//

import UIKit

class PurchasesViewController: UIViewController {
    var employee: Employee?
    var filteredPurchases = [Purchase]()
    var selectedPurchase: Purchase?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredPurchases.append(contentsOf: self.employee!.purchases)
        
        self.tableView.register(UINib(nibName: "PurchaseTableViewCell", bundle: nil), forCellReuseIdentifier: "PurchaseTableViewCell")
    }
    
    @IBOutlet weak var filterLabel: UILabel!
    @IBAction func resetClicked(_ sender: Any) {
        filteredPurchases.removeAll()
        filteredPurchases.append(contentsOf: self.employee!.purchases)
        self.filterLabel.text = "All Records"
        self.tableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailsSegue" {
            let vc = segue.destination as! PurchaseDetailsViewController
            vc.purchase = self.selectedPurchase
            self.selectedPurchase = nil
        }
    }
}


extension PurchasesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredPurchases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PurchaseTableViewCell", for: indexPath) as! PurchaseTableViewCell
        let purchase = self.filteredPurchases[indexPath.row]
        cell.configure(purchase, delegate: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedPurchase = self.filteredPurchases[indexPath.row]
        performSegue(withIdentifier: "ShowDetailsSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension PurchasesViewController: PurchaseTableViewCellDelegate {
    func filterClicked(purchase: Purchase) {
        filteredPurchases.removeAll()
        let filterTotal = purchase.totalAmount()
        
        for p in self.employee!.purchases {
            if p.totalAmount() >= filterTotal {
                filteredPurchases.append(p)
            }
        }
        
        self.filterLabel.text = String(format: "$%.2f or more", filterTotal)
        self.tableView.reloadData()
        
    }
}

