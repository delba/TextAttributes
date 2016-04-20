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
    public convenience init(string: NSString, attributes: TextAttributes? = nil) {
        self.init(string: string as String, attributes: attributes)
    }
    
    public convenience init(string: String, attributes: TextAttributes? = nil) {
        self.init(string: string, attributes: attributes?.dictionary)
    }
}

extension NSMutableAttributedString {
    public func setAttributes(attributes: TextAttributes) {
        setAttributes(attributes, range: NSRange(mutableString))
    }
    
    public func setAttributes(attributes: TextAttributes, range: Range<Int>) {
        setAttributes(attributes, range: NSRange(range))
    }
    
    public func setAttributes(attributes: TextAttributes, range: NSRange) {
        setAttributes(attributes.dictionary, range: range)
    }
    
    public func addAttributes(attributes: TextAttributes) {
        addAttributes(attributes, range: NSRange(mutableString))
    }
    
    public func addAttributes(attributes: TextAttributes, range: Range<Int>) {
        addAttributes(attributes, range: NSRange(range))
    }
    
    public func addAttributes(attributes: TextAttributes, range: NSRange) {
        addAttributes(attributes.dictionary, range: range)
    }
}