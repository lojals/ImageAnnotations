//
//  AnnotationView.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 10/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Cocoa

final class AnnotationView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        layer?.borderColor = NSColor.red.cgColor
        layer?.borderWidth = 2
        layer?.backgroundColor = NSColor(calibratedRed: 1, green: 0, blue: 0, alpha: 0.5).cgColor
    }

    @objc func remove() {
        
    }
}
