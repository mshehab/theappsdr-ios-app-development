//
//  CourseReviewsViewController.swift
//  GradesApp
//
//  Created by Mohamed Shehab on 3/25/24.
//

import UIKit
import PKHUD
import Alamofire
import SwiftyJSON
import FirebaseAuth
import FirebaseFirestore

class CourseReviewsViewController: UIViewController {

    var courseReviews = [CourseReview]()
    var courses = [Course]()
    let db = Firestore.firestore()
    
    var courseMap = [String:CourseReview]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "CourseReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "CourseReviewTableViewCell")
        getCourses()
        
        db.collection("courses").addSnapshotListener { snapshot, error in
            if let error = error {
                self.showAlertWith(title: "Courses Error", message: error.localizedDescription, okAlertAction: nil)
            } else {
                self.courseMap.removeAll()
                
                if let snapshot = snapshot {
                    if !snapshot.isEmpty {
                        for doc in snapshot.documents {
                            print(doc.data())
                            let courseReview = CourseReview(doc)
                            self.courseMap[courseReview.courseId!] = courseReview
                        }
                    }
                }
                self.tableView.reloadData()
            }
        }
    }
    
   
    
    func getCourses(){
        courses.removeAll()
        HUD.show(.labeledProgress(title: "Loading Courses", subtitle: "Please Wait!"))
        AF.request("https://www.theappsdr.com/api/cci-courses")
            .validate(statusCode: 200..<300)
                .responseData { response in
                    HUD.hide()
                    switch response.result {
                    case .success:
                        if let data = response.data {
                            if let json = try? JSON(data: data) {
                                let coursesArray = json["courses"].arrayValue
                                for item in coursesArray {
                                    self.courses.append(Course(item))
                                }
                                self.tableView.reloadData()
                            } else {
                                self.showAlertWith(title: "Course Error", message: "Unable to load courses", okAlertAction: nil)
                            }
                        } else {
                            self.showAlertWith(title: "Course Error", message: "Unable to load courses", okAlertAction: nil)
                        }
                        
                    case let .failure(error):
                        print(error)
                        self.showAlertWith(title: "Course Error", message: "Unable to load courses", okAlertAction: nil)
                    }
                }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GotoReviewCourseSegue" {
            let vc = segue.destination as! ReviewCourseViewController
            let indexPath = self.tableView.indexPathForSelectedRow!
            vc.course = self.courses[indexPath.row]
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

extension CourseReviewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseReviewTableViewCell", for: indexPath) as! CourseReviewTableViewCell
        let course = self.courses[indexPath.row]
        cell.bind(course: course, courseReviewDelegate: self)
        
        cell.courseNameLabel.text = course.name
        cell.courseNumberLabel.text = course.number
        cell.creditHoursLabel.text = "\(course.hours!) Credit Hours"
        
        
        if let courseReview = self.courseMap[course.courseId!] {
            
            if courseReview.likeUids.contains(Auth.auth().currentUser!.uid) {
                cell.heartButton.configuration?.background.image = UIImage(named: "ic_heart_full")
            } else {
                cell.heartButton.configuration?.background.image = UIImage(named: "ic_heart_empty")
            }
            
            cell.numReviewsLabel.text = "\(courseReview.reviewsCount) Reviews"
            
        } else {
            cell.numReviewsLabel.text = "0 Reviews"
            cell.heartButton.configuration?.background.image = UIImage(named: "ic_heart_empty")
        }
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GotoReviewCourseSegue", sender: self)
        
    }
}

extension CourseReviewsViewController : CourseReviewDelegate{
    func heartClicked(_ course: Course) {
        
        if let courseReview = self.courseMap[course.courseId!] {
            
            if courseReview.likeUids.contains(Auth.auth().currentUser!.uid) {
                
                let data : [String:Any] = [
                    "likeUids" : FieldValue.arrayRemove([Auth.auth().currentUser!.uid])
                ]
                db.collection("courses").document(course.courseId!).updateData(data)
                
            } else {
                let data : [String:Any] = [
                    "likeUids" : FieldValue.arrayUnion([Auth.auth().currentUser!.uid])
                ]
                db.collection("courses").document(course.courseId!).updateData(data)
            }
            
        } else {
            let data : [String:Any] = [
                "courseId" : course.courseId!,
                "likeUids" : [Auth.auth().currentUser!.uid],
                "reviewsCount" : 0
            ]
            db.collection("courses").document(course.courseId!).setData(data)
        }
        
    }
}
