//
//  PollResultsViewController.swift
//  Evaluation03
//
//  Created by Mohamed Shehab on 3/25/26.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class PollResultsViewController: UIViewController {
    var poll: Poll?
    @IBOutlet weak var pollNameLabel: UILabel!
    @IBOutlet weak var pollQuestionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "AnswerStatsTableViewCell", bundle: nil), forCellReuseIdentifier: "AnswerStatsTableViewCell")
        self.pollNameLabel.text = poll?.name ?? ""
        self.pollQuestionLabel.text = poll?.question ?? ""
    }
}


extension PollResultsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return poll?.answers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerStatsTableViewCell", for: indexPath) as! AnswerStatsTableViewCell
        let answer = poll?.answers[indexPath.row]
        
        cell.nameLabel.text = answer?["name"] as? String ?? ""
        
        cell.countLabel.text = "\(answer?["votes"] ?? 0)"
        
        
        return cell
    }
}
