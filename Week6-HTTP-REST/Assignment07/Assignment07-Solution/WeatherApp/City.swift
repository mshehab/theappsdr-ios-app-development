//
//  City.swift
//  WeatherApp
//
//  Created by Mohamed Shehab on 3/15/24.
//

import Foundation
import SwiftyJSON

class City {
    var name : String = ""
    var state : String = ""
    var lat : Double = 0.0
    var lng : Double = 0.0
    
    init(_ json: JSON){
        
        self.name = json["name"].stringValue
        self.state = json["state"].stringValue
        self.lat = json["lat"].doubleValue
        self.lng = json["lng"].doubleValue
    }
    
}
