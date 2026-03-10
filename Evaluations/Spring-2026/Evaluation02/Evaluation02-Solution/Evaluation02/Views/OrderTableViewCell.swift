//
//  OrderTableViewCell.swift
//  Evaluation02
//
//  Created by Mohamed Shehab on 3/10/26.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var equationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
