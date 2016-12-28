//
// AttributedString.swift
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

extension NSAttributedString {
    /**
     Returns an NSAttributedString object initialized with a given string and attributes.
     
     - parameter string:     The string for the new attributed string.
     - parameter attributes: The attributes for the new attributed string.
     
     - returns: The newly created NSAttributedString.
     */
    public convenience init(string: NSString, attributes: TextAttributes) {
        self.init(string: string as String, attributes: attributes)
    }
    
    /**
     Returns an NSAttributedString object initialized with a given string and attributes.
     
     - parameter string:     The string for the new attributed string.
     - parameter attributes: The attributes for the new attributed string.
     
     - returns: The newly created NSAttributedString.
     */
    public convenience init(string: String, attributes: TextAttributes) {
        self.init(string: string, attributes: attributes.dictionary)
    }
}

extension NSMutableAttributedString {
    /**
     Sets the attributes to the specified attributes.
     
     - parameter attributes: The attributes to set.
     */
    public func setAttributes(_ attributes: TextAttributes) {
        setAttributes(attributes, range: NSRange(mutableString))
    }
    
    /**
     Sets the attributes for the characters in the specified range to the specified attributes.
     
     - parameter attributes: The attributes to set.
     - parameter range:      The range of characters whose attributes are set.
     */
    public func setAttributes(_ attributes: TextAttributes, range: Range<Int>) {
        setAttributes(attributes, range: NSRange(range))
    }
    
    /**
     Sets the attributes for the characters in the specified range to the specified attributes.
     
     - parameter attributes: The attributes to set.
     - parameter range:      The range of characters whose attributes are set.
     */
    public func setAttributes(_ attributes: TextAttributes, range: NSRange) {
        setAttributes(attributes.dictionary, range: range)
    }
    
    /**
     Adds the given attributes.
     
     - parameter attributes: The attributes to add.
     */
    public func addAttributes(_ attributes: TextAttributes) {
        addAttributes(attributes, range: NSRange(mutableString))
    }
    
    /**
     Adds the given collection of attributes to the characters in the specified range.
     
     - parameter attributes: The attributes to add.
     - parameter range:      he range of characters to which the specified attributes apply.
     */
    public func addAttributes(_ attributes: TextAttributes, range: Range<Int>) {
        addAttributes(attributes, range: NSRange(range))
    }
    
    /**
     Adds the given collection of attributes to the characters in the specified range.
     
     - parameter attributes: The attributes to add.
     - parameter range:      he range of characters to which the specified attributes apply.
     */
    public func addAttributes(_ attributes: TextAttributes, range: NSRange) {
        addAttributes(attributes.dictionary, range: range)
    }
}
