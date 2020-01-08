//
//  ImageAnnotationsView.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 07/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Cocoa

final class ImageAnnotationsView: NSView {
    
    lazy var imagesListView: NSTableView = .init()
    lazy var imageDetailView: NSImageView = .init()
    
//    var containerView: NSStackView = {
//        
//    }()
//    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    convenience init() {
        self.init(frame: .zero)
        
        addSubview(imagesListView)
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
