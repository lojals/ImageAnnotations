//
//  NSRectExtensionTests.swift
//  ImageAnnotationsTests
//
//  Created by Jorge Ovalle on 22/01/20.
//  Copyright © 2020 Jorge Ovalle. All rights reserved.
//

import XCTest
@testable import ImageAnnotations

class NSRectExtensionTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testComparableLessThan() {
        let rect1 = NSRect(x: 0, y: 0, width: 10, height: 2)
        let rect2 = NSRect(x: 0, y: 0, width: 10, height: 2)
        
        XCTAssertFalse(rect1 < rect2)
    }
    
    func testComparableGreaterThan() {
        let rect1 = NSRect(x: 0, y: 0, width: 10, height: 2)
        let rect2 = NSRect(x: 0, y: 0, width: 10, height: 2)
        
        XCTAssertFalse(rect1 > rect2)
    }

}
