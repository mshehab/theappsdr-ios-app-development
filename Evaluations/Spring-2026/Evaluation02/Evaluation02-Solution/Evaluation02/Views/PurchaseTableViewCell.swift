//
//  PurchaseTableViewCell.swift
//  Evaluation02
//
//  Created by Mohamed Shehab on 3/10/26.
//

import UIKit

protocol PurchaseTableViewCellDelegate {
    func filterClicked(purchase: Purchase)
}

class PurchaseTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    var purchase: Purchase?
    var delegate: PurchaseTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ purchase: Purchase, delegate: PurchaseTableViewCellDelegate) {
        self.purchase = purchase
        self.dateLabel.text = purchase.purchaseDate.formatted(date: .abbreviated, time: .omitted)
        self.amountLabel.text = "\(purchase.items.count) items"
        self.totalLabel.text = String(format: "$%.2f", purchase.totalAmount())
        self.delegate = delegate
    }

    @IBAction func filterClicked(_ sender: Any) {
        if let delegate = delegate {
            delegate.filterClicked(purchase: self.purchase!)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
