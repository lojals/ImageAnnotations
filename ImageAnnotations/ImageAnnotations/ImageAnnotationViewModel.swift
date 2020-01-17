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
    var currentImage: NSImage? { get }
    var currentAnnotations: [Annotation] { get }
    var currentURL: URL? { get set }
}

final class ImageAnnotationViewModel: NSObject, ImageAnnotationsViewModelProtocol {
    var binder: ImageAnnotationsViewModelBinder?

    var currentImage: NSImage? {
        guard  let currentURL = currentURL else { return nil }
        do {
            let data = try Data(contentsOf: currentURL)
            return NSImage(data: data)
        } catch {
            return nil
        }
    }
    
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
        return NSCell(textCell: urls[row].lastPathComponent)
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return urls.count
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        currentURL = urls[row]
        binder?.bind(self)
        return true
    }
    
}

extension ImageAnnotationViewModel: ImageDetailViewDelegate {
    
    func addedAnnotation(name: String, coordinate: Coordinate) {
        guard let currentURL = currentURL else { return }
        let annotation = Annotation(label: name, coordinate: coordinate)
        annotations[currentURL.lastPathComponent, default: ImageAnnotation(image: currentURL.lastPathComponent, annotations: [])].annotations.append(annotation)
    }
    
}


//                let img = ImageAnnotation(image: "img1.png", annotations: [Annotation(label: "label1", coordinate: Coordinate(x: annotation.frame.origin.x, y: annotation.frame.origin.y, width: annotation.frame.width, height: annotation.frame.height))])
//                let file = "result.json"
//                if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//                    let fileURL = dir.appendingPathComponent(file)
//                    let encoder  = JSONEncoder()
//                    encoder.outputFormatting = .prettyPrinted
//                    try? encoder.encode(img).write(to: fileURL)
//                }


//
//let popUp = NSPopover()
//popUp.contentSize = CGSize(width: 50, height: 50)
//popUp.behavior = .transient
//
//popUp.appearance = NSAppearance(named: .darkAqua)
//popUp.animates = true
//popUp.contentViewController = self
//
//popUp.show(relativeTo: view.bounds, of: self.view, preferredEdge: NSRectEdge.minY)
