//
//  MyGradesViewController.swift
//  GradesApp
//
//  Created by Mohamed Shehab on 3/25/24.
//

import UIKit
import Firebase

class MyGradesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var gpaLabel: UILabel!
    
    var grades = [Grade]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "GradesTableViewCell", bundle: nil), forCellReuseIdentifier: "GradesTableViewCell")
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
    
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            SceneDelegate.showLogin()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
            showAlertWith(title: "Logout Error", message: signOutError.localizedDescription, okAlertAction: nil)
        }
        
    }
}

extension MyGradesViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return grades.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GradesTableViewCell", for: indexPath) as! GradesTableViewCell
        let grade = self.grades[indexPath.row]
        cell.bind(grade: grade, gradeDelegage: self)
        
        cell.letterGradeLabel.text = grade.letterGrade!
        cell.courseNumberLabel.text = grade.courseNumber!
        cell.courseNameLabel.text = grade.courseName!
        cell.semesterLabel.text = grade.semester!
        cell.creditHoursLabel.text = "\(grade.courseHours!) Credit Hours"
        
        return cell
    }
}

extension MyGradesViewController: GradesDelegate {
    func deleteClicked(_ grade: Grade) {
        
    }
}
