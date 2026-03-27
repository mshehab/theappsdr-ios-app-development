//
//  TasksViewController.swift
//  Assignment09
//
//  Created by Mohamed Shehab on 3/18/26.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class PollsViewController: UIViewController {
    var polls = [Poll]()
    var selectedPoll: Poll?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "PollTableViewCell", bundle: nil), forCellReuseIdentifier: "PollTableViewCell")
        
        let db = Firestore.firestore()
        db.collection("polls").addSnapshotListener { snapshot, error in
            if let error = error {
                
            } else {
                self.polls.removeAll()
                for document in snapshot!.documents {
                    let poll = Poll(snapshot: document)
                    self.polls.append(poll)
                }
                self.tableView.reloadData()
                print("Current polls: \(self.polls)")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AnswerPollSegue" {
            let vc = segue.destination as! AnswerPollViewController
            vc.poll = self.selectedPoll
            self.selectedPoll = nil
        } else if segue.identifier == "PollResultSegue" {
            let vc = segue.destination as! PollResultsViewController
            vc.poll = self.selectedPoll
            self.selectedPoll = nil
        }
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
        self.selectedPoll = poll
        performSegue(withIdentifier: "PollResultSegue", sender: self)
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
        
        cell.nameLabel.text = poll.name
        cell.ownerNameLabel.text = "\(poll.creatorName ?? "Unknown")"
        cell.submissionLabel.text = "\(poll.completedBy.count)  Submissions"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedPoll = polls[indexPath.row]
        if let uid = FirebaseAuth.Auth.auth().currentUser?.uid {
            if !(self.selectedPoll?.completedBy.contains(uid))! {
                performSegue(withIdentifier: "AnswerPollSegue", sender: self)
            } else {
                showAlert(title: "Error", message: "Already answered this poll!!")
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
