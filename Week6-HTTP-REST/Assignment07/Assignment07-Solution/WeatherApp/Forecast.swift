//
//  Forecast.swift
//  WeatherApp
//
//  Created by Mohamed Shehab on 3/15/24.
//

import Foundation
import SwiftyJSON

class Forecast {
    var startTime : String = ""
    var temperatureUnit : String = "F"
    var windSpeed: String = ""
    var shortForecast : String = ""
    var iconUrl : String = ""
    
    var temperature : Double = 0.0
    var relativeHumidity : Double = 0.0
    
    init(_ json : JSON){
        startTime = json["startTime"].stringValue
        temperatureUnit = json["temperatureUnit"].stringValue
        windSpeed = json["windSpeed"].stringValue
        shortForecast = json["shortForecast"].stringValue
        iconUrl = json["icon"].stringValue
        
        temperature = json["temperature"].doubleValue
        relativeHumidity = json["relativeHumidity"]["value"].doubleValue
    }
    
    
    /*
     {
                     "name": "This Afternoon",
                     "startTime": "2024-03-15T14:00:00-05:00",
                     "temperature": 45,
                     "temperatureUnit": "F",
     
                     "relativeHumidity": {
                         "unitCode": "wmoUnit:percent",
                         "value": 85
                     },
                     "windSpeed": "5 to 10 mph",
                     "icon": "https://api.weather.gov/icons/land/day/few?size=medium",
                     "shortForecast": "Sunny",
                     "detailedForecast": "Sunny. High near 45, with temperatures falling to around 40 in the afternoon. Northeast wind 5 to 10 mph."
                 },
     */
}
