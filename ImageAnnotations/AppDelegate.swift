//
//  AppDelegate.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 06/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Cocoa

@NSApplicationMain
final class AppDelegate: NSObject, NSApplicationDelegate {
    
    var window: NSWindow?
    private var applicationCoordinator: ApplicationCoordinator?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let window = NSWindow()
        applicationCoordinator = ApplicationCoordinator(window: window)
        self.window = window
        applicationCoordinator?.start()
    }

}
