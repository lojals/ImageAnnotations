//
//  ViewController.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 06/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var imageAnnotationsView: ImageAnnotationsView {
        view as! ImageAnnotationsView
    }
    
    private var urls: [URL] = [] {
        didSet {
            print(urls)
            imageAnnotationsView.imagesListView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageAnnotationsView.viewModel = self
    }
    
    override func loadView() {
        let imageAnnotationsView = ImageAnnotationsView()
        imageAnnotationsView.translatesAutoresizingMaskIntoConstraints = false
        self.view = imageAnnotationsView
    }
    
    @IBAction func openDocument(_ sender: Any?) {
        let dialog = NSOpenPanel.make()
        dialog.delegate = self
        dialog.runModal()
    }

}


extension ViewController: NSOpenSavePanelDelegate {
    
    func panel(_ sender: Any, validate url: URL) throws {
        urls = (sender as? NSOpenPanel)?.urls ?? []
    }
    
}

extension ViewController: ImageAnnotationsViewViewModel {
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return NSCell(textCell: urls[row].lastPathComponent)
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return urls.count
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        let image = NSImage(byReferencingFile: urls[row].lastPathComponent)
        imageAnnotationsView.image = image
        
        
        return true
    }
    
}
