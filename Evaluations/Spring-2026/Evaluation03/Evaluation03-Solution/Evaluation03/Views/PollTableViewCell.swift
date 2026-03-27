//
//  PollTableViewCell.swift
//  Evaluation03
//
//  Created by Mohamed Shehab on 3/25/26.
//

import UIKit

protocol PollTableViewCellDelegate: AnyObject {
    func didClickStats(poll: Poll)
}

class PollTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var submissionLabel: UILabel!
    var delegate: PollTableViewCellDelegate?
    var poll: Poll?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bind(poll: Poll, delegate: PollTableViewCellDelegate){
        self.delegate = delegate
        self.poll = poll
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onStatsClicked(_ sender: Any) {
        if let poll = self.poll {
            if let delegate = self.delegate {
                delegate.didClickStats(poll: poll)
            }
        }
    }
}
