//
//  Annotation.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 22/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Foundation

struct Annotation: Encodable {
    let label: String
    let coordinate: Coordinate
}
