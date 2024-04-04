//
//  ReviewTableViewCell.swift
//  GradesApp
//
//  Created by Mohamed Shehab on 3/25/24.
//

import UIKit

protocol ReviewDelegate {
    func deleteClicked(_ review: Review)
}

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var createdByNameLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    var review: Review?
    var reviewDelegate: ReviewDelegate?
    
    func bind(review: Review, reviewDelegate: ReviewDelegate) {
        self.review = review
        self.reviewDelegate = reviewDelegate
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func deleteClicked(_ sender: Any) {
        self.reviewDelegate!.deleteClicked(self.review!)
    }
    
}
