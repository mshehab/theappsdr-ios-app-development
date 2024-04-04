//
//  ReviewCourseViewController.swift
//  GradesApp
//
//  Created by Mohamed Shehab on 3/25/24.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ReviewCourseViewController: UIViewController {
    @IBOutlet weak var courseNumberLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var courseHoursLabel: UILabel!
    @IBOutlet weak var reviewTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var course: Course?
    var courseReview : CourseReview?
    
    
    var reviews = [Review]()
    let db = Firestore.firestore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "ReviewTableViewCell")
        
        self.courseNameLabel.text = course!.name
        self.courseNumberLabel.text = course!.number
        self.courseHoursLabel.text = "\(course!.hours!) Credit Hours"
        
        db.collection("reviews").whereField("courseId", isEqualTo: self.course!.courseId!).addSnapshotListener { snapshot, error in
            
            if let error = error {
                self.showAlertWith(title: "Reviews Error", message: error.localizedDescription, okAlertAction: nil)
            } else {
                self.reviews.removeAll()
                if let snapshot = snapshot {
                    if !snapshot.isEmpty {
                        for doc in snapshot.documents {
                            self.reviews.append(Review(doc))
                        }
                    }
                }
                self.tableView.reloadData()
            }
            
        }
        
        
        db.collection("courses").document(course!.courseId!).addSnapshotListener { snapshot, error in
            
            if let error = error {
                self.showAlertWith(title: "Reviews Error", message: error.localizedDescription, okAlertAction: nil)
            } else {
                if let snapshot = snapshot {
                    if snapshot.exists {
                        self.courseReview = CourseReview(snapshot)
                    }
                }
            }
        }
        
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        let reviewText = self.reviewTextField.text!
        if reviewText.isEmpty {
            showAlertWith(title: "Review Error", message: "Enter review text !", okAlertAction: nil)
        } else {
            
            let docRef = db.collection("reviews").document()
            let data : [String: Any] = [
                "docId" : docRef.documentID,
                "reviewText" : reviewText,
                "createdAt" : FieldValue.serverTimestamp(),
                "uid" : Auth.auth().currentUser!.uid,
                "uName" : Auth.auth().currentUser!.displayName!,
                "courseId" : course!.courseId!
            ]
            docRef.setData(data) { error in
                if let error = error {
                    
                } else {
                    
                }
            }
            
            if courseReview == nil {
                let data : [String:Any] = [
                    "courseId" : self.course!.courseId!,
                    "likeUids" : [String](),
                    "reviewsCount" : 1
                ]
                db.collection("courses").document(self.course!.courseId!).setData(data)
            } else {
                let data : [String:Any] = [
                    "reviewsCount" : FieldValue.increment(1.0)
                ]
                db.collection("courses").document(self.course!.courseId!).updateData(data)
            }
            
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
        
        cell.reviewLabel.text = review.reviewText!
        cell.createdByNameLabel.text = review.uName!
        
        if let createdAt = review.createdAt {
            cell.createdAtLabel.text = createdAt.dateValue().formatted(date: .long, time: .shortened)
            
        } else {
            cell.createdAtLabel.text = "N/A"
        }
        
        if review.uid! == Auth.auth().currentUser!.uid {
            cell.deleteButton.isHidden = false
        } else {
            cell.deleteButton.isHidden = true
        }
        return cell
    }
}

extension ReviewCourseViewController: ReviewDelegate{
    func deleteClicked(_ review: Review) {
        db.collection("reviews").document(review.docId!).delete()
        
        
        if courseReview == nil {
            let data : [String:Any] = [
                "courseId" : self.course!.courseId!,
                "likeUids" : [String](),
                "reviewsCount" : 0
            ]
            db.collection("courses").document(self.course!.courseId!).setData(data)
        } else {
            let data : [String:Any] = [
                "reviewsCount" : FieldValue.increment(-1.0)
            ]
            db.collection("courses").document(self.course!.courseId!).updateData(data)
        }
    }
}
