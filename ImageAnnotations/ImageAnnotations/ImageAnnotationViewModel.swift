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
        let manager = FileManager.default
        
        let directoryName = "test_directory"
        
        
        
        let newURL = path.appendingPathComponent(directoryName)
        do {
            try manager.createDirectory(at: newURL, withIntermediateDirectories: true, attributes: nil)
            let file = "\(directoryName)/result.json"
            let fileURL = path.appendingPathComponent(file)
            let encoder  = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            let imageAnnotations = annotations.values.map { $0 }
            try? encoder.encode(imageAnnotations).write(to: fileURL)
            
            for imageURL in urls {
                guard let data = try? Data(contentsOf: imageURL),
                let image = NSImage(data: data) else { return }
                
                let pathExp = imageURL.deletingPathExtension()
                let imageURL = path.appendingPathComponent("\(directoryName)/\(pathExp.lastPathComponent).jpg")
                image.writeimge(to: imageURL)
            }
        } catch(_) {
            
        }
    }
    
}

extension ImageAnnotationViewModel: ImageDetailViewDelegate {
    
    func addedAnnotation(name: String, coordinate: Coordinate, relativeSize: NSSize) {
        guard let currentURL = currentURL else { return }
        let annotation = Annotation(label: name, coordinate: coordinate)
        annotations[currentURL.lastPathComponent, default: ImageAnnotation(image: currentURL.lastPathComponent, annotations: [])].annotations.append(annotation)
    }
    
}

extension NSImage {
    
    var jpgData: Data? {
        guard let tiffRepresentation = tiffRepresentation, let bitmapImage = NSBitmapImageRep(data: tiffRepresentation) else { return nil }
        return bitmapImage.representation(using: .jpeg, properties: [:])
    }
    
    @discardableResult func writeimge(to url: URL, options: Data.WritingOptions = .atomic) -> Bool {
        do {
            try jpgData?.write(to: url, options: options)
            return true
        } catch {
            print(error)
            return false
        }
    }
    
}
