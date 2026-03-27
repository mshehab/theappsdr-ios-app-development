//
//  CreatePollViewController.swift
//  Evaluation03
//
//  Created by Mohamed Shehab on 3/25/26.
//

import UIKit

class CreatePollViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pollNameTextField: UITextField!
    @IBOutlet weak var pollQuestionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    var answers = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answers.append("Answer 1")
        answers.append("Answer 2")
        
        tableView.register(UINib(nibName: "AnswerAddTableViewCell", bundle: nil), forCellReuseIdentifier: "AnswerAddTableViewCell")
    }
    
    @IBAction func addClicked(_ sender: Any) {
        let answer = answerTextField.text ?? ""
        if answer.isEmpty {
            showAlert(title: "Error", message: "Answer cannot be empty")
        } else {
        
            
            
        }
    }
    
    @IBAction func submitClicked(_ sender: Any) {
    }
    
    
    @IBAction func closeClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension CreatePollViewController: AnswerAddTableViewCellDelegate {
    func deleteClicked(answer: String) {
        
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
