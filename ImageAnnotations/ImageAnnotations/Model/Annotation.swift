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
    var relativeCoordinate: Coordinate = .zero
    
    private enum CodingKeys: String, CodingKey {
        case label
        case coordinate
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(label, forKey: .label)
        try container.encode(relativeCoordinate, forKey: .coordinate)
    }
}
