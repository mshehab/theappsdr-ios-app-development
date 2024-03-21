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
    @IBOutlet weak var pagingLabel: UILabel!
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        posts.append(Post())
        posts.append(Post())
        
        self.tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTableViewCell")

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        //clear the UserDefaults
        //Then call  SceneDelegate.showLogin()
    }
    
    
    @IBAction func perviousClicked(_ sender: Any) {
    }
    
    @IBAction func nextClicked(_ sender: Any) {
    }
    
}

extension PostsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        
    
        return cell
    }
}
