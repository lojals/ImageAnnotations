//
//  MainViewController.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 17/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Cocoa

final class MainViewController: NSSplitViewController {
    
    private lazy var documentsTableView = ImagesTableViewController()
    private lazy var imageDetailView = ImageDetailViewController()
    
    let viewModel: ImageAnnotationsViewModelProtocol
    
    init(viewModel: ImageAnnotationsViewModelProtocol = ImageAnnotationViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        setupUI()
        setupLayout()
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
        imageDetailView.delegate = viewModel
        viewModel.binder = self
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
        viewModel.selectedRow(at: row)
        return true
    }
    
}

extension MainViewController: ImageAnnotationsViewModelBinder {
    
    func bind(_ viewModel: ImageAnnotationsViewModelProtocol) {
        documentsTableView.bind(viewModel)
        imageDetailView.bind(viewModel)
    }
    
}

extension MainViewController: MenuProtocol {
    
    func quit(sender: AnyObject) {
        NSApp.terminate(self)
    }
    
    func selectImages(sender: AnyObject) {
        let dialog = NSOpenPanel.make()
        dialog.identifier = .openPanel
        dialog.delegate = self
        dialog.runModal()
    }
    
    func export(sender: AnyObject) {
        let savePanel = NSOpenPanel()
        savePanel.identifier = .savePanel
        savePanel.canCreateDirectories = true
        savePanel.canChooseFiles = false
        savePanel.canChooseDirectories = true
        savePanel.allowsMultipleSelection = false
        savePanel.delegate = self
        savePanel.titleVisibility  = .hidden
        savePanel.runModal()
    }

}

extension MainViewController {
    
    private func setupUI() {
        view.wantsLayer = true
        
        let identifier = String(describing: self)
        splitView.dividerStyle = .thick
        splitView.autosaveName = identifier
        splitView.identifier = NSUserInterfaceItemIdentifier(rawValue: identifier)
        
        documentsTableView.view.widthAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive = true
        imageDetailView.view.widthAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
    }
    
    private func setupLayout() {
        
        let sidebarItem = NSSplitViewItem(viewController: documentsTableView)
        sidebarItem.canCollapse = false
        sidebarItem.holdingPriority = NSLayoutConstraint.Priority(NSLayoutConstraint.Priority.defaultLow.rawValue + 1)
        addSplitViewItem(sidebarItem)
        
        let xibItem = NSSplitViewItem(viewController: imageDetailView)
        addSplitViewItem(xibItem)
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
