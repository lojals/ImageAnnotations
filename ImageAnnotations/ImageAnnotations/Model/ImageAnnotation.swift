//
//  ImageAnnotation.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 10/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Cocoa

struct ImageAnnotation: Encodable {
    
    var imageName: String {
        url?.lastPathComponent ?? ""
    }
    
    var annotations: [Annotation]
    
    var url: URL?
    
    var image: NSImage? {
        guard let currentURL = url,
        let data = try? Data(contentsOf: currentURL),
        let image = NSImage(data: data) else { return nil }
        return image
    }
    
    init(url: URL? = nil, annotations: [Annotation] = []) {
        self.annotations = annotations
        self.url = url
    }
    
    static let `default` = ImageAnnotation()
}

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

struct Coordinate: Encodable {
    let x: CGFloat
    let y: CGFloat
    let width: CGFloat
    let height: CGFloat
    
    var rect: NSRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    init(rect: NSRect) {
        self.x = rect.origin.x
        self.y = rect.origin.y
        self.width = rect.width
        self.height = rect.height
    }
    
    init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }
    
    static let zero = Coordinate(x: 0, y: 0, width: 0, height: 0)
}
