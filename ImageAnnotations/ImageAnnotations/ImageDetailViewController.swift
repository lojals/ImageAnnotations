//
//  ImageDetailViewController.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 20/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Cocoa

final class ImageDetailViewController: NSViewController {
    
    private lazy var imageDetailView: ImageDetailView = .init()
    
    var delegate: ImageDetailViewDelegate? {
        didSet {
            imageDetailView.delegate = delegate
        }
    }
    
    private let scrollView = NSScrollView()
    
    override func loadView() {
        
        scrollView.hasHorizontalScroller = true
        scrollView.borderType = .lineBorder
        scrollView.hasVerticalScroller = true
        scrollView.documentView = self.imageDetailView
        
        view = scrollView
        view.wantsLayer = true
    }
}

extension ImageDetailViewController: ImageAnnotationsViewModelBinder {
    
    func bind(_ viewModel: ImageAnnotationsViewModelProtocol) {
        imageDetailView.subviews.forEach { $0.removeFromSuperview() }
        
        guard let currentURL = viewModel.currentURL,
            let data = try? Data(contentsOf: currentURL),
            let image = NSImage(data: data) else { return }
        
        imageDetailView.image = image
        
        scrollView.setFrameSize(image.size)
        imageDetailView.setFrameSize(image.size)
        
        for annotation in viewModel.currentAnnotations {
            imageDetailView.renderAnnotation(annotation.coordinate)
        }
    }
    
}
