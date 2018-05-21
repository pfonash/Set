//
//  Card.swift
//  Set
//
//  Created by Fonash, Peter S on 1/4/18.
//  Copyright © 2018 Fonash, Peter S. All rights reserved.
//

import Foundation

struct Card: Equatable {
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        
        return (
            (lhs.color == rhs.color) &&
            (lhs.shape == rhs.shape) &&
            (lhs.shading == rhs.shading) &&
            (lhs.number == rhs.number)
        )
        
    }
    
    private var identifier: Int
    private(set) var color: Color
    private(set) var shape: Shape
    private(set) var shading: Shading
    private(set) var number: Int
    
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init(color: Color, shape: Shape, shading: Shading, number: Int) {
        
        self.color = color
        self.shape = shape
        self.shading = shading
        self.number = number
        self.identifier = Card.getUniqueIdentifier()
    }
}
