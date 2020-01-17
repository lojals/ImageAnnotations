//
//  ViewController.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 06/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Cocoa

final class TableView: NSViewController, NSTableViewDataSource {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let d = ImageAnnotationViewModel()
        imagesListView.delegate = d
        imagesListView.dataSource = self
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return NSCell(textCell: "Hola")
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 100
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
           return true
    }
    
}

final class ImageDetailViewController: NSViewController {
    
    private lazy var imageDetailView: ImageDetailView = .init()
    
    var image: NSImage? {
        didSet {
            imageDetailView.image = image
        }
    }
    
    override func loadView() {
        view = imageDetailView
        view.wantsLayer = true
    }
    
}








final class ImageAnnotationsViewController: NSViewController {

    private var imageAnnotationsView: ImageAnnotationsView {
        view as! ImageAnnotationsView
    }
    
    let viewModel = ImageAnnotationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageAnnotationsView.delegate = viewModel
        imageAnnotationsView.dataSource = viewModel
        viewModel.binder = imageAnnotationsView
    }

    override func loadView() {
        let imageAnnotationsView = ImageAnnotationsView()
        imageAnnotationsView.translatesAutoresizingMaskIntoConstraints = false
        self.view = imageAnnotationsView
    }
    
    @IBAction func openDocument(_ sender: Any?) {
        let dialog = NSOpenPanel.make()
        dialog.delegate = self
        dialog.runModal()
    }

}

extension ImageAnnotationsViewController: NSOpenSavePanelDelegate {
    
    func panel(_ sender: Any, validate url: URL) throws {
        viewModel.urls = (sender as? NSOpenPanel)?.urls ?? []
    }
    
}
