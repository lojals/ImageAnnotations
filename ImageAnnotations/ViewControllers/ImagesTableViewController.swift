//
//  ViewController.swift
//  ImagesTableViewController
//
//  Created by Jorge Ovalle on 06/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Cocoa

final class ImagesTableViewController: NSViewController {
    
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

extension ImagesTableViewController: ImageAnnotationsViewModelBinder {
    
    func bind(_ viewModel: ImageAnnotationsViewModelProtocol) {
        imagesListView.reloadData()
    }
    
}

