//
//  ViewController.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 06/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Cocoa

final class ImageAnnotationsViewController: NSViewController {

    private var imageAnnotationsView: ImageAnnotationsView {
        view as! ImageAnnotationsView
    }
    
    let viewModel = ImageAnnotationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageAnnotationsView.delegate = viewModel
        imageAnnotationsView.dataSource = viewModel
        viewModel.binder = imageAnnotationsView
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

extension ImageAnnotationsViewController: NSOpenSavePanelDelegate {
    
    func panel(_ sender: Any, validate url: URL) throws {
        viewModel.urls = (sender as? NSOpenPanel)?.urls ?? []
    }
    
}
