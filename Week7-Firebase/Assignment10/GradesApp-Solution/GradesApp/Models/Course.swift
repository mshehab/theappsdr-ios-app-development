//
//  Course.swift
//  GradesApp
//
//  Created by Mohamed Shehab on 3/25/24.
//

import Foundation
import SwiftyJSON

class Course {
    var courseId : String?
    var name : String?
    var number : String?
    var hours : Double?
    
    init(_ json: JSON){
        self.courseId = json["courseId"].stringValue
        self.name = json["name"].stringValue
        self.number = json["number"].stringValue
        self.hours = json["hours"].doubleValue
    }
    /*
     {
                "courseId": "e3a6ef8a-b1a8-4bc2-8f86-fb7f5c276c0b",
                "name": "Introduction to Computer Science I",
                "number": "ITSC 1212",
                "hours": 4
            },
     */
}
