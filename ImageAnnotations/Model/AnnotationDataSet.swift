//
//  AnnotationDataSet.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 22/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Foundation

final class AnnotationDataSet {
    static let empty = AnnotationDataSet()
    
    private var map: [String: Int] = [:]
    private (set) var annotations: [ImageAnnotation] = []
    
    init(urls: [URL] = []) {
        for (index, url) in urls.enumerated() {
            let image = ImageAnnotation(url: url)
            map[image.name] = index
            annotations.append(image)
        }
    }
    
    subscript(input: Int) -> ImageAnnotation {
        return annotations[input]
    }
    
    var count: Int {
        return annotations.count
    }
    
    func addAnnotation(annotation: Annotation, to image: ImageAnnotation) -> ImageAnnotation {
        var newVal = image
        newVal.annotations.append(annotation)
        guard let index = map[image.name] else { return .default }
        annotations[index] = newVal
        return newVal
    }
}
