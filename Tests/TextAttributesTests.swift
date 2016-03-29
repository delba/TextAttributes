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
    func testExample() {
        // let style: NSMutableParagraphStyle = NSMutableParagraphStyle.defaultParagraphStyle()
        // let mut = NSMutableParagraphStyle.setParagraphStyle(style)
        
        let attrs = TextAttributes()
        attrs.font = UIFont(name: "HelveticaNeue", size: 12)
        attrs.foregroundColor = .blackColor()
        
        attrs.font(name: "HelveticaNeue", size: 12)
            .foregroundColor(.blackColor())
    }
}
