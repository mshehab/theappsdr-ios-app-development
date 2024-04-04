//
//  Review.swift
//  GradesApp
//
//  Created by Mohamed Shehab on 3/25/24.
//

import Foundation
import Firebase

class Review {
    
    var docId:String?
    var reviewText:String?
    var createdAt:Timestamp?
    var uid:String?
    var uName:String?
    var courseId:String?
    
    init(_ snapshot: QueryDocumentSnapshot){
        
        if let value = snapshot["docId"] as? String {
            self.docId = value
        }
        
        if let value = snapshot["reviewText"] as? String {
            self.reviewText = value
        }
        
        if let value = snapshot["createdAt"] as? Timestamp {
            self.createdAt = value
        }
        
        if let value = snapshot["uid"] as? String {
            self.uid = value
        }
        
        if let value = snapshot["uName"] as? String {
            self.uName = value
        }
        
        if let value = snapshot["courseId"] as? String {
            self.courseId = value
        }
    }
    
}
