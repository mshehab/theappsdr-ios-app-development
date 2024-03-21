//
//  ProductTableViewCell.swift
//  GiftsApp
//
//  Created by Mohamed Shehab on 3/18/24.
//

import UIKit

protocol ProductDelegate {
    func productIncrementClicked(_ product: Product)
    func productDecrementClicked(_ product: Product)
    func giftListProductIncrementClicked(_ product: GiftListProduct)
    func giftListProductDecrementClicked(_ product: GiftListProduct)
}

class ProductTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var productDelegate: ProductDelegate?
    var product: Product?
    var giftListProduct: GiftListProduct?
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var itemsCountLabel: UILabel!
    
    @IBOutlet weak var itemCostLabel: UILabel!
    
    @IBAction func plusClicked(_ sender: Any) {
        if self.product != nil {
            self.productDelegate!.productIncrementClicked(self.product!)
        } else if self.giftListProduct != nil {
            self.productDelegate!.giftListProductIncrementClicked(self.giftListProduct!)
        }
       
    }
    
    @IBAction func minusClicked(_ sender: Any) {
        if self.product != nil {
            self.productDelegate!.productDecrementClicked(self.product!)
        } else if self.giftListProduct != nil {
            self.productDelegate!.giftListProductDecrementClicked(self.giftListProduct!)
        }
    }
    
}
