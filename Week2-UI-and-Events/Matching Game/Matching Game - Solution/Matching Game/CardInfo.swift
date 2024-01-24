//
//  CardInfo.swift
//  Matching Game
//
//  Created by Mohamed Shehab on 1/23/24.
//

import Foundation

class CardInfo {
    let tag: Int
    let cardName: String
    var isFlipped = false
    var isMatched = false
    
    init(tag: Int, cardName: String) {
        self.tag = tag
        self.cardName = cardName
    }
}
