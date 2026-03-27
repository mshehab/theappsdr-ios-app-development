//
//  CreatePollViewController.swift
//  Evaluation03
//
//  Created by Mohamed Shehab on 3/25/26.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class CreatePollViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pollNameTextField: UITextField!
    @IBOutlet weak var pollQuestionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    var answers = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "AnswerAddTableViewCell", bundle: nil), forCellReuseIdentifier: "AnswerAddTableViewCell")
    }
    
    @IBAction func addClicked(_ sender: Any) {
        let answer = answerTextField.text ?? ""
        if answer.isEmpty {
            showAlert(title: "Error", message: "Answer cannot be empty")
        } else {
            self.answers.append(answer)
            self.tableView.reloadData()
            answerTextField.text = ""
        }
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        let pollName = pollNameTextField.text ?? ""
        let pollQuestion = pollQuestionTextField.text ?? ""
        if pollName.isEmpty {
            showAlert(title: "Error", message: "Poll name cannot be empty")
        } else if pollQuestion.isEmpty {
            showAlert(title: "Error", message: "Poll question cannot be empty")
        } else if answers.isEmpty {
            showAlert(title: "Error", message: "You must add at least one answer")
        } else {
            let db = Firestore.firestore()
            let mAuth = FirebaseAuth.Auth.auth()
            var data = [String: Any]()
            data["name"] = pollName
            data["question"] = pollQuestion
            data["creatorId"] = mAuth.currentUser?.uid ?? ""
            data["creatorName"] = mAuth.currentUser?.displayName ?? ""
            data["completedBy"] = [String]()
            
            var answersData = [[String: Any]]()
            for answer in answers {
                var answerData = [String: Any]()
                answerData["name"] = answer
                answerData["votes"] = 0
                answersData.append(answerData)
            }
            data["answers"] = answersData
            
            let docRef = db.collection("polls").document();
            data["docId"] = docRef.documentID
            
            docRef.setData(data) { error in
                if let error = error {
                    print("Failed to create poll: \(error.localizedDescription)")
                } else {
                    print("Poll created successfully")
                    self.dismiss(animated: true)
                }
            }
            
            /*
             polls/poll1
                 - name: "Programming Language"
                 - question: "What is your fav programming lang"
                 - creatorId: userid
                 - creatorName: "Bob Smith"
                 - answers :[
                     {name:"Java", votes: 3},
                     {name:"Swift", votes: 1},
                     {name:"Other", votes: 1},
                 ]
                 - completedBy : ["user_1", "user_2", ...]
             */
            
            
        }
    }
    
    
    @IBAction func closeClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension CreatePollViewController: AnswerAddTableViewCellDelegate {
    func deleteClicked(answer: String) {
        //remove answer from the array of answers
        var temp = [String]()
        for a in answers {
            if a != answer {
                temp.append(a)
            }
        }
        answers.removeAll()
        answers.append(contentsOf: temp)
        tableView.reloadData()
    }
}


extension CreatePollViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerAddTableViewCell", for: indexPath) as! AnswerAddTableViewCell
        let answer = answers[indexPath.row]
        cell.bind(answer: answer, delegate: self)
        cell.nameLabel.text = answer
        return cell
    }
}
