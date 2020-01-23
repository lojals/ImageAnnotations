//
//  ApplicationCoordinator.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 23/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Cocoa

final class ApplicationCoordinator: Coordinator {

    let window: NSWindow
    let rootViewController: MainViewController
    let mainViewCoordinator: MainViewCoordinator
    
    init(window: NSWindow) {
        self.window = window
        rootViewController = MainViewController()
        window.contentViewController = rootViewController
        window.styleMask = [.closable, .titled]
        window.title = "Image Annotations"
        window.setContentSize(NSSize(width: 1000, height: 600))
        window.center()
        window.orderFrontRegardless()
        
        mainViewCoordinator = MainViewCoordinator(presenter: rootViewController)
    }
    
    func start() {
        let controller = NSWindowController(window: window)
        controller.showWindow(window)
        NSApp.activate(ignoringOtherApps: true)
        NSApp.mainMenu = MainMenu(target: mainViewCoordinator)
    }
}
