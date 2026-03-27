//
//  AnswerAddTableViewCell.swift
//  Evaluation03
//
//  Created by Mohamed Shehab on 3/25/26.
//

import UIKit

protocol AnswerAddTableViewCellDelegate: AnyObject {
    func deleteClicked(answer: String)
}


class AnswerAddTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    var delegate: AnswerAddTableViewCellDelegate?
    var answer: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bind(answer: String, delegate: AnswerAddTableViewCellDelegate) {
        self.answer = answer
        self.delegate = delegate
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteClicked(_ sender: Any) {
        if let delegate = delegate {
            if let answer = answer {
                delegate.deleteClicked(answer: answer)
            }
        }
    }
}
