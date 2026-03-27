//
//  Task.swift
//  Assignment09
//
//  Created by Mohamed Shehab on 3/18/26.
//
import Foundation
import FirebaseFirestore

class Poll  {
    var name: String?
    var question: String?
    var creatorId: String?
    var creatorName: String?
    var docId: String?
    var answers = [[String: Any]]()
    var completedBy = [String]()
    
    init(snapshot: QueryDocumentSnapshot) {
        self.name = snapshot.get("name") as? String
        self.question = snapshot.get("question") as? String
        self.creatorId = snapshot.get("creatorId") as? String
        self.creatorName = snapshot.get("creatorName") as? String
        self.docId = snapshot.get("docId") as? String
        self.answers = snapshot.get("answers") as? [[String: Any]] ?? [[String: Any]]()
        self.completedBy = snapshot.get("completedBy") as? [String] ?? [String]()
    }
    
    /*
     polls/poll1
         - name: "Programming Language"
         - question: "What is your fav programming lang"
         - creatorId: userid
         - creatorName: "Bob Smith"
         - answers :[
             {name:"Java", votes: 3},
             {name:"Swift", votes: 1},
             {name:"Other", votes: 1},
         ]
         - completedBy : ["user_1", "user_2", ...]
     */
}


