//
//  MainMenu.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 17/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Foundation
import Cocoa

final class MainMenu: NSMenu {
    
    let quit = NSMenuItem(title: "Quit", action: #selector(quit(sender:)), keyEquivalent: "q")
    let selectImages = NSMenuItem(title: "Select Images...", action: #selector(quit(sender:)), keyEquivalent: "o")
    let export = NSMenuItem(title: "Export", action: #selector(quit(sender:)), keyEquivalent: "e")
    
    init() {
        super.init(title: "ImageAnnotations")
        
        quit.target = self
        let mainMenuFileItem = NSMenuItem()
        
        let mainMenu = NSMenu(title: "ImageAnnotations")
        mainMenu.addItem(quit)
        mainMenuFileItem.submenu = mainMenu
        addItem(mainMenuFileItem)
        
        let fileMenuItem = NSMenuItem()
        let fileMenu = NSMenu(title: "File")
        fileMenu.addItem(selectImages)
        fileMenu.addItem(export)
        fileMenuItem.submenu = fileMenu
        addItem(fileMenuItem)
    }
    
    @available (*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func quit(sender: NSMenuItem) {
      NSApp.terminate(self)
    }
}
