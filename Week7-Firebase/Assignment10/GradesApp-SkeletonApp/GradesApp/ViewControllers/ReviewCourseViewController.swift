//
//  ReviewCourseViewController.swift
//  GradesApp
//
//  Created by Mohamed Shehab on 3/25/24.
//

import UIKit

class ReviewCourseViewController: UIViewController {
    @IBOutlet weak var courseNumberLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var courseHoursLabel: UILabel!
    @IBOutlet weak var reviewTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var course: Course?
    
    
    var reviews = [Review]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "ReviewTableViewCell")
        
        self.courseNameLabel.text = course!.name
        self.courseNumberLabel.text = course!.number
        self.courseHoursLabel.text = "\(course!.hours!) Credit Hours"
        
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        let reviewText = self.reviewTextField.text!
        if reviewText.isEmpty {
            showAlertWith(title: "Review Error", message: "Enter review text !", okAlertAction: nil)
        } else {
            
        }
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ReviewCourseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as! ReviewTableViewCell
        let review = self.reviews[indexPath.row]
        cell.bind(review: review, reviewDelegate: self)
        
        
        
        return cell
    }
}

extension ReviewCourseViewController: ReviewDelegate{
    func deleteClicked(_ review: Review) {
        
    }
}
