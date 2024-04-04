//
//  CourseReview.swift
//  GradesApp
//
//  Created by Mohamed Shehab on 3/25/24.
//

import Foundation
import FirebaseFirestore


class CourseReview {
    var courseId:String?
    var likeUids = [String]()
    var reviewsCount : Int = 0
    
    
    
    init(_ snapshot: QueryDocumentSnapshot){
        
        if let value = snapshot["courseId"] as? String {
            self.courseId = value
        }
        
        if let value = snapshot["likeUids"] as? [String] {
            self.likeUids = value
        }
        
        if let value = snapshot["reviewsCount"] as? Int {
            self.reviewsCount = value
        }
        
    }
    
    init(_ snapshot: DocumentSnapshot){
        
        if let value = snapshot["courseId"] as? String {
            self.courseId = value
        }
        
        if let value = snapshot["likeUids"] as? [String] {
            self.likeUids = value
        }
        
        if let value = snapshot["reviewsCount"] as? Int {
            self.reviewsCount = value
        }
        
    }
    
    
}
