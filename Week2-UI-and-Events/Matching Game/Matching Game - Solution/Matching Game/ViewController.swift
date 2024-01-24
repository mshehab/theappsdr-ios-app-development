//
//  ViewController.swift
//  Matching Game
//
//  Created by Mohamed Shehab on 1/23/24.
//

import UIKit

class ViewController: UIViewController {

    let cardNames = ["card1", "card2", "card3", "card4", "card5", "card6", "card7", "card8"]
    var tilesMap = [Int: CardInfo]()
    
    @IBOutlet weak var gameStatusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupGame()
    }
    
    func setupGame() {
        var shuffledCardNames = [String]()
        shuffledCardNames.append(contentsOf: cardNames)
        shuffledCardNames.append(contentsOf: cardNames)
        shuffledCardNames = shuffledCardNames.shuffled()
        
        tilesMap.removeAll()
        
        for i in 0...15 {
            let tag : Int = 100 + i
            let cardName = shuffledCardNames[i]
            let cardInfo = CardInfo(tag: tag, cardName: cardName)
            tilesMap[tag] = cardInfo
            
            let button = view.viewWithTag(tag) as! UIButton
            //button.configuration?.background.image = UIImage(named: cardName)
            button.configuration?.background.image = UIImage(named: "covered_tile")
            
        }
        matchCount = 0
        self.gameStatusLabel.text = "Match Count: \(self.matchCount)"
    }
    

    @IBAction func resetGameClicked(_ sender: Any) {
        if !isWaiting {
            setupGame()
        }
    }
    
    func coverCard(_ cardInfo: CardInfo){
        let button = view.viewWithTag(cardInfo.tag) as! UIButton
        button.configuration?.background.image = UIImage(named: "covered_tile")
        cardInfo.isFlipped = false
    }
    
    var cardInfo1: CardInfo?
    var isWaiting = false
    var matchCount = 0
    
    @IBAction func tileClicked(_ sender: Any) {
        let buttonClicked = sender as! UIButton
        let tag : Int = buttonClicked.tag
        
        if !isWaiting {
            if let cardInfo = tilesMap[tag] {
                if !cardInfo.isMatched && !cardInfo.isFlipped {
                    cardInfo.isFlipped = true
                    buttonClicked.configuration?.background.image = UIImage(named: cardInfo.cardName)
                    
                    if self.cardInfo1 == nil {
                        self.cardInfo1 = cardInfo
                    } else {
                        
                        if self.cardInfo1!.cardName == cardInfo.cardName {
                            //match
                            cardInfo.isMatched = true
                            cardInfo1!.isMatched = true
                            cardInfo1 = nil
                            self.matchCount = self.matchCount + 1
                            self.gameStatusLabel.text = "Match Count: \(self.matchCount)"
                            
                            if self.matchCount == 8 {
                                self.gameStatusLabel.text = "Game Completed !!"
                            }
                            
                        } else {
                            self.isWaiting = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.coverCard(cardInfo)
                                self.coverCard(self.cardInfo1!)
                                self.cardInfo1 = nil
                                self.isWaiting = false
                            }
                            
                        }
                    }
                    
                }
            }
        }
        
        
        
    }
}

