//
//  TextAttributesTests.swift
//  TextAttributesTests
//
//  Created by Damien on 29/03/2016.
//  Copyright © 2016 delba. All rights reserved.
//

import XCTest
import UIKit
@testable import TextAttributes

class TextAttributesTests: XCTestCase {
    let string = "The quick brown fox jumps over the lazy dog"
    
    func testCloneParagraphStyle() {
        let first  = TextAttributes().lineHeightMultiple(1.5)
        let firstStyle = first.paragraphStyle
        
        XCTAssertEqual(1.5, firstStyle.lineHeightMultiple)
        
        let second = first.clone()
        
        let secondStyle = second.paragraphStyle
        
        XCTAssertEqual(1.5, secondStyle.lineHeightMultiple)
        
        second.lineHeightMultiple = 1.4
        
        XCTAssertEqual(1.5, firstStyle.lineHeightMultiple)
        XCTAssertEqual(1.4, secondStyle.lineHeightMultiple)
    }
}
