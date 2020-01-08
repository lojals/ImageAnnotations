//
//  NSOpenPanel+Custom.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 06/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Cocoa

extension NSOpenPanel {
    static func make(message: String? = "") -> NSOpenPanel {
        let panel = NSOpenPanel()
        panel.message = "Select images"
        panel.canChooseDirectories = false
        panel.allowedFileTypes = ["jpg", "jpeg", "png", "tiff", "gif"]
        panel.showsResizeIndicator = true
        panel.showsHiddenFiles = false
        panel.canCreateDirectories = true
        panel.allowsMultipleSelection = true
        return panel
    }
}
