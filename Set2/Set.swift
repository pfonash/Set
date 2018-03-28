//
//  Set.swift
//  Set
//
//  Created by Fonash, Peter S on 1/4/18.
//  Copyright © 2018 Fonash, Peter S. All rights reserved.
//

import Foundation


struct Set {
    
    private(set) var score = 0
    
    var cardsToDealFrom = [Card]()
    var cardsInPlay = [Card]()
    var selectedCards = [Card]()
    var matchedCards = [Card]()
    
    let colors = [Color.Blue, Color.Yellow, Color.Magenta]
    let shapes = [Shape.Oval, Shape.Triangle, Shape.Square]
    let shadings = [Shading.Open, Shading.Solid, Shading.Striped]
    let numbers = [1, 2, 3]
    
    init(numberOfCards: Int) {
        
        makeCards()
        dealCards(numberOfCards: numberOfCards)
    }
    
    private mutating func dealCards(numberOfCards: Int) {
        
        for _ in 0..<numberOfCards {
            let randomIndex = cardsToDealFrom.count.arc4random
            cardsInPlay.append(cardsToDealFrom.remove(at: randomIndex))
        }
    }
    
    mutating func dealMoreCards(numberOfCards: Int) {
        
        if cardsInPlay.count + numberOfCards < 24 {
            dealCards(numberOfCards: numberOfCards)
        }
    }
    
    mutating func select(index: Int) -> Bool {        
        
        let cardForButton = cardsInPlay[index]

        if let index = selectedCards.index(of: cardForButton) {
            selectedCards.remove(at: index)
            return false
        }
        
        // Else
        selectedCards.append(cardForButton)
        return true
    }
    
    func readyToMatch() -> Bool { return selectedCards.count == 3 }
    
    func match() -> Bool {
        
        let match = doMatch(card1: selectedCards[0], card2: selectedCards[1], card3: selectedCards[2])
        calculateNewScore()
        return match
        
    }
    
    private func calculateNewScore() {
        
    }
    
    private func allSame(p: [Any]) -> Bool {
        
        
    }
    
    private func doMatch(card1: Card, card2: Card, card3: Card) -> Bool {
        
        let colors = [card1.color, card2.color, card3.color].reduce(true,  { c1, c2 in c1 == c2 })
    }
    
    func newGame() {
        
        
    }
    
    private mutating func makeCards() {
        
        for color in colors {
            for shape in shapes {
                for number in numbers {
                    for shading in shadings {
                        cardsToDealFrom.append(Card(color: color, shape: shape, shading: shading, number: number))
                    }
                }
            }
        }
    }
    
    
}

extension Int {
    
    var arc4random: Int {
        
        if self  > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0 {
            return -(Int(arc4random_uniform(UInt32(self))))
        }
        else {
            return 0
        }
    }
}
