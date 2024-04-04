//
//  File.swift
//  Assignment09
//
//  Created by Mohamed Shehab on 3/25/24.
//

import Foundation
import Firebase
class Post {

    var postText: String?
    var createdByName: String?
    var createdByUid: String?
    var createdAt: Timestamp?
    var docId: String?
    
    init(_ snapshot: QueryDocumentSnapshot){
        
        if let value = snapshot["createdAt"] as? Timestamp {
            self.createdAt = value
        } else {
            createdAt = nil
        }

        if let value = snapshot["createdByName"] as? String {
            self.createdByName = value
        } else {
            createdByName = "N/A"
        }
        
        if let value = snapshot["createdByUid"] as? String {
            self.createdByUid = value
        } else {
            createdByUid = "N/A"
        }
        
        if let value = snapshot["docId"] as? String {
            self.docId = value
        } else {
            docId = "N/A"
        }
        
        if let value = snapshot["postText"] as? String {
            self.postText = value
        } else {
            postText = "N/A"
        }
    }
    
}
