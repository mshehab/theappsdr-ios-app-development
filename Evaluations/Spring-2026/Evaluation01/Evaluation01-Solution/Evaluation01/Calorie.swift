//
//  Calorie.swift
//  Evaluation01
//
//  Created by Mohamed Shehab on 2/18/26.
//

import Foundation

class Calorie {
    let age: Int
    let gender: String
    let weight: Double
    let heightFt: Double
    let heightIn: Double
    let activityLevel: String
    let bmr: Double
    let tdee: Double
    
    init(age: Int, gender: String, weight: Double, heightFt: Double, heightIn: Double, activityLevel: String) {
        self.age = age
        self.gender = gender
        self.weight = weight
        self.heightFt = heightFt
        self.heightIn = heightIn
        self.activityLevel = activityLevel
        
        var genderFactor : Double = 5.0
        
        if gender == "Female"{
            genderFactor = -161.0
        }
        
        var tempBmr: Double = ((10.0 * weight) / (2.205))  + (15.875 * ((12.0 * heightFt) + heightIn))
        tempBmr = tempBmr - (5.0 * Double(age)) + genderFactor
        bmr = tempBmr
        
        
        
        
        if activityLevel == "Sedentary"{
            tdee = bmr * 1.2
        } else if activityLevel == "Lightly active"{
            tdee = bmr * 1.375
        } else if activityLevel == "Moderately active"{
            tdee = bmr * 1.55
        } else if activityLevel == "Very active"{
            tdee = bmr * 1.725
        } else {
            tdee = bmr * 1.9
        }
    }
    
    
    
}
