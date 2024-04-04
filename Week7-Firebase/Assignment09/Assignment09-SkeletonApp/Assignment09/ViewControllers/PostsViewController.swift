//
//  PostsViewController.swift
//  Assignment08
//
//  Created by Mohamed Shehab on 3/13/24.
//

import UIKit

class PostsViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTableViewCell")

        
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        //clear the delete using Firebase Auth
        //Then call  SceneDelegate.showLogin()
    }
    
    
}

extension PostsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        let post = self.posts[indexPath.row]
        
        cell.bind(postDelegate: self, post: post)
        
        
        if let postText = post.postText {
            cell.postTextLabel.text = postText
        } else {
            cell.postTextLabel.text = "N/A"
        }
        
        if let createdByName = post.createdByName {
            cell.ownerLabel.text = createdByName
        } else {
            cell.ownerLabel.text = "N/A"
        }
        
        if let createdAt = post.createdAt {
            let dateFormatter = DateFormatter()
            // Set the date format
            dateFormatter.dateFormat = "dd-MM-yyyy h:mm a"
            cell.postTextLabel.text = dateFormatter.string(from: createdAt.dateValue())
        } else {
            cell.postTextLabel.text = "N/A"
        }
        return cell
    }
}


extension PostsViewController: PostDelegate {
    func deletePost(_ post: Post) {
        showAlertWith(title: "Delete", message: "Are you sure you want to delete post \(post.postText!) ?", deleteAlertAction: { action in
            
            
        }, cancelAlertAction: nil)
    }
}
