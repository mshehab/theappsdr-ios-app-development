//
//  MyGradesViewController.swift
//  GradesApp
//
//  Created by Mohamed Shehab on 3/25/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class MyGradesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var gpaLabel: UILabel!
    
    var grades = [Grade]()
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "GradesTableViewCell", bundle: nil), forCellReuseIdentifier: "GradesTableViewCell")
        
        db.collection("grades").whereField("userUid", isEqualTo: Auth.auth().currentUser!.uid).addSnapshotListener { snapshot, error in
            
            if let error = error {
                self.showAlertWith(title: "Grades Error", message: error.localizedDescription, okAlertAction: nil)
            } else {
                self.grades.removeAll()
                if let snapshot = snapshot {
                    if !snapshot.isEmpty {
                        for doc in snapshot.documents {
                            self.grades.append(Grade(doc))
                        }
                    }
                }
                self.tableView.reloadData()
                self.calculateGPA()
            }
            
        }
        
        
    }
    
    func calculateGPA(){
        var totalhours : Double = 0.0
        var gpa : Double = 0.0
        
        for grade in grades {
            if grade.numericGrade != nil && grade.courseHours != nil {
                gpa = gpa + (grade.numericGrade! * grade.courseHours!)
                totalhours = totalhours + grade.courseHours!
            }
        }
        
        if totalhours > 0 {
            gpa = gpa / totalhours
            
            self.gpaLabel.text = "GPA : \(gpa)"
            self.hoursLabel.text = "Hours : \(totalhours)"
            
        } else {
            self.gpaLabel.text = "GPA : 0.00"
            self.hoursLabel.text = "Hours : 0.00"
        }
        
        
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
        db.collection("grades").document(grade.docId!).delete()
    }
}
