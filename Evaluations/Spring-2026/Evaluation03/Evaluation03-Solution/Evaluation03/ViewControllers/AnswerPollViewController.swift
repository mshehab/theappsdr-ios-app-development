//
//  AnswerPollViewController.swift
//  Evaluation03
//
//  Created by Mohamed Shehab on 3/25/26.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class AnswerPollViewController: UIViewController {
    var poll: Poll?
    @IBOutlet weak var pollNameLabel: UILabel!
    @IBOutlet weak var pollQuestionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "AnswerTableViewCell", bundle: nil), forCellReuseIdentifier: "AnswerTableViewCell")
        self.pollNameLabel.text = poll?.name ?? ""
        self.pollQuestionLabel.text = poll?.question ?? ""
    }
}

extension AnswerPollViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return poll?.answers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerTableViewCell", for: indexPath) as! AnswerTableViewCell
        let answer = poll?.answers[indexPath.row]
        
        cell.nameLabel.text = answer?["name"] as? String ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var answers = [[String: Any]]()
        answers.append(contentsOf: poll?.answers ?? [])
        
        var answer = (poll?.answers[indexPath.row])!
        answer["votes"] = (answer["votes"] as? Int ?? 0) + 1
        
        answers[indexPath.row] = answer
        
        let db = Firestore.firestore()
        let mAuth = FirebaseAuth.Auth.auth()
        var data = [String: Any]()
        data["answers"] = answers
        
        var completedBy = [String]()
        completedBy.append(contentsOf: poll?.completedBy ?? [])
        completedBy.append(mAuth.currentUser?.uid ?? "")

        data["completedBy"] = completedBy
        
        db.collection("polls").document((self.poll!.docId!)).updateData(data) { error in
            if let error = error {
                self.showAlert(title: "Error", message: error.localizedDescription)
            } else {
                //navigate backk ..
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
