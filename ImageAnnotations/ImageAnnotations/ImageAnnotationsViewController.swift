//
//  ViewController.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 06/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Cocoa

final class TableView: NSViewController {
    
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
    
    private lazy var imagesListView: NSTableView = {
        let table = NSTableView(frame: .zero)
        table.backgroundColor = .clear
        table.usesAlternatingRowBackgroundColors =  true
        let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "column"))
        column.width = 1
        column.headerCell = NSTableHeaderCell(textCell: "Images")
        table.addTableColumn(column)
        return table
    }()
    
    override func loadView() {
        
        let scrollView = NSScrollView()
        scrollView.borderType = .lineBorder
        scrollView.hasVerticalScroller = true
        scrollView.documentView = self.imagesListView
        
        view = scrollView
        view.wantsLayer = true
    }
    
}

final class ImageDetailViewController: NSViewController {
    
    private lazy var imageDetailView: ImageDetailView = .init()
    
    var delegate: ImageDetailViewDelegate? {
        didSet {
            imageDetailView.delegate = delegate
        }
    }
    
    override func loadView() {
        imageDetailView.imageScaling = .scaleProportionallyDown
        imageDetailView.imageAlignment = .alignCenter
        imageDetailView.imageFrameStyle = .photo
        
        view = imageDetailView
        view.wantsLayer = true
    }
    
}

extension TableView: ImageAnnotationsViewModelBinder {
    
    func bind(_ viewModel: ImageAnnotationsViewModelProtocol) {
        imagesListView.reloadData()
    }
    
}

extension ImageDetailViewController: ImageAnnotationsViewModelBinder {
    
    func bind(_ viewModel: ImageAnnotationsViewModelProtocol) {
        imageDetailView.subviews.forEach { $0.removeFromSuperview() }
        imageDetailView.image = viewModel.currentImage
        
        for annotation in viewModel.currentAnnotations {
            imageDetailView.renderAnnotation(annotation.coordinate)
        }
    }
    
}
