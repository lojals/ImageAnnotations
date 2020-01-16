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
    var annotations: [String: ImageAnnotation] { get  set }
    var urls: [URL] { get set }
    
    var currentImage: NSImage? { get set }
    var currentAnnotations: [Annotation] { get set }
    var currentURL: URL? { get set }
}

final class ImageAnnotationViewModel: NSObject, ImageAnnotationsViewModelProtocol {
    
    var binder: ImageAnnotationsViewModelBinder?

    var currentImage: NSImage?
    
    var currentAnnotations: [Annotation] = []
    
    var currentURL: URL?
    
    var annotations: [String: ImageAnnotation] = [:]
    
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
            let url = urls[row]
            let data = try Data(contentsOf: url)
            currentImage = NSImage(data: data)
            
            currentURL = url
            
            currentAnnotations = annotations[url.lastPathComponent]?.annotations ?? []
            binder?.bind(self)
        } catch { }
        return true
    }
    
}

extension ImageAnnotationViewModel: ImageDetailViewDelegate {
    
    func addedAnnotation(name: String, coordinate: Coordinate) {
        guard let currentURL = currentURL else { return }
        let annotation = Annotation(label: name, coordinates: coordinate)
        annotations[currentURL.lastPathComponent, default: ImageAnnotation(image: currentURL.lastPathComponent, annotations: [])].annotations.append(annotation)
    }
    
}
