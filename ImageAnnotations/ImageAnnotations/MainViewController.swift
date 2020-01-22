//
//  MainViewController.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 17/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Cocoa

final class MainSplitViewController: NSSplitViewController {
    
    private let splitViewResorationIdentifier = "com.company.restorationId:mainSplitViewController"
    
    lazy var documentsTableView = ImagesTableViewController()
    lazy var imageDetailView = ImageDetailViewController()
    
    let viewModel = ImageAnnotationViewModel()
    
    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupUI()
        setupLayout()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        documentsTableView.delegate = viewModel
        documentsTableView.dataSource = viewModel
        viewModel.binder = self
        imageDetailView.delegate = viewModel
    }
    
}

extension MainSplitViewController: ImageAnnotationsViewModelBinder {
    
    func bind(_ viewModel: ImageAnnotationsViewModelProtocol) {
        documentsTableView.bind(viewModel)
        imageDetailView.bind(viewModel)
    }
    
}

extension MainSplitViewController: MenuProtocol {
    
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

extension MainSplitViewController {
    
    private func setupUI() {
        view.wantsLayer = true
        
        splitView.dividerStyle = .thick
        splitView.autosaveName = splitViewResorationIdentifier
        splitView.identifier = NSUserInterfaceItemIdentifier(rawValue: splitViewResorationIdentifier)
        
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

extension MainSplitViewController: NSOpenSavePanelDelegate {

    func panel(_ sender: Any, validate url: URL) throws {
        guard let panel = (sender as? NSOpenPanel), let identifier = panel.identifier else { return }
        switch identifier {
        case .openPanel:
            viewModel.dataSet = AnnotationDataSet(urls: panel.urls)
        case .savePanel:
            panel.directoryURL.flatMap { viewModel.export(path: $0) }
        default: break
        }
    }

}

extension NSUserInterfaceItemIdentifier {
    static let savePanel = NSUserInterfaceItemIdentifier(rawValue: "savePanel")
    static let openPanel = NSUserInterfaceItemIdentifier(rawValue: "openPanel")
}
