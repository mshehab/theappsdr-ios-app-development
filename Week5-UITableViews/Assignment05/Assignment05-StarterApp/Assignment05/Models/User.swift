//
//  User.swift
//  Assignment05
//
//  Created by Mohamed Shehab on 2/11/24.
//

import Foundation

class User {
    var name: String
    var email: String
    var gender: String
    var age: Int
    var state: String
    var group: String
    
    init(name: String, email: String, gender: String, age: Int, state: String, group: String) {
        self.name = name
        self.email = email
        self.gender = gender
        self.age = age
        self.state = state
        self.group = group
    }
}
