//
//  GiftTableViewCell.swift
//  GiftsApp
//
//  Created by Mohamed Shehab on 3/18/24.
//

import UIKit

class GiftTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var itemsCountLabel: UILabel!
    @IBOutlet weak var totalCostLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onTrashDeleted(_ sender: Any) {
        
    }
    
    
}
