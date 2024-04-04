//
//  SelectTableViewCell.swift
//  GradesApp
//
//  Created by Mohamed Shehab on 3/25/24.
//

import UIKit

class SelectTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var itemLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
