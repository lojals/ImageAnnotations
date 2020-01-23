//
//  Coordinate.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 22/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Foundation

struct Coordinate: Encodable {
    let x: CGFloat
    let y: CGFloat
    let width: CGFloat
    let height: CGFloat
    
    var rect: NSRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    init(rect: NSRect) {
        self.x = rect.origin.x
        self.y = rect.origin.y
        self.width = rect.width
        self.height = rect.height
    }
    
    init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }
    
    static let zero = Coordinate(rect: .zero)
}
