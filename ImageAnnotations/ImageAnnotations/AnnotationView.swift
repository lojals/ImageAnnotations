//
//  AnnotationView.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 10/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Cocoa

class AnnotationView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        layer?.borderColor = NSColor.red.cgColor
        layer?.borderWidth = 2
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
