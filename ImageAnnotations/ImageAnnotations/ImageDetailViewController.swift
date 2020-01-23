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
    
    weak var delegate: ImageDetailViewDelegate? {
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
        
        guard let currentImage = viewModel.current.image else { return }
        
        imageDetailView.image = currentImage
        scrollView.setFrameSize(currentImage.size)
        imageDetailView.setFrameSize(currentImage.size)
        
        for annotation in viewModel.current.annotations {
            imageDetailView.renderAnnotation(annotation.coordinate)
        }
    }

    func removeLastAnnotation() {
        imageDetailView.removeLastAnnotation()
    }
    
}
