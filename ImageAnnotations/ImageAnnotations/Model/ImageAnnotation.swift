//
//  ImageAnnotation.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 10/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Foundation

struct ImageAnnotation: Encodable {
    let image: String
    var annotations: [Annotation]
}

struct Annotation: Encodable {
    let label: String
    let coordinates: Coordinate
}

struct Coordinate: Encodable {
    let x: CGFloat
    let y: CGFloat
    let width: CGFloat
    let height: CGFloat
}
