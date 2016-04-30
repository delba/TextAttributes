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

import Foundation

infix operator + {associativity left precedence 140}

/**
 Returns an NSAttributedString object initialized with a given string (left side) and attributes (right side).
 
 - lhs parameter:     The string for the new attributed string.
 - rhs parameter: The attributes for the new attributed string.
 
 - returns: The newly created NSAttributedString.
 */
public func +(lhs: String, rhs: TextAttributes) -> NSAttributedString {
    return NSAttributedString(string: lhs, attributes: rhs)
}


/**
 Returns an NSAttributedString object by concattenating two NSAttributedString objects.
 
 - lhs parameter:     The first NSAttributedString.
 - rhs parameter: The second NSAttributedString.
 
 - returns: The newly created NSAttributedString in the order of "<lhs><rhs>".
 */
public func +(lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
    let mutableAttributedString = NSMutableAttributedString(attributedString: lhs)
    mutableAttributedString.appendAttributedString(rhs)
    return mutableAttributedString as NSAttributedString
}



/**
 Returns an NSAttributedString object by adding a String to an NSAttributedString  with the same attributes.
 
 - lhs parameter:     The original NSAttributedString.
 - rhs parameter: The additions to the NSAttributedString object.
 
 - returns: The NSAttributedString with the newly appended text.
 */
public func +(lhs: NSAttributedString, rhs: String) -> NSAttributedString {
    let mutableAttributedString = NSMutableAttributedString(attributedString: lhs)
    mutableAttributedString.mutableString.appendString(rhs)
    return mutableAttributedString as NSAttributedString
}