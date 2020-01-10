//
//  ImageAnnotationsView.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 07/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Cocoa

protocol ImageAnnotationsViewViewModel: NSTableViewDataSource, NSTableViewDelegate {}

final class ImageAnnotationsView: NSView {
    
    var viewModel: ImageAnnotationsViewViewModel? {
        didSet {
            imagesListView.dataSource = viewModel
            imagesListView.delegate = viewModel
        }
    }
    
    lazy var scrollView: NSScrollView = NSScrollView()
    
    lazy var imageContainer: NSView = .init()
    
    lazy var imagesListView: NSTableView = {
        let table = NSTableView(frame: .zero)
           table.backgroundColor = .clear
              
           let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "column"))
           column.width = 1
            column.headerCell = NSTableHeaderCell(textCell: "Images")
           table.addTableColumn(column)
           return table
    }()
    
    
    var image: NSImage? {
        didSet {
            imageDetailView.image = image
        }
    }
    
    private lazy var imageDetailView: ImageDetailView = .init()
    
    private lazy var containerView: NSStackView = {
        let containerView = NSStackView(views: [self.scrollView, self.imageContainer])
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.alignment = .top
        containerView.distribution = .fill
        containerView.orientation = .horizontal
        containerView.edgeInsets = NSEdgeInsets(top: 40, left: 10, bottom: 10, right: 10)
        containerView.spacing = 10
        return containerView
    }()

    convenience init() {
        self.init(frame: .zero)
        
        scrollView.addSubview(imagesListView)
        
        imagesListView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        imagesListView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        
        imagesListView.register(nil, forIdentifier: NSUserInterfaceItemIdentifier(rawValue: "cell"))
        addSubview(containerView)
        
        imagesListView.dataSource = viewModel
        imagesListView.usesAlternatingRowBackgroundColors = true
        
        imageDetailView.translatesAutoresizingMaskIntoConstraints = false
        imageContainer.addSubview(imageDetailView)

        
        scrollView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3).isActive = true
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        imageDetailView.centerYAnchor.constraint(equalTo: imageContainer.centerYAnchor).isActive = true
        imageDetailView.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor).isActive = true
        imageContainer.widthAnchor.constraint(equalToConstant: 500).isActive = true
        imageContainer.heightAnchor.constraint(equalToConstant: 500).isActive = true
        containerView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        containerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        containerView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
