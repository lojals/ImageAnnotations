//
//  AppDelegate.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 06/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var mainWindow: NSWindow?
    var mainController: NSWindowController?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        let vc = MainSplitViewController()
        let window = NSWindow(contentViewController: vc)
        window.styleMask = [.closable, .titled]
        window.title = "Image Annotations"
        window.setContentSize(NSSize(width: 1000, height: 600))
        window.maxSize = NSSize(width: 1000, height: 600)
        window.contentMaxSize = NSSize(width: 1000, height: 600)
        
        window.center()
        window.orderFrontRegardless()
        mainWindow = window
        
        let controller = NSWindowController(window: window)
        controller.showWindow(window)
        mainController = controller
        NSApp.activate(ignoringOtherApps: true)
        
        NSApp.mainMenu = MainMenu(target: vc)
    }

}
