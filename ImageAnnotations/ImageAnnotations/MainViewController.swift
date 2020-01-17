//
//  MainViewController.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 17/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Foundation
import Cocoa

class MainSplitViewController: NSSplitViewController {
    
    private let splitViewResorationIdentifier = "com.company.restorationId:mainSplitViewController"
    
    lazy var vcA = TableView()
    lazy var vcB = ImageDetailViewController()
    
    let viewModel = ImageAnnotationViewModel()
    
    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vcA.delegate = viewModel
        vcA.dataSource = viewModel
        viewModel.binder = vcA
    }
    
}

extension MainSplitViewController: MenuProtocol {
    
    func quit(sender: AnyObject) {
        NSApp.terminate(self)
    }
    
    func selectImages(sender: AnyObject) {
        let dialog = NSOpenPanel.make()
        dialog.delegate = self
        dialog.runModal()
    }
    
    func export(sender: AnyObject) {
        print("export")
    }

}

extension MainSplitViewController {
    
    private func setupUI() {
        
        view.wantsLayer = true
        
        splitView.dividerStyle = .thick
        splitView.autosaveName = splitViewResorationIdentifier
        splitView.identifier = NSUserInterfaceItemIdentifier(rawValue: splitViewResorationIdentifier)
        
        vcA.view.widthAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive = true
        vcB.view.widthAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
    }
    
    private func setupLayout() {
        
        let sidebarItem = NSSplitViewItem(viewController: vcA)
        sidebarItem.canCollapse = false
        sidebarItem.holdingPriority = NSLayoutConstraint.Priority(NSLayoutConstraint.Priority.defaultLow.rawValue + 1)
        addSplitViewItem(sidebarItem)
        
        let xibItem = NSSplitViewItem(viewController: vcB)
        addSplitViewItem(xibItem)
    }
}

extension MainSplitViewController: NSOpenSavePanelDelegate {

    func panel(_ sender: Any, validate url: URL) throws {
        viewModel.urls = (sender as? NSOpenPanel)?.urls ?? []
    }

}
