//
//  ImageDetailView.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 09/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Cocoa

protocol ImageDetailViewDelegate {
    func addedAnnotation(name: String, coordinate: Coordinate)
}

final class ImageDetailView: NSImageView {
    
    var delegate: ImageDetailViewDelegate?
    
    var iPoint: CGPoint = .zero
    var ePoint: CGPoint = .zero
    
    var annotation: AnnotationView?
    
    private var originalSize: NSSize?
    
    override var image: NSImage? {
        willSet {
            if originalSize == nil {
                originalSize = newValue?.size
            }
        }
    }
    
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
        
        let coordinate = Coordinate(x: self.iPoint.x, y: self.ePoint.y, width: self.ePoint.x-self.iPoint.x, height: self.iPoint.y-self.ePoint.y)
        
        translate(coordinate: coordinate)
        
        
        
        
        let alert: NSAlert = NSAlert()
        alert.messageText = "Adding annotation"
        alert.informativeText = "Add the title for the image annotation"
        alert.alertStyle = NSAlert.Style.informational
        
        alert.accessoryView = NSTextField(frame: NSRect(x: 0, y: 0, width: 100, height: 20))
        alert.addButton(withTitle: "Ok")
        alert.addButton(withTitle: "Cancel")
        
        alert.beginSheetModal(for: self.window!, completionHandler: { [weak self] modalResponse in
            guard let self = self, let annotation = self.annotation else { return }
            switch modalResponse {
            case .alertFirstButtonReturn:
                self.delegate?.addedAnnotation(name: "title", coordinate: coordinate)
            
            case .alertSecondButtonReturn:
                annotation.removeFromSuperview()
                self.iPoint = .zero
                self.ePoint = .zero
            default: break
            }
        })
    }
    
    func renderAnnotation(_ coordinate: Coordinate) {
        addSubview(AnnotationView(frame: NSRect(x: coordinate.x, y: coordinate.y, width: coordinate.width, height: coordinate.height)))
    }
    
    func translate(coordinate: Coordinate) {
        guard let size = image?.size, let originalSize = originalSize else { return }
        
        print(size, originalSize,
              size.height/originalSize.height,
              size.width/originalSize.width,
              originalSize.height/size.height,
              originalSize.width/size.width)
        
        
        
    }
    
}
