//
//  OperatorTests.swift
//  TextAttributes
//
//  Created by Jeff Hurray on 4/29/16.
//  Copyright © 2016 delba. All rights reserved.
//

import XCTest
@testable import TextAttributes

class OperatorTests: XCTestCase {

    let string = "The quick brown fox jumps over the lazy dog"
    let attrs = TextAttributes()
        .font(name: "HelveticaNeue", size: 16)
        .foregroundColor(white: 0.2, alpha: 1)
        .lineHeightMultiple(1.5)
    
    func testSettingAttributes() {
        XCTAssertEqual(string + attrs, NSAttributedString(string: string, attributes: attrs))
    }
    
    func testAddingTwoAttributedStrings() {
        let attrString1 = "string 1" + attrs
        let attrString2 = " string 2" + attrs
        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.appendAttributedString(attrString1)
        mutableAttributedString.appendAttributedString(attrString2)
        
        let addedAttributedString = attrString1 + attrString2
        let appendedAttributedString = mutableAttributedString as NSAttributedString
        
        XCTAssertEqual(addedAttributedString, appendedAttributedString)
    }
    
    func testAppendStringToAttributedString() {
        let extraText = " adding something"
        let createdAttributedString1 = (string + extraText) + attrs
        let createdAttributedString2 = (string + attrs) + extraText
        
        XCTAssertEqual(createdAttributedString1, createdAttributedString2)
    }
}
