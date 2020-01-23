//
//  ImageAnnotationViewModel.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 14/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Foundation

protocol ImageAnnotationsViewModelBinder: AnyObject {
    func bind(_ viewModel: ImageAnnotationsViewModelProtocol)
}

protocol ImageAnnotationsViewModelProtocol: AnyObject {
    var binder: ImageAnnotationsViewModelBinder? { get set }
    var dataSet: AnnotationDataSet { get set }
    var current: ImageAnnotation { get set }
    
    func export(at path: URL)
    
    func imageAnotation(for row: Int) -> ImageAnnotation
    func numberOfRows() -> Int
    func selectedRow(at index: Int)
}

final class ImageAnnotationViewModel: ImageAnnotationsViewModelProtocol {
   
    weak var binder: ImageAnnotationsViewModelBinder?
    
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
    
    func export(at path: URL) {
        AppFileManager().export(annotations: dataSet.annotations, path: path)
    }
    
    func selectedRow(at index: Int) {
        current = dataSet[index]
    }
}
