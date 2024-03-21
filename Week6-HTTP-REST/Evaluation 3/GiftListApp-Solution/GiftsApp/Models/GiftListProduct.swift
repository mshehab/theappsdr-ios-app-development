//
//  GiftListProduct.swift
//  GiftsApp
//
//  Created by Mohamed Shehab on 3/19/24.
//

import Foundation
import SwiftyJSON

class GiftListProduct {
    let pid: String
    var count: Int
    let name: String
    let price: Double
    let img_url: String
    
    init(_ json: JSON) {
        self.pid = json["pid"].stringValue
        self.count = json["count"].intValue
        self.name = json["name"].stringValue
        self.price = json["price_per_item"].doubleValue
        self.img_url = json["img_url"].stringValue
    }
}
