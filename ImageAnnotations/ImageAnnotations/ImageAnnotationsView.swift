//
//  ImageAnnotationsView.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 07/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Cocoa

final class ImageAnnotationsView: NSView {
    
    var delegate: NSTableViewDelegate? {
        didSet {
            imagesListView.delegate = delegate
        }
    }
    
    var dataSource: NSTableViewDataSource? {
        didSet {
            imagesListView.dataSource = dataSource
        }
    }
    
    
    private lazy var scrollView: NSScrollView = NSScrollView()
    private lazy var imageContainer: NSView = .init()
    private lazy var imagesListView: NSTableView = {
        let table = NSTableView(frame: .zero)
           table.backgroundColor = .clear
              
           let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "column"))
           column.width = 1
            column.headerCell = NSTableHeaderCell(textCell: "Images")
           table.addTableColumn(column)
           return table
    }()
    
    private var image: NSImage? {
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
        imagesListView.register(nil, forIdentifier: NSUserInterfaceItemIdentifier(rawValue: "cell"))
        addSubview(containerView)
        
        imagesListView.usesAlternatingRowBackgroundColors = true
        imageDetailView.translatesAutoresizingMaskIntoConstraints = false
        imageContainer.addSubview(imageDetailView)
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imagesListView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            imagesListView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            scrollView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            imageDetailView.centerYAnchor.constraint(equalTo: imageContainer.centerYAnchor),
            imageDetailView.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor),
            imageContainer.widthAnchor.constraint(equalToConstant: 500),
            imageContainer.heightAnchor.constraint(equalToConstant: 500),
            containerView.widthAnchor.constraint(equalTo: widthAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
        
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        imagesListView.reloadData()
    }
}

extension ImageAnnotationsView: ImageAnnotationsViewModelBinder {
    
    func bind(_ viewModel: ImageAnnotationsViewModelProtocol) {
        imageDetailView.subviews.forEach { $0.removeFromSuperview() }
        imageDetailView.image = viewModel.currentImage
        imagesListView.reloadData()
    }
    
}
