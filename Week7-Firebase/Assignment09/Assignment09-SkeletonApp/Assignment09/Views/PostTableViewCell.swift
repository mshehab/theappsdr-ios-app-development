//
//  PostTableViewCell.swift
//  Assignment08
//
//  Created by Mohamed Shehab on 3/13/24.
//

import UIKit

protocol PostDelegate {
    func deletePost(_ post: Post)
}

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    var post: Post?
    var postDelegate: PostDelegate?
    
    func bind(postDelegate: PostDelegate, post: Post){
        self.post = post
        self.postDelegate = postDelegate
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
        if let postDelegate = self.postDelegate {
            postDelegate.deletePost(self.post!)
        }
    }
}
