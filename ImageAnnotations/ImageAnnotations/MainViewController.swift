//
//  MainViewController.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 17/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Cocoa

final class MainViewController: NSViewController {
    
    private lazy var documentsTableView = ImagesTableViewController()
    private lazy var imageDetailView = ImageDetailViewController()
    
    let viewModel: ImageAnnotationsViewModelProtocol
    
    init(viewModel: ImageAnnotationsViewModelProtocol = ImageAnnotationViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        viewModel = ImageAnnotationViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        documentsTableView.delegate = self
        documentsTableView.dataSource = self
        imageDetailView.delegate = self
        viewModel.binder = self
    }
    
    override func loadView() {
        let splitView = NSSplitView()
        splitView.addSubview(documentsTableView.view)
        splitView.addSubview(imageDetailView.view)
        splitView.isVertical = true
        documentsTableView.view.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imageDetailView.view.widthAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        let identifier = String(describing: self)
        splitView.dividerStyle = .thick
        splitView.autosaveName = identifier
        splitView.identifier = NSUserInterfaceItemIdentifier(rawValue: identifier)
        splitView.adjustSubviews()
        view = splitView
    }
}

extension MainViewController: NSTableViewDataSource {
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        let imageAnnotation = viewModel.imageAnotation(for: row)
        let cell = NSCell(textCell: imageAnnotation.name)
        cell.isEditable = false
        return cell
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return viewModel.numberOfRows()
    }
}

extension MainViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        viewModel.current = viewModel.imageAnotation(for: row)
        return true
    }
    
}

extension MainViewController: ImageAnnotationsViewModelBinder {
    
    func bind(_ viewModel: ImageAnnotationsViewModelProtocol) {
        documentsTableView.bind(viewModel)
        imageDetailView.bind(viewModel)
    }

}

extension MainViewController: NSOpenSavePanelDelegate {

    func panel(_ sender: Any, validate url: URL) throws {
        guard let panel = (sender as? NSOpenPanel), let identifier = panel.identifier else { return }
        switch identifier {
        case .openPanel:
            viewModel.dataSet = AnnotationDataSet(urls: panel.urls)
        case .savePanel:
            panel.directoryURL.flatMap { viewModel.export(at: $0) }
        default: break
        }
    }

}

extension NSUserInterfaceItemIdentifier {
    static let savePanel = NSUserInterfaceItemIdentifier(rawValue: "savePanel")
    static let openPanel = NSUserInterfaceItemIdentifier(rawValue: "openPanel")
}


extension MainViewController: ImageDetailViewDelegate {
    
    func willAddAnnotation(coordinate: Coordinate) {
        
    }
}
