//
//  Task.swift
//  Evaluation02
//
//  Created by Mohamed Shehab on 2/26/24.
//

import Foundation

class Task {
    var name:String
    var category:String
    var priority:Int
    var strPriority:String
    
    init(name: String, category: String, priority: Int, strPriority: String) {
        self.name = name
        self.category = category
        self.priority = priority
        self.strPriority = strPriority
    }
}
