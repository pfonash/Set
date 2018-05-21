//
//  ViewController.swift
//  Set
//
//  Created by Fonash, Peter S on 1/3/18.
//  Copyright © 2018 Fonash, Peter S. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
        
    private var set = Set(numberOfCards: 12)
    
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
        if set.select(buttonIndex: buttonIndex) {
            updateBorderOn(button: cardButtons[buttonIndex], with: "Blue")
            if set.readyToMatch() {
                set.match()
                updateViewAfterMatch()
            }
        }
    }
    
    @IBAction func dealThreeMore(_ sender: UIButton) {
        set.dealMoreCards(numberOfCards: 3)
        updateViewFromModel()
    }
    
    @IBAction func newGame(_ sender: UIButton) {
    }
    
    private func updateScoreFromModel() {
        scoreLabel.text = "Score: \(set.score)"
    }
    
    private func updateBorderOn(button: UIButton, with color: String) {
        
        button.layer.borderWidth = 3.0
        
        switch color {
        case "Blue":
            button.layer.borderColor = #colorLiteral(red: 0.1874154806, green: 0.647511363, blue: 0.880682528, alpha: 1)
            
        case "Green":
            button.layer.borderColor = #colorLiteral(red: 0, green: 0.6491959691, blue: 0.1914409697, alpha: 1)
            
        case "Magenta":
            button.layer.borderColor = #colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1)
        
        case "White":
            button.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            
        case "Red":
            button.layer.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)

        default:
            break
        }
    }

    private func updateViewFromModel() {
        
        for index in 0..<set.cardsInPlay.count {
            
            let button = cardButtons[index]
            let card = set.cardsInPlay[index]
            let title = makeTitle(with: card)
            
            button.setAttributedTitle(title, for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
        
        private func updateViewAfterMatch() {
            if set.isMatch {
                let _ = set.selectedIndexes.map {
                    updateBorderOn(button: cardButtons[$0], with: "Green")}
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // change 2 to desired number of seconds
                    let _ = self.set.selectedIndexes.map {self.cardButtons[$0].isHidden = true }
                    self.set.resetSelected()
                }
                
            } else {
                let _ = set.selectedIndexes.map {

                updateBorderOn(button: cardButtons[$0], with: "Red")}
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { // change 2 to desired number of seconds
                    let _ = self.set.selectedIndexes.map {
                        self.updateBorderOn(button: self.cardButtons[$0], with: "White")}
                    self.set.resetSelected()
                }
            }
        }

    private func makeTitle(with card: Card) -> NSAttributedString {
        
        var color: UIColor?
        var shading: Float?
        var stringShape: String?
        let fontSize: Float = 25.0
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


