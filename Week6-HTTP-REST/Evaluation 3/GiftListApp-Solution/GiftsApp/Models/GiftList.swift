//
//  GiftList.swift
//  GiftsApp
//
//  Created by Mohamed Shehab on 3/19/24.
//

import Foundation
import SwiftyJSON

class GiftList {
    let gid:String
    let name:String
    var products = [GiftListProduct]()
    var totalCount : Int = 0
    var totalCost : Double = 0.0
    
    init(_ json: JSON) {
        self.gid = json["gid"].stringValue
        self.name = json["name"].stringValue
        
        let items = json["items"].arrayValue
        
        totalCost = 0
        totalCount = 0
        for item in items {
            let product = GiftListProduct(item)
            products.append(product)
            totalCount = totalCount + product.count
            totalCost = totalCost + (Double(product.count) * product.price)
        }
    }
}
