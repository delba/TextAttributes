//
// TextAttributesTests.swift
//
// Copyright (c) 2016 Damien (http://delba.io)
//  Created by Jeff Hurray on 4/29/16.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
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
