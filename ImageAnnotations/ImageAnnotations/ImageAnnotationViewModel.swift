//
//  ImageAnnotationViewModel.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 14/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Cocoa


protocol ImageAnnotationsViewModelBinder {
    func bind(_ viewModel: ImageAnnotationsViewModelProtocol)
}

protocol ImageAnnotationsViewModelProtocol: NSTableViewDataSource, NSTableViewDelegate {
    var annotations: [ImageAnnotation] { get  set }
    var urls: [URL] { get set }
    var currentImage: NSImage? { get set }
}

final class ImageAnnotationViewModel: NSObject, ImageAnnotationsViewModelProtocol {
    
    var binder: ImageAnnotationsViewModelBinder?

    var currentImage: NSImage?
    
    var annotations: [ImageAnnotation] = []
    
    var urls: [URL] = [] {
        didSet {
            binder?.bind(self)
        }
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return NSCell(textCell: urls[row].lastPathComponent)
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return urls.count
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        do {
            let data = try Data(contentsOf: urls[row])
            currentImage = NSImage(data: data)
            binder?.bind(self)
        } catch { }
        return true
    }
    
}
