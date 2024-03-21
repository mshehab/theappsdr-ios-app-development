//
//  ProductTableViewCell.swift
//  GiftsApp
//
//  Created by Mohamed Shehab on 3/18/24.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var itemsCountLabel: UILabel!
    
    @IBOutlet weak var itemCostLabel: UILabel!
    
    @IBAction func plusClicked(_ sender: Any) {
        
    }
    
    @IBAction func minusClicked(_ sender: Any) {
        
    }
    
}
