//
//  Response.swift
//  Assignment04
//
//  Created by Mohamed Shehab on 2/19/24.
//

import Foundation

class Response {
    let name:String
    let email:String
    let role:String
    
    var education:String?
    var income:String?
    
    init(name: String, email: String, role: String) {
        self.name = name
        self.email = email
        self.role = role
    }
}
