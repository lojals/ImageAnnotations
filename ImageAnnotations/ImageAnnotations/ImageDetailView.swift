//
//  ImageDetailView.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 09/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Cocoa

protocol ImageDetailViewDelegate: AnyObject {
    func addedAnnotation(name: String, coordinate: Coordinate)
    func willAddAnnotation()
}

final class ImageDetailView: NSImageView {
    
    var delegate: ImageDetailViewDelegate?
    
    private var iPoint: CGPoint = .zero
    private var ePoint: CGPoint = .zero
    
    private var annotation: AnnotationView?
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        iPoint = self.convert(event.locationInWindow, from: nil)
        annotation = AnnotationView(frame: .zero)
        annotation.flatMap { addSubview($0) }
    }
    
    override func mouseDragged(with event: NSEvent) {
        ePoint = self.convert(event.locationInWindow, from: nil)
        annotation?.frame = CGRect(x: iPoint.x, y: ePoint.y, width: ePoint.x-iPoint.x, height: iPoint.y-ePoint.y)
    }
    
    override func mouseUp(with event: NSEvent) {
        super.mouseUp(with: event)
        delegate?.willAddAnnotation()
    }
    
    func renderAnnotation(_ coordinate: Coordinate) {
        addSubview(AnnotationView(frame: coordinate.rect))
    }
}
