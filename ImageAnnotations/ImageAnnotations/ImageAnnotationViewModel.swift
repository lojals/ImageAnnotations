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
    var currentAnnotations: [Annotation] { get }
    var currentURL: URL? { get set }
}

final class ImageAnnotationViewModel: NSObject, ImageAnnotationsViewModelProtocol {
    var binder: ImageAnnotationsViewModelBinder?
    var currentAnnotations: [Annotation] {
        let imageName = currentURL?.lastPathComponent ?? ""
        return annotations[imageName]?.annotations ?? []
    }
        
    var annotations: [String: ImageAnnotation] = [:]
    
    var currentURL: URL?
    
    var urls: [URL] = [] {
        didSet {
            binder?.bind(self)
        }
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        let cell = NSCell(textCell: urls[row].lastPathComponent)
        cell.isEditable = false
        return cell
    }
     
    func numberOfRows(in tableView: NSTableView) -> Int {
        return urls.count
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        currentURL = urls[row]
        binder?.bind(self)
        return true
    }
    
    func export(path: URL) {
        let appFileManager = AppFileManager()
        let imageAnnotations = annotations.values.map { $0 }
        appFileManager.export(annotations: imageAnnotations, urls: urls, path: path)
    }
}

extension ImageAnnotationViewModel: ImageDetailViewDelegate {
    
    func addedAnnotation(name: String, coordinate: Coordinate, relativeSize: NSSize) {
        guard let currentURL = currentURL else { return }
        let annotation = Annotation(label: name, coordinate: coordinate)
        annotations[currentURL.lastPathComponent, default: ImageAnnotation(image: currentURL.lastPathComponent, annotations: [])].annotations.append(annotation)
    }
    
}
