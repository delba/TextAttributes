//
// TextAttributesTests.swift
//
// Copyright (c) 2016 Damien (http://delba.io)
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

class TextAttributesTests: XCTestCase {
    let string = "The quick brown fox jumps over the lazy dog"
    
    func testSetAttributes() {
        let font = Font(name: "Avenir", size: 16)
        let color = Color(white: 0.42, alpha: 1)
        let ligature: LigatureStyle = .all
        let float: CGFloat = 0.42
        let underlineStyle: NSUnderlineStyle = .styleSingle
        let textEffect: TextEffect = .letterpress
        let form: VerticalGlyphForm = .vertical
        let link = URL(string: "https://github.com/delba/TextAttributes")!

        let attrs = TextAttributes()
            .font(font)
            .foregroundColor(color)
            .backgroundColor(color)
            .ligature(ligature)
            .kern(float)
            .strikethroughStyle(underlineStyle)
            .strikethroughColor(color)
            .underlineStyle(underlineStyle)
            .underlineColor(color)
            .strokeWidth(float)
            .strokeColor(color)
            .shadow(nil)
            .textEffect(textEffect)
            .attachment(nil)
            .obliqueness(float)
            .expansion(float)
            .verticalGlyphForm(form)
            .link(link)
            .baselineOffset(float)

        XCTAssertEqual(font, attrs.font)
        XCTAssertEqual(ligature, attrs.ligature)
        XCTAssertEqual(textEffect, attrs.textEffect)
        XCTAssertEqual(form, attrs.verticalGlyphForm)
        
        XCTAssertEqual(color, attrs.foregroundColor)
        XCTAssertEqual(color, attrs.backgroundColor)
        XCTAssertEqual(color, attrs.strikethroughColor)
        XCTAssertEqual(color, attrs.underlineColor)
        XCTAssertEqual(color, attrs.strokeColor)
        
        XCTAssertEqual(float, attrs.kern)
        XCTAssertEqual(float, attrs.obliqueness)
        XCTAssertEqual(float, attrs.expansion)
        XCTAssertEqual(float, attrs.strokeWidth)
        XCTAssertEqual(float, attrs.baselineOffset)

        XCTAssertEqual(underlineStyle, attrs.strikethroughStyle)
        XCTAssertEqual(underlineStyle, attrs.underlineStyle)

        XCTAssertEqual(link, attrs.link)

        XCTAssertEqual(nil, attrs.shadow)
        XCTAssertEqual(nil, attrs.attachment)
    }
    
    func testSetShadowAndAttachment() {
        let color = Color(white: 0.2, alpha: 1)
        let offset = CGSize(width: 0.42, height: 0.42)
        let blurRadius: CGFloat = 0.42
        
        let shadow = NSShadow()
        shadow.shadowColor = color
        shadow.shadowOffset = offset
        shadow.shadowBlurRadius = blurRadius
        
        let attachment = NSTextAttachment()
        attachment.bounds = CGRect(x: 0, y: 0, width: 42, height: 42)
        
        let attrs = TextAttributes()
            .shadow(shadow)
            .attachment(attachment)
        
        XCTAssertEqual(shadow, attrs.shadow)
        XCTAssertEqual(attachment, attrs.attachment)
    }
    
    func testSetParagraphStyle() {
        let style = NSMutableParagraphStyle()
        style.lineHeightMultiple = 1.42
        
        let attrs = TextAttributes()
            .paragraphStyle(style)
        
        XCTAssertEqual(style, attrs.paragraphStyle)
    }
    
    func testSetParagraphStyleProperties() {
        let float: CGFloat = 0.42
        
        let attrs = TextAttributes()
            .lineHeightMultiple(float)
        
        XCTAssertEqual(float, attrs.lineHeightMultiple)
    }
    
    func testClone() {
        let font = Font(name: "Avenir", size: 16)
        let color = Color(white: 0.42, alpha: 1)
        let ligature: LigatureStyle = .all
        let float: CGFloat = 0.42
        let underlineStyle: NSUnderlineStyle = .styleSingle
        let textEffect: TextEffect = .letterpress
        let form: VerticalGlyphForm = .vertical
        let link = URL(string: "https://github.com/delba/TextAttributes")!
        
        let attrs = TextAttributes()
            .font(font)
            .foregroundColor(color)
            .backgroundColor(color)
            .ligature(ligature)
            .kern(float)
            .strikethroughStyle(underlineStyle)
            .strikethroughColor(color)
            .underlineStyle(underlineStyle)
            .underlineColor(color)
            .strokeWidth(float)
            .strokeColor(color)
            .shadow(nil)
            .textEffect(textEffect)
            .attachment(nil)
            .obliqueness(float)
            .expansion(float)
            .verticalGlyphForm(form)
            .link(link)
            .baselineOffset(float)

        let second = attrs.clone()
        
        XCTAssertEqual(attrs.font, second.font)
        XCTAssertEqual(attrs.foregroundColor, second.foregroundColor)
        XCTAssertEqual(attrs.backgroundColor, second.backgroundColor)
        XCTAssertEqual(attrs.ligature, second.ligature)
        XCTAssertEqual(attrs.kern, second.kern)
        XCTAssertEqual(attrs.strikethroughStyle, second.strikethroughStyle)
        XCTAssertEqual(attrs.strikethroughColor, second.strikethroughColor)
        XCTAssertEqual(attrs.underlineStyle, second.underlineStyle)
        XCTAssertEqual(attrs.underlineColor, second.underlineColor)
        XCTAssertEqual(attrs.strokeWidth, second.strokeWidth)
        XCTAssertEqual(attrs.strokeColor, second.strokeColor)
        XCTAssertEqual(attrs.shadow, second.shadow)
        XCTAssertEqual(attrs.textEffect, second.textEffect)
        XCTAssertEqual(attrs.attachment, second.attachment)
        XCTAssertEqual(attrs.obliqueness, second.obliqueness)
        XCTAssertEqual(attrs.expansion, second.expansion)
        XCTAssertEqual(attrs.link, second.link)
        XCTAssertEqual(attrs.baselineOffset, second.baselineOffset)

        XCTAssertEqual(font, attrs.font)
    }
    
    func testCloneShadowAndAttachment() {
        let color = Color(white: 0.2, alpha: 1)
        let offset = CGSize(width: 0.42, height: 0.42)
        let blurRadius: CGFloat = 0.42
        
        let shadow = NSShadow()
        shadow.shadowColor = color
        shadow.shadowOffset = offset
        shadow.shadowBlurRadius = blurRadius
        
        let bounds = CGRect(x: 0, y: 0, width: 42, height: 42)
        
        let attachment = NSTextAttachment()
        attachment.bounds = bounds
        
        let attrs = TextAttributes()
            .shadow(shadow)
            .attachment(attachment)
        
        let clone = attrs.clone()
        
        XCTAssertEqual(attrs.shadow, clone.shadow)
        XCTAssertEqual(attrs.attachment, clone.attachment)
        
        clone.shadow?.shadowBlurRadius = 42
        clone.attachment?.bounds = .zero
        
        XCTAssertEqual(blurRadius, attrs.shadow?.shadowBlurRadius)
        // XCTAssertEqual(bounds, attrs.attachment?.bounds)
    }
    
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
