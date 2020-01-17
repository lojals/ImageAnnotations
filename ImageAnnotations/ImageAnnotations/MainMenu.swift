//
//  MainMenu.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 17/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Foundation
import Cocoa

@objc protocol MenuProtocol: AnyObject {
    func quit(sender: AnyObject)
    func selectImages(sender: AnyObject)
    func export(sender: AnyObject)
}

final class MainMenu: NSMenu {
    
    private lazy var quit = NSMenuItem(title: "Quit",
                                       action: #selector(self.delegatee?.quit(sender:)),
                                       keyEquivalent: "q")
    
    private lazy var selectImages = NSMenuItem(title: "Select Images...",
                                               action: #selector(self.delegatee?.selectImages(sender:)),
                                               keyEquivalent: "o")
    
    private lazy var export = NSMenuItem(title: "Export",
                                         action: #selector(self.delegatee?.export(sender:)),
                                         keyEquivalent: "e")
    
    weak var delegatee: MenuProtocol?
    
    init(target: MenuProtocol) {
        
        self.delegatee = target
        super.init(title: "ImageAnnotations")
        
        quit.target = target
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
}
