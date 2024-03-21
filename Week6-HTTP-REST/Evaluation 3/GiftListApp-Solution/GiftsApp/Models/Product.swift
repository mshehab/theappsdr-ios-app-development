//
//  Product.swift
//  GiftsApp
//
//  Created by Mohamed Shehab on 3/19/24.
//

import Foundation
import SwiftyJSON

class Product {
    let pid: String
    let name: String
    let img_url : String
    let price: Double
    var count: Int = 0
    
    init(_ json: JSON) {
        self.pid = json["pid"].stringValue
        self.name = json["name"].stringValue
        self.img_url = json["img_url"].stringValue
        self.price = json["price"].doubleValue
        self.count = 0
    }
}
