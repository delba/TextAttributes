//
// Utilities.swift
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

#if os(OSX)
    public typealias Font  = NSFont
    public typealias Color = NSColor
    public typealias Image = NSImage
    
    extension NSColor {
        public convenience init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
            self.init(srgbRed: red, green: green, blue: blue, alpha: alpha)
        }
    }
#else
    public typealias Font  = UIFont
    public typealias Color = UIColor
    public typealias Image = UIImage
#endif

extension NSRange {
    init(_ range: Range<Int>) {
        self = NSRange(location: range.lowerBound, length: range.count)
    }
    
    init(_ string: NSString) {
        self = NSRange(location: 0, length: string.length)
    }
}

extension NSMutableParagraphStyle {
    func clone() -> NSMutableParagraphStyle {
        let clone = NSMutableParagraphStyle()
        
        if #available(iOS 9.0, *) {
            clone.setParagraphStyle(self)
        } else {
            clone.cloneParagraphStyle(self)
        }
        
        return clone
    }
    
    fileprivate func cloneParagraphStyle(_ other: NSMutableParagraphStyle) {
        alignment              = other.alignment
        firstLineHeadIndent    = other.firstLineHeadIndent
        headIndent             = other.headIndent
        tailIndent             = other.tailIndent
        lineBreakMode          = other.lineBreakMode
        maximumLineHeight      = other.maximumLineHeight
        minimumLineHeight      = other.minimumLineHeight
        lineSpacing            = other.lineSpacing
        paragraphSpacing       = other.paragraphSpacing
        paragraphSpacingBefore = other.paragraphSpacingBefore
        baseWritingDirection   = other.baseWritingDirection
        lineHeightMultiple     = other.lineHeightMultiple
    }
}
