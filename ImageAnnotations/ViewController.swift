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
    
    override func loadView() {
        let imageAnnotationsView = ImageAnnotationsView()
        imageAnnotationsView.translatesAutoresizingMaskIntoConstraints = false
        self.view = imageAnnotationsView
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func openDocument(_ sender: Any?) {
        let dialog = NSOpenPanel.make()
        dialog.delegate = self
        dialog.runModal()
    }

}


extension ViewController: NSOpenSavePanelDelegate {
    func panelSelectionDidChange(_ sender: Any?) {
        print((sender as? NSOpenPanel)?.urls)
    }
}
