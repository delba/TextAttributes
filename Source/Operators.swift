//
//  Operators.swift
//  TextAttributes
//
//  Created by Jeff Hurray on 4/29/16.
//  Copyright © 2016 delba. All rights reserved.
//

import Foundation

/**
 Returns an NSAttributedString object initialized with a given string (left side) and attributes (right side).
 
 - lhs parameter:     The string for the new attributed string.
 - rhs parameter: The attributes for the new attributed string.
 
 - returns: The newly created NSAttributedString.
 */
func +(lhs: String, rhs: TextAttributes) -> NSAttributedString {
    return NSAttributedString(string: lhs, attributes: rhs)
}


/**
 Returns an NSAttributedString object by concattenating two NSAttributedString objects.
 
 - lhs parameter:     The first NSAttributedString.
 - rhs parameter: The second NSAttributedString.
 
 - returns: The newly created NSAttributedString in the order of "<lhs><rhs>".
 */
func +(lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
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
func +(lhs: NSAttributedString, rhs: String) -> NSAttributedString {
    let mutableAttributedString = NSMutableAttributedString(attributedString: lhs)
    mutableAttributedString.mutableString.appendString(rhs)
    return mutableAttributedString as NSAttributedString
}