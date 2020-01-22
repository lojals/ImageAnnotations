//
//  NSRect+Comparable.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 22/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Cocoa

extension CGRect: Comparable {
    public static func < (lhs: CGRect, rhs: CGRect) -> Bool {
        return (lhs.width * lhs.height) < (lhs.height * lhs.width)
    }
    
    public static func > (lhs: CGRect, rhs: CGRect) -> Bool {
        return (lhs.width * lhs.height) > (lhs.height * lhs.width)
    }
}
