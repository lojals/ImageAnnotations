//
//  ViewController.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 06/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func openDocument(_ sender: Any?) {
        let myFileDialog = NSOpenPanel()
        myFileDialog.allowsMultipleSelection = true
        myFileDialog.runModal()
    }

}
