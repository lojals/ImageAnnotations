//
//  FileManager.swift
//  ImageAnnotations
//
//  Created by Jorge Ovalle on 21/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import Cocoa

struct AppFileManager {

    func export(annotations: [ImageAnnotation], path: URL) {
        let manager = FileManager.default
        
        let directoryName = "Input Data"
        
        let newURL = path.appendingPathComponent(directoryName)
        do {
            try manager.createDirectory(at: newURL, withIntermediateDirectories: true, attributes: nil)
            let file = "\(directoryName)/annotations.json"
            let fileURL = path.appendingPathComponent(file)
            let encoder  = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            try? encoder.encode(annotations).write(to: fileURL)
            
            for imageAnnotation in annotations {
                guard let image = imageAnnotation.image else { return }
                let imageURL = path.appendingPathComponent("\(directoryName)/\(imageAnnotation.imageName).jpg")
                try writeimge(image, to: imageURL)
            }
        } catch (let error) {
            print(error)
        }
    }
    
    func writeimge(_ image: NSImage, to url: URL, options: Data.WritingOptions = .atomic) throws {
        try image.jpgData?.write(to: url, options: options)
    }
}
