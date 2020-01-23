//
//  ImageAnnotationViewModel.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 14/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Foundation

protocol ImageAnnotationsViewModelBinder {
    func bind(_ viewModel: ImageAnnotationsViewModelProtocol)
}

protocol ImageAnnotationsViewModelProtocol:  AnyObject, ImageDetailViewDelegate {
    var binder: ImageAnnotationsViewModelBinder? { get set }
    var dataSet: AnnotationDataSet { get set }
    var current: ImageAnnotation { get set }
    
    func export(path: URL)
    
    func imageAnotation(for row: Int) -> ImageAnnotation
    func numberOfRows() -> Int
    func current(index: Int)
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
    
    func numberOfRows() -> Int {
        return dataSet.count
    }
     
    func imageAnotation(for row: Int) -> ImageAnnotation {
        return dataSet[row]
    }
    
    func export(path: URL) {
        let appFileManager = AppFileManager()
        appFileManager.export(annotations: dataSet.annotations, path: path)
    }
    
    func current(index: Int) {
        current = dataSet[index]
    }
}

extension ImageAnnotationViewModel: ImageDetailViewDelegate {
    
    func addedAnnotation(name: String, coordinate: Coordinate) {
        let annotation = Annotation(label: name, coordinate: coordinate)
        current = dataSet.addAnnotation(annotation: annotation, to: current)
    }
    
}
