//
//  GiftTableViewCell.swift
//  GiftsApp
//
//  Created by Mohamed Shehab on 3/18/24.
//

import UIKit

protocol GiftCellDelegate {
    func deleteGiftList(_ gid: String)
}

class GiftTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var itemsCountLabel: UILabel!
    @IBOutlet weak var totalCostLabel: UILabel!
    var gid: String?
    var cellDelegate: GiftCellDelegate?
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onTrashDeleted(_ sender: Any) {
        self.cellDelegate!.deleteGiftList(self.gid!)
    }
    
    
}
