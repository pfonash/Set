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
    private(set) var selectedCards = [Card]()
    private(set) var selectedIndexes = [Int]()
    var matchedCards = [Card]()
    var isMatch = false
    
    let colors = Color.all
    let shapes = Shape.all
    let shadings = Shading.all
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
        
        if cardsInPlay.count + numberOfCards <= 24 {
            dealCards(numberOfCards: numberOfCards)
        }
    }
    
    mutating func select(buttonIndex: Int) -> Bool {
        
        let cardForButton = cardsInPlay[buttonIndex]

        if let cardIndex = selectedCards.index(of: cardForButton) {
            selectedCards.remove(at: cardIndex)
            selectedIndexes.remove(at: cardIndex)
            return false
        }
        selectedCards.append(cardForButton)
        selectedIndexes.append(buttonIndex)
        return true
    }
    
    func readyToMatch() -> Bool { return selectedCards.count >= 3 }
    
    mutating func match() {
        
        let match = doMatch()
        calculateNewScore()
        self.isMatch = match
    }
    
    mutating func resetSelected() {
        selectedIndexes.removeAll()
        selectedCards.removeAll()
    }
    
    func doMatch() -> Bool {
        
        // For each property, check whether they are all different, or if they are all the same
        let shapes = selectedCards.map { $0.shape }
        if shapes.allElementsDifferent() || shapes.allElementsSame()  {
            let colors = selectedCards.map{ $0.color }
            if colors.allElementsDifferent() || colors.allElementsSame() {
                let numbers = selectedCards.map{ $0.number }
                if numbers.allElementsDifferent() || numbers.allElementsSame() {
                    let shading = selectedCards.map{ $0.shading }
                    if shading.allElementsDifferent() || shading.allElementsSame() {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    private func calculateNewScore() {
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

extension Array where Element: Equatable {
    
    func allElementsSame() -> Bool {
        for element in self {
            if element != self.first {
                return false
            }
        }
        return true
    }
    
    func allElementsDifferent() -> Bool {
        
        var copy = self
        while !copy.isEmpty {
            let copyEement = copy.removeFirst()
            for element in copy {
                if element == copyEement {
                    return false
                }
            }
        }
        return true
    }
}

extension Int {
    
    var arc4random: Int {
        
        if self > 0 {
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
