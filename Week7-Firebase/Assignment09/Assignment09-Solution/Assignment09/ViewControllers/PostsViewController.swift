//
//  PostsViewController.swift
//  Assignment08
//
//  Created by Mohamed Shehab on 3/13/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class PostsViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTableViewCell")

        self.welcomeLabel.text = "Welcome \(Auth.auth().currentUser!.displayName!)" 
        
        
        
        db.collection("posts").addSnapshotListener { snapshot, error in
            if let error = error {
                
            } else {
                self.posts.removeAll()
                if snapshot != nil && !snapshot!.isEmpty {
                    
                    for doc in snapshot!.documents {
                        let post = Post(doc)
                        self.posts.append(post)
                    }
                }
                self.tableView.reloadData()
            }
        }
        
        
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        do {
          try Auth.auth().signOut()
            SceneDelegate.showLogin()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        
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
            cell.createdAtLabel.text = dateFormatter.string(from: createdAt.dateValue())
        } else {
            cell.createdAtLabel.text = "N/A"
        }
        
        if Auth.auth().currentUser!.uid == post.createdByUid! {
            cell.deleteButton.isHidden = false
        } else {
            cell.deleteButton.isHidden = true
        }
        
        return cell
    }
}


extension PostsViewController: PostDelegate {
    func deletePost(_ post: Post) {
        showAlertWith(title: "Delete", message: "Are you sure you want to delete post \(post.postText!) ?", deleteAlertAction: { action in
            
            self.db.collection("posts").document(post.docId!).delete()
            
        }, cancelAlertAction: nil)
    }
}
