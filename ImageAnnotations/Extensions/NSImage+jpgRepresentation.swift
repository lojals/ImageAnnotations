//
//  NSImage+jpgRepresentation.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 22/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Cocoa

extension NSImage {
    
    var jpgData: Data? {
        guard let tiffRepresentation = tiffRepresentation, let bitmapImage = NSBitmapImageRep(data: tiffRepresentation) else { return nil }
        return bitmapImage.representation(using: .jpeg, properties: [:])
    }
    
}

extension CGRect: Comparable {
    public static func < (lhs: CGRect, rhs: CGRect) -> Bool {
        return (lhs.width * lhs.height) < (lhs.height * lhs.width)
    }
    
    public static func > (lhs: CGRect, rhs: CGRect) -> Bool {
        return (lhs.width * lhs.height) > (lhs.height * lhs.width)
    }
}
