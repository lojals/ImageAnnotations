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

protocol ImageAnnotationsViewModelProtocol: ImageDetailViewDelegate {
    var binder: ImageAnnotationsViewModelBinder? { get set }
    var dataSet: AnnotationDataSet { get set }
    var current: ImageAnnotation { get set }
    
    func export(at path: URL)
    
    func imageAnotation(for row: Int) -> ImageAnnotation
    func numberOfRows() -> Int
    func selectedRow(at index: Int)
}

final class ImageAnnotationViewModel: NSObject, ImageAnnotationsViewModelProtocol {
   
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

extension ImageAnnotationViewModel: ImageDetailViewDelegate {
    
    func willAddAnnotation() {
//        let alert: NSAlert = NSAlert()
//        alert.messageText = "Adding annotation"
//        alert.informativeText = "Add the title for the image annotation"
//        alert.alertStyle = NSAlert.Style.informational
//
//        alert.accessoryView = NSTextField(frame: NSRect(x: 0, y: 0, width: 100, height: 20))
//        alert.addButton(withTitle: "Ok")
//        alert.addButton(withTitle: "Cancel")
//        alert.beginSheetModal(for: self.window!, completionHandler: { [weak self] modalResponse in
//            guard let self = self, let annotation = self.annotation else { return }
//            switch modalResponse {
//            case .alertFirstButtonReturn:
//                self.delegate?.addedAnnotation(name: (alert.accessoryView as? NSTextField)?.stringValue ?? "",
//                                               coordinate: Coordinate(rect: annotation.frame))
//
//            case .alertSecondButtonReturn:
//                annotation.removeFromSuperview()
//                self.iPoint = .zero
//                self.ePoint = .zero
//            default: break
//            }
//        })
    }
    
    func addedAnnotation(name: String, coordinate: Coordinate) {
        let annotation = Annotation(label: name, coordinate: coordinate)
        current = dataSet.addAnnotation(annotation: annotation, to: current)
    }
    
}
