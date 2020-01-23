//
//  ImageAnnotation.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 10/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Cocoa

struct ImageAnnotation {
    
    var name: String {
        let imageName = url?.deletingPathExtension()
        return imageName?.lastPathComponent ?? ""
    }
    
    var annotations: [Annotation]
    
    private var url: URL?
    
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
    
    // TODO: translate position of the annotation to the needed coordinate type.
    func translate() -> [Annotation] {
        var translatedAnnotations: [Annotation] = []
        for annotation in annotations {
            translatedAnnotations.append(annotation)
        }
        return translatedAnnotations
    }

}

extension ImageAnnotation: Encodable {
    
    private enum CodingKeys: String, CodingKey {
        case image
        case annotations
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let imageNameWithExtension = "\(name).jpg"
        try container.encode(imageNameWithExtension, forKey: .image)
        try container.encode(translate(), forKey: .annotations)
    }
    
}

extension ImageAnnotation {
    static let `default` = ImageAnnotation()
}
