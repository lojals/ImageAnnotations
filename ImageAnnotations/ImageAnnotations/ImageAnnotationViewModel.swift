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
    var dataSet: AnnotationDataSet { get set }
    var current: ImageAnnotation { get set }
}

final class ImageAnnotationViewModel: NSObject, ImageAnnotationsViewModelProtocol {
    
    var binder: ImageAnnotationsViewModelBinder?
    
    var current: ImageAnnotation = .default {
        didSet {
            binder?.bind(self)
        }
    }
    
    var dataSet: AnnotationDataSet = .empty {
        didSet {
            binder?.bind(self)
        }
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        let cell = NSCell(textCell: dataSet[row].imageName)
        cell.isEditable = false
        return cell
    }
     
    func numberOfRows(in tableView: NSTableView) -> Int {
        return dataSet.count
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        current = dataSet[row]
        return true
    }
    
    func export(path: URL) {
//        let appFileManager = AppFileManager()
//        let imageAnnotations = annotations.values.map { $0 }
//        appFileManager.export(annotations: imageAnnotations, urls: urls, path: path)
    }
}

extension ImageAnnotationViewModel: ImageDetailViewDelegate {
    
    func addedAnnotation(name: String, coordinate: Coordinate, relativeSize: NSSize) {
        let annotation = Annotation(label: name, coordinate: coordinate)
        current = dataSet.addAnnotation(annotation: annotation, to: current)
    }
    
}
