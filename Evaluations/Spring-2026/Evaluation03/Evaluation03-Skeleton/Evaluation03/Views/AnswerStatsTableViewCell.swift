//
//  AnswerStatsTableViewCell.swift
//  Evaluation03
//
//  Created by Mohamed Shehab on 3/25/26.
//

import UIKit

class AnswerStatsTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
