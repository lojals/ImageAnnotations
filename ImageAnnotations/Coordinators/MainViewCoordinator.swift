//
//  MainViewCoordinator.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 23/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Cocoa

final class MainViewCoordinator: Coordinator {
    
    var presenter: MainViewController
    
    init(presenter: MainViewController) {
        self.presenter = presenter
    }
    
    func start() {
        
    }
}

extension MainViewCoordinator: MenuDelegate {
    
    func quit(sender: AnyObject) {
        NSApp.terminate(self)
    }
    
    func selectImages(sender: AnyObject) {
        let dialog = NSOpenPanel.make()
        dialog.identifier = .openPanel
        dialog.delegate = presenter
        dialog.runModal()
    }
    
    func export(sender: AnyObject) {
        let savePanel = NSOpenPanel()
        savePanel.identifier = .savePanel
        savePanel.canCreateDirectories = true
        savePanel.canChooseFiles = false
        savePanel.canChooseDirectories = true
        savePanel.allowsMultipleSelection = false
        savePanel.delegate = presenter
        savePanel.titleVisibility  = .hidden
        savePanel.runModal()
    }
    
}
