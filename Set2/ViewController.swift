//
//  ViewController.swift
//  Set
//
//  Created by Fonash, Peter S on 1/3/18.
//  Copyright © 2018 Fonash, Peter S. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
        
    private var game = Set(numberOfCards: 12)
    
    @IBOutlet var cardButtons: [UIButton]! {
        didSet {
            updateViewFromModel()            
        }
    }
    @IBOutlet weak var scoreLabel: UILabel! {
        didSet {
            updateScoreFromModel()
        }
    }
    
    @IBAction func Select(_ sender: UIButton) {
        
        let buttonIndex = cardButtons.index(of: sender)!
        let button = cardButtons[buttonIndex]
        
        if game.select(index: buttonIndex) {

            if game.readyToMatch() {
                game.match()
                updateScoreFromModel()
                game.selectedCards.removeAll()
            }
            else {
                button.layer.borderColor = #colorLiteral(red: 0.1874154806, green: 0.647511363, blue: 0.880682528, alpha: 1)
                button.layer.borderWidth = 3.0
            }
        }
        // If couldn't select button, it's already selected.
        else {
            
            button.layer.borderColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            button.layer.borderWidth = 1.0
            
        }  
    }
    
    @IBAction func dealThreeMore(_ sender: UIButton) {
        game.dealMoreCards(numberOfCards: 3)
        updateViewFromModel()
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        
    }
    
    private func updateScoreFromModel() {
        scoreLabel.text = "Score: \(game.score)"
    }

    private func updateViewFromModel() {
        
        for index in 0..<game.cardsInPlay.count {
            
            let button = cardButtons[index]
            let card = game.cardsInPlay[index]
            let title = makeTitle(with: card)
            
            button.setAttributedTitle(title, for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
        }
    }
    
    private func makeTitle(with card: Card) -> NSAttributedString {
        
        var color: UIColor?
        var shading: Float?
        var stringShape: String?
        let fontSize: Float = 20.0
        var strokeWidth: Float?
        
        switch card.color {
            
        case .Blue: color = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        case .Magenta: color = #colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1)
        case .Yellow: color = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
            
        }
        
        switch card.shading {
            
        case .Open:
            shading = 0.0
            strokeWidth = 5.0
            
        case .Solid:
            shading = 1.0
            strokeWidth = -8.0
            
        case .Striped:
            shading = 0.15
            strokeWidth = -8.0
    
        }
        
        switch card.shape {

            
        case .Oval: stringShape = "●"
        case .Square: stringShape = "■"
        case .Triangle: stringShape = "▲"
            
        }
        
        stringShape = String(repeating: stringShape!, count: card.number)
        
        let attributes: [NSAttributedStringKey: Any] = [
            
            .font: UIFont.systemFont(ofSize: fontSize.cgFloat),
            .strokeWidth: strokeWidth!,
            .foregroundColor: color!.withAlphaComponent(shading!.cgFloat),
            .strokeColor: color!
        ]
        return NSAttributedString(string: stringShape!, attributes: attributes)
        
    }
}

extension Float {
    
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
}



