//
//  Grade.swift
//  GradesApp
//
//  Created by Mohamed Shehab on 3/25/24.
//

import Foundation
import FirebaseFirestore

class Grade {
    var docId: String?
    var courseName: String?
    var courseNumber: String?
    var courseHours: Double?
    var semester: String?
    var letterGrade : String?
    var numericGrade : Double?
    var userUid: String?
    
    init(_ snapshot: QueryDocumentSnapshot){
        
        if let value = snapshot["docId"] as? String {
            self.docId = value
        }
        
        if let value = snapshot["courseName"] as? String {
            self.courseName = value
        }
        
        if let value = snapshot["courseNumber"] as? String {
            self.courseNumber = value
        }
        
        if let value = snapshot["courseHours"] as? Double {
            self.courseHours = value
        }
        
        if let value = snapshot["semester"] as? String {
            self.semester = value
        }
        
        if let value = snapshot["letterGrade"] as? String {
            self.letterGrade = value
        }
        
        if let value = snapshot["numericGrade"] as? Double {
            self.numericGrade = value
        }
        
        if let value = snapshot["userUid"] as? String {
            self.userUid = value
        }
        
    }
    
}
