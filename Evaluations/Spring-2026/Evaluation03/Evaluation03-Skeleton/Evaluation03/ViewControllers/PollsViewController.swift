//
//  TasksViewController.swift
//  Assignment09
//
//  Created by Mohamed Shehab on 3/18/26.
//

import UIKit
import FirebaseAuth

class PollsViewController: UIViewController {
    var polls = [Poll]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "PollTableViewCell", bundle: nil), forCellReuseIdentifier: "PollTableViewCell")
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        do {
          try Auth.auth().signOut()
            SceneDelegate.showLogin()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}

extension PollsViewController: PollTableViewCellDelegate {
    func didClickStats(poll: Poll) {
        
    }
}


extension PollsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return polls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PollTableViewCell", for: indexPath) as! PollTableViewCell
        let poll = polls[indexPath.row]
        cell.bind(poll: poll, delegate: self)
        
        
        
        return cell
    }
}
