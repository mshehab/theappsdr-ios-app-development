//
//  AddCourseViewController.swift
//  GradesApp
//
//  Created by Mohamed Shehab on 3/25/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class AddCourseViewController: UIViewController {
    var selectedSemester: Semester?
    var selectedGrade: LetterGrade?
    var selectedCourse: Course?
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var semesterLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(receivedSelectedSemester(notification:)), name: Notification.Name("NotifySelectedSemester"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(receivedSelectedGrade(notification:)), name: Notification.Name("NotifySelectedGrade"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(receivedSelectedCourse(notification:)), name: Notification.Name("NotifySelectedCourse"), object: nil)
    }
    
    @objc func receivedSelectedSemester(notification: Notification){
        self.selectedSemester = notification.object as? Semester
        self.semesterLabel.text = self.selectedSemester!.name!
    }
    
    @objc func receivedSelectedGrade(notification: Notification){
        self.selectedGrade = notification.object as? LetterGrade
        self.gradeLabel.text = self.selectedGrade!.letter!
    }
    
    @objc func receivedSelectedCourse(notification: Notification){
        self.selectedCourse = notification.object as? Course
        self.courseLabel.text = self.selectedCourse!.number!
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        if selectedSemester == nil {
            self.showAlertWith(title: "Create Course Error", message: "Select a semester!", okAlertAction: nil)
        } else if selectedCourse == nil {
            self.showAlertWith(title: "Create Course Error", message: "Select a course!", okAlertAction: nil)
        } else if selectedGrade == nil {
            self.showAlertWith(title: "Create Course Error", message: "Select a grade!", okAlertAction: nil)
        } else {
            
            let docRef = db.collection("grades").document()
            
            let data : [String:Any] = [
                "docId":docRef.documentID,
                "courseName":selectedCourse!.name!,
                "courseNumber":selectedCourse!.number!,
                "courseHours":selectedCourse!.hours!,
                "semester":selectedSemester!.name!,
                "letterGrade": selectedGrade!.letter!,
                "numericGrade": selectedGrade!.number!,
                "userUid":Auth.auth().currentUser!.uid
            ]
            
            docRef.setData(data) { error in
                if let error = error {
                    self.showAlertWith(title: "Create Course Error", message: error.localizedDescription, okAlertAction: nil)
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            
        }
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
