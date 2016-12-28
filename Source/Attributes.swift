//
// Attributes.swift
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

open class Attributes {
    /// The attributes dictionary.
    open fileprivate(set) var dictionary: [String: Any] = [:]
    
    /**
     Create an instance of Attributes.
     
     - returns: The created Attributes.
     */
    public init() {
        dictionary[NSParagraphStyleAttributeName] = paragraphStyle
    }
    
    /**
     Creates a copy of the receiver.
     
     - returns: A copy of the receiver.
     */
    open func clone() -> Attributes {
        let clone = Attributes()
        
        clone.dictionary = dictionary
        
        #if !os(watchOS)
            if let shadow = shadow?.copy() as? NSShadow {
                clone.shadow = shadow
            }
            
            clone.attachment = attachment
            
            clone.paragraphStyle = paragraphStyle.clone()
        #endif
        
        return clone
    }
    
    // MARK: - Font
    
    /// The font attribute.
    open var font: Font? {
        get {
            return dictionary[NSFontAttributeName] as? Font ?? Font(name: "HelveticaNeue", size: 12)
        }
        set {
            dictionary[NSFontAttributeName] = newValue
        }
    }
    
    open static func font(name: String, size: CGFloat) -> Attributes {
        return Attributes().font(name: name, size: size)
    }
    
    /**
     Sets the font attribute and returns the receiver.
     
     - parameter name: The fully specified name of the font.
     - parameter size: The size (in points) to which the font is scaled.
     
     - returns: The receiver.
     */
    @discardableResult
    open func font(name: String, size: CGFloat) -> Self {
        return font(Font(name: name, size: size))
    }
    
    open static func font(_ font: Font?) -> Attributes {
        return Attributes().font(font)
    }
    
    /**
     Sets the font attribute and returns the receiver.
     
     - parameter font: The font.
     
     - returns: The receiver.
     */
    @discardableResult
    open func font(_ font: Font?) -> Self {
        self.font = font
        return self
    }
    
    // MARK: - Ligature
    
    /// The ligature attribute.
    open var ligature: LigatureStyle {
        get {
            if let int = dictionary[NSLigatureAttributeName] as? Int, let ligature = LigatureStyle(rawValue: int) {
                return ligature
            } else {
                return .default
            }
        }
        
        set {
            dictionary[NSLigatureAttributeName] = NSNumber(value: newValue.hashValue)
        }
    }
    
    open static func ligature(_ style: LigatureStyle) -> Attributes {
        return Attributes().ligature(style)
    }
    
    /**
     Sets the ligature attribute and returns the receiver.
     
     - parameter style: The ligature style.
     
     - returns: The receiver.
     */
    @discardableResult
    open func ligature(_ style: LigatureStyle) -> Self {
        self.ligature = style
        return self
    }
    
    // MARK: - Kern
    
    /// The number of points by which to adjust kern-pair characters.
    open var kern: CGFloat {
        get {
            return dictionary[NSKernAttributeName] as? CGFloat ?? 0
        }
        
        set {
            dictionary[NSKernAttributeName] = newValue as NSNumber
        }
    }
    
    open static func kern(_ value: CGFloat) -> Attributes {
        return Attributes().kern(value)
    }
    
    /**
     Sets the number of points by which to adjust kern-pair characters and returns the receiver.
     
     - parameter value: The number of points by which to adjust kern-pair characters.
     
     - returns: The receiver.
     */
    @discardableResult
    open func kern(_ value: CGFloat) -> Self {
        self.kern = value
        return self
    }
    
    // MARK: - Striketrough style
    
    /// The strikethrough style attribute.
    open var strikethroughStyle: NSUnderlineStyle {
        get {
            if let int = dictionary[NSStrikethroughStyleAttributeName] as? Int, let style = NSUnderlineStyle(rawValue: int) {
                return style
            } else {
                return .styleNone
            }
        }
        
        set {
            dictionary[NSStrikethroughStyleAttributeName] = NSNumber(value: newValue.rawValue)
        }
    }
    
    open static func strikethroughStyle(_ style: NSUnderlineStyle) -> Attributes {
        return Attributes().strikethroughStyle(style)
    }
    
    /**
     Sets the strikethrough style attribute and returns the receiver.
     
     - parameter style: The strikethrough style.
     
     - returns: The receiver.
     */
    @discardableResult
    open func strikethroughStyle(_ style: NSUnderlineStyle) -> Self {
        self.strikethroughStyle = style
        return self
    }
    
    // MARK: - Strikethrough color
    
    /// The strikethrough color attribute.
    var strikethroughColor: Color? {
        get {
            return dictionary[NSStrikethroughColorAttributeName] as? Color
        }
        set {
            dictionary[NSStrikethroughColorAttributeName] = newValue
        }
    }
    
    open static func strikethroughColor(white: CGFloat, alpha: CGFloat) -> Attributes {
        return Attributes().strokeColor(white: white, alpha: alpha)
    }
    
    /**
     Sets the strikethrough color attribute and returns the receiver.
     
     - parameter white: The grayscale value of the color object.
     - parameter alpha: The opacity value of the color object.
     
     - returns: The receiver.
     */
    @discardableResult
    open func strikethroughColor(white: CGFloat, alpha: CGFloat) -> Self {
        return strikethroughColor(Color(white: white, alpha: alpha))
    }
    
    open static func strikethroughColor(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) -> Attributes {
        return Attributes().backgroundColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
    
    /**
     Sets the strikethrough color attribute and returns the receiver.
     
     - parameter hue:        The hue component of the color object.
     - parameter saturation: The saturation component of the color object.
     - parameter brightness: The brightness component of the color object.
     - parameter alpha:      The opacity value of the color object.
     
     - returns: The receiver.
     */
    @discardableResult
    open func strikethroughColor(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) -> Self {
        return strikethroughColor(Color(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha))
    }
    
    open static func strikethroughColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> Attributes {
        return Attributes().strikethroughColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     Sets the strikethrough color attribute and returns the receiver.
     
     - parameter red:   The red component of the color object.
     - parameter green: The green component of the color object.
     - parameter blue:  The blue component of the color object.
     - parameter alpha: The opacity value of the color object.
     
     - returns: The receiver.
     */
    @discardableResult
    open func strikethroughColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> Self {
        return strikethroughColor(Color(red: red, green: green, blue: blue, alpha: alpha))
    }
    
    open static func strikethroughColor(patternImage image: Image) -> Attributes {
        return Attributes().strikethroughColor(patternImage: image)
    }
    
    /**
     Sets the strikethrough color attribute and returns the receiver.
     
     - parameter image: The image to use when creating the pattern color.
     
     - returns: The receiver.
     */
    @discardableResult
    open func strikethroughColor(patternImage image: Image) -> Self {
        return strikethroughColor(Color(patternImage: image))
    }
    
    open static func strikethroughColor(_ color: Color?) -> Attributes {
        return Attributes().strikethroughColor(color)
    }
    
    /**
     Sets the strikethrough color attribute and returns the receiver.
     
     - parameter color: The color.
     
     - returns: The receiver.
     */
    @discardableResult
    open func strikethroughColor(_ color: Color?) -> Self {
        self.strikethroughColor = color
        return self
    }
    
    // MARK: - Underline style
    
    /// The underline style attribute.
    open var underlineStyle: NSUnderlineStyle {
        get {
            if let int = dictionary[NSUnderlineStyleAttributeName] as? Int, let style = NSUnderlineStyle(rawValue: int) {
                return style
            } else {
                return .styleNone
            }
        }
        
        set {
            dictionary[NSUnderlineStyleAttributeName] = NSNumber(value: newValue.rawValue)
        }
    }
    
    open static func underlineStyle(_ style: NSUnderlineStyle) -> Attributes {
        return Attributes().underlineStyle(style)
    }
    
    /**
     Sets the underline style attribute and returns the receiver.
     
     - parameter style: The underline style.
     
     - returns: The receiver.
     */
    @discardableResult
    open func underlineStyle(_ style: NSUnderlineStyle) -> Self {
        self.underlineStyle = style
        return self
    }
    
    // MARK: - Underline color
    
    /// The underline color attribute.
    open var underlineColor: Color? {
        get {
            return dictionary[NSUnderlineColorAttributeName] as? Color
        }
        set {
            dictionary[NSUnderlineColorAttributeName] = newValue
        }
    }
    
    open static func underlineColor(white: CGFloat, alpha: CGFloat) -> Attributes {
        return Attributes().underlineColor(white: white, alpha: alpha)
    }
    
    /**
     Sets the underline color attribute and returns the receiver.
     
     - parameter white: The grayscale value of the color object.
     - parameter alpha: The opacity value of the color object.
     
     - returns: The receiver.
     */
    @discardableResult
    open func underlineColor(white: CGFloat, alpha: CGFloat) -> Self {
        return underlineColor(Color(white: white, alpha: alpha))
    }
    
    open static func underlineColor(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) -> Attributes {
        return Attributes().underlineColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
    
    /**
     Sets the underline color attribute and returns the receiver.
     
     - parameter hue:        The hue component of the color object.
     - parameter saturation: The saturation component of the color object.
     - parameter brightness: The brightness component of the color object.
     - parameter alpha:      The opacity value of the color object.
     
     - returns: The receiver.
     */
    @discardableResult
    open func underlineColor(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) -> Self {
        return underlineColor(Color(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha))
    }
    
    open static func underlineColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> Attributes {
        return Attributes().underlineColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     Sets the underline color attribute and returns the receiver.
     
     - parameter red:   The red component of the color object.
     - parameter green: The green component of the color object.
     - parameter blue:  The blue component of the color object.
     - parameter alpha: The opacity value of the color object.
     
     - returns: The receiver.
     */
    @discardableResult
    open func underlineColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> Self {
        return underlineColor(Color(red: red, green: green, blue: blue, alpha: alpha))
    }
    
    open static func underlineColor(patternImage image: Image) -> Attributes {
        return Attributes().underlineColor(patternImage: image)
    }
    
    /**
     Sets the underline color attribute and returns the receiver.
     
     - parameter image: The image to use when creating the pattern color.
     
     - returns: The receiver.
     */
    @discardableResult
    open func underlineColor(patternImage image: Image) -> Self {
        return underlineColor(Color(patternImage: image))
    }
    
    open static func underlineColor(_ color: Color?) -> Attributes {
        return Attributes().underlineColor(color)
    }
    
    /**
     Sets the underline color attribute and returns the receiver.
     
     - parameter color: The color.
     
     - returns: The receiver.
     */
    @discardableResult
    open func underlineColor(_ color: Color?) -> Self {
        self.underlineColor = color
        return self
    }
    
    // MARK: - Stroke color
    
    /// The stroke color attribute.
    open var strokeColor: Color? {
        get {
            return dictionary[NSStrokeColorAttributeName] as? Color
        }
        set {
            dictionary[NSStrokeColorAttributeName] = newValue
        }
    }
    
    open static func strokeColor(white: CGFloat, alpha: CGFloat) -> Attributes {
        return Attributes().strokeColor(white: white, alpha: alpha)
    }
    
    /**
     Sets the stroke color attribute and returns the receiver.
     
     - parameter white: The grayscale value of the color object.
     - parameter alpha: The opacity value of the color object.
     
     - returns: The receiver.
     */
    @discardableResult
    open func strokeColor(white: CGFloat, alpha: CGFloat) -> Self {
        return strokeColor(Color(white: white, alpha: alpha))
    }
    
    open static func strokeColor(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) -> Attributes {
        return Attributes().strokeColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
    
    /**
     Sets the stroke color attribute and returns the receiver.
     
     - parameter hue:        The hue component of the color object.
     - parameter saturation: The saturation component of the color object.
     - parameter brightness: The brightness component of the color object.
     - parameter alpha:      The opacity value of the color object.
     
     - returns: The receiver.
     */
    @discardableResult
    open func strokeColor(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) -> Self {
        return strokeColor(Color(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha))
    }
    
    open static func strokeColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> Attributes {
        return Attributes().strokeColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     Sets the stroke color attribute and returns the receiver.
     
     - parameter red:   The red component of the color object.
     - parameter green: The green component of the color object.
     - parameter blue:  The blue component of the color object.
     - parameter alpha: The opacity value of the color object.
     
     - returns: The receiver.
     */
    @discardableResult
    open func strokeColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> Self {
        return strokeColor(Color(red: red, green: green, blue: blue, alpha: alpha))
    }
    
    open static func strokeColor(patternImage image: Image) -> Attributes {
        return Attributes().strokeColor(patternImage: image)
    }
    
    /**
     Sets the stroke color attribute and returns the receiver.
     
     - parameter image: The image to use when creating the pattern color.
     
     - returns: The receiver.
     */
    @discardableResult
    open func strokeColor(patternImage image: Image) -> Self {
        return strokeColor(Color(patternImage: image))
    }
    
    open static func strokeColor(_ color: Color?) -> Attributes {
        return Attributes().strokeColor(color)
    }
    
    /**
     Sets the underline color attribute and returns the receiver.
     
     - parameter color: The color.
     
     - returns: The receiver.
     */
    @discardableResult
    open func strokeColor(_ color: Color?) -> Self {
        self.strokeColor = color
        return self
    }
    
    // MARK: - Stroke width
    
    /// The stroke width attribute.
    open var strokeWidth: CGFloat {
        get {
            return dictionary[NSStrokeWidthAttributeName] as? CGFloat ?? 0
        }
        set {
            dictionary[NSStrokeWidthAttributeName] = newValue as NSNumber
        }
    }
    
    open static func strokeWidth(_ width: CGFloat) -> Attributes {
        return Attributes().strokeWidth(width)
    }
    
    /**
     Sets the stroke width attribute and returns the receiver.
     
     - parameter width: The stroke width.
     
     - returns: The receiver.
     */
    @discardableResult
    open func strokeWidth(_ width: CGFloat) -> Self {
        self.strokeWidth = width
        return self
    }
    
    // MARK: - Foreground color
    
    /// The foreground color attribute.
    open var foregroundColor: Color? {
        get {
            return dictionary[NSForegroundColorAttributeName] as? Color
        }
        set {
            dictionary[NSForegroundColorAttributeName] = newValue
        }
    }
    
    open static func foregroundColor(white: CGFloat, alpha: CGFloat) -> Attributes {
        return Attributes().foregroundColor(white: white, alpha: alpha)
    }
    
    /**
     Sets the foreground color attribute and returns the receiver.
     
     - parameter white: The grayscale value of the color object.
     - parameter alpha: The opacity value of the color object.
     
     - returns: The receiver.
     */
    @discardableResult
    open func foregroundColor(white: CGFloat, alpha: CGFloat) -> Self {
        return foregroundColor(Color(white: white, alpha: alpha))
    }
    
    open static func foregroundColor(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) -> Attributes {
        return Attributes().foregroundColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
    
    /**
     Sets the foreground color attribute and returns the receiver.
     
     - parameter hue:        The hue component of the color object.
     - parameter saturation: The saturation component of the color object.
     - parameter brightness: The brightness component of the color object.
     - parameter alpha:      The opacity value of the color object.
     
     - returns: The receiver.
     */
    @discardableResult
    open func foregroundColor(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) -> Self {
        return foregroundColor(Color(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha))
    }
    
    open static func foregroundColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> Attributes {
        return Attributes().foregroundColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     Sets the foreground color attribute and returns the receiver.
     
     - parameter red:   The red component of the color object.
     - parameter green: The green component of the color object.
     - parameter blue:  The blue component of the color object.
     - parameter alpha: The opacity value of the color object.
     
     - returns: The receiver.
     */
    @discardableResult
    open func foregroundColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> Self {
        return foregroundColor(Color(red: red, green: green, blue: blue, alpha: alpha))
    }
    
    open static func foregroundColor(patternImage image: Image) -> Attributes {
        return Attributes().foregroundColor(patternImage: image)
    }
    
    /**
     Sets the foreground color attribute and returns the receiver.
     
     - parameter image: The image to use when creating the pattern color.
     
     - returns: The receiver.
     */
    @discardableResult
    open func foregroundColor(patternImage image: Image) -> Self {
        return foregroundColor(Color(patternImage: image))
    }
    
    open static func foregroundColor(_ color: Color?) -> Attributes {
        return Attributes().foregroundColor(color)
    }
    
    /**
     Sets the foreground color attribute and returns the receiver.
     
     - parameter color: The color.
     
     - returns: The receiver.
     */
    @discardableResult
    open func foregroundColor(_ color: Color?) -> Self {
        self.foregroundColor = color
        return self
    }
    
    // MARK: - TextEffect
    
    /// The text effect attribute.
    open var textEffect: TextEffect? {
        get {
            if let string = dictionary[NSTextEffectAttributeName] as? String, let effect = TextEffect(name: string) {
                return effect
            }
            return nil
        }
        set {
            if let name = newValue?.name {
                dictionary[NSTextEffectAttributeName] = NSString(string: name)
            } else {
                dictionary[NSTextEffectAttributeName] = nil
            }
        }
    }
    
    open static func textEffect(_ style: TextEffect?) -> Attributes {
        return Attributes().textEffect(style)
    }
    
    /**
     Sets the text effect attribute and returns the receiver.
     
     - parameter style: The text effect.
     
     - returns: The receiver.
     */
    @discardableResult
    open func textEffect(_ style: TextEffect?) -> Self {
        self.textEffect = style
        return self
    }
    
    // MARK: - Link
    
    /// The link attribute.
    open var link: URL? {
        get {
            if let URL = dictionary[NSLinkAttributeName] as? URL {
                return URL
            } else if let string = dictionary[NSLinkAttributeName] as? String {
                return URL(string: string)
            } else {
                return nil
            }
        }
        set {
            dictionary[NSLinkAttributeName] = newValue
        }
    }
    
    open static func link(string: String) -> Attributes {
        return Attributes().link(string: string)
    }
    
    /**
     Sets the link attribute and returns the receiver.
     
     - parameter string: The URL string with which to initialize the NSURL object.
     
     - returns: The receiver.
     */
    @discardableResult
    open func link(string: String) -> Self {
        return link(URL(string: string))
    }
    
    open static func link(string: String, relativeToURL baseURL: URL) -> Attributes {
        return Attributes().link(string: string, relativeToURL: baseURL)
    }
    
    /**
     Sets the link attribute and returns the receiver.
     
     - parameter string:  The URL string with which to initialize the NSURL object.
     - parameter baseURL: The base URL for the NSURL object.
     
     - returns: The receiver.
     */
    @discardableResult
    open func link(string: String, relativeToURL baseURL: URL) -> Self {
        return link(URL(string: string, relativeTo: baseURL))
    }
    
    open static func link(_ URL: URL?) -> Attributes {
        return Attributes().link(URL)
    }
    
    /**
     Sets the link attribute and returns the receiver.
     
     - parameter URL: The URL.
     
     - returns: The receiver.
     */
    @discardableResult
    open func link(_ URL: URL?) -> Self {
        self.link = URL
        return self
    }
    
    // MARK: - Baseline offset
    
    /// The baseline offset attribute.
    open var baselineOffset: CGFloat {
        get {
            return dictionary[NSBaselineOffsetAttributeName] as? CGFloat ?? 0
        }
        set {
            dictionary[NSBaselineOffsetAttributeName] = newValue as NSNumber
        }
    }
    
    open static func baselineOffset(_ value: CGFloat) -> Attributes {
        return Attributes().baselineOffset(value)
    }
    
    /**
     Sets the baseline offset attribute and return the receiver.
     
     - parameter value: The baseline offset.
     
     - returns: The receiver.
     */
    @discardableResult
    open func baselineOffset(_ value: CGFloat) -> Self {
        self.baselineOffset = value
        return self
    }
    
    // MARK: - Obliqueness
    
    /// The obliqueness attribute.
    open var obliqueness: CGFloat {
        get {
            return dictionary[NSObliquenessAttributeName] as? CGFloat ?? 0
        }
        set {
            dictionary[NSObliquenessAttributeName] = newValue as NSNumber
        }
    }
    
    open static func obliqueness(_ value: CGFloat) -> Attributes {
        return Attributes().obliqueness(value)
    }
    
    /**
     Sets the obliqueness attribute and returns the receiver.
     
     - parameter value: The obliqueness.
     
     - returns: The receiver.
     */
    @discardableResult
    open func obliqueness(_ value: CGFloat) -> Self {
        self.obliqueness = value
        return self
    }
    
    // MARK: - Expansion
    
    /// The expansion attribute.
    open var expansion: CGFloat {
        get {
            return dictionary[NSExpansionAttributeName] as? CGFloat ?? 0
        }
        set {
            dictionary[NSExpansionAttributeName] = newValue as NSNumber
        }
    }
    
    open static func expansion(_ value: CGFloat) -> Attributes {
        return Attributes().expansion(value)
    }
    
    /**
     Sets the expansion attribute and returns the receiver.
     
     - parameter value: The expansion attribute.
     
     - returns: The receiver.
     */
    @discardableResult
    open func expansion(_ value: CGFloat) -> Self {
        self.expansion = value
        return self
    }
    
    // MARK: - Vertical glyph form
    
    /// The vertical glyph form attribute.
    open var verticalGlyphForm: VerticalGlyphForm {
        get {
            if let int = dictionary[NSVerticalGlyphFormAttributeName] as? Int, let form = VerticalGlyphForm(rawValue: int) {
                return form
            } else {
                return .horizontal
            }
        }
        set {
            dictionary[NSVerticalGlyphFormAttributeName] = NSNumber(value: newValue.hashValue)
        }
    }
    
    open static func verticalGlyphForm(_ value: VerticalGlyphForm) -> Attributes {
        return Attributes().verticalGlyphForm(value)
    }
    
    /**
     Sets the vertical glyph form attribute and returns the receiver.
     
     - parameter value: The vertical glyph form.
     
     - returns: The receiver.
     */
    @discardableResult
    open func verticalGlyphForm(_ value: VerticalGlyphForm) -> Self {
        self.verticalGlyphForm = value
        return self
    }
    
    // MARK: - Background color
    
    /// The background color attribute.
    var backgroundColor: Color? {
        get {
            return dictionary[NSBackgroundColorAttributeName] as? Color
        }
        set {
            dictionary[NSBackgroundColorAttributeName] = newValue
        }
    }
    
    open static func backgroundColor(white: CGFloat, alpha: CGFloat) -> Attributes {
        return Attributes().backgroundColor(white: white, alpha: alpha)
    }
    
    /**
     Sets the background color attribute and returns the receiver.
     
     - parameter white: The grayscale value of the color object.
     - parameter alpha: The opacity value of the color object.
     
     - returns: The receiver.
     */
    @discardableResult
    open func backgroundColor(white: CGFloat, alpha: CGFloat) -> Self {
        return backgroundColor(Color(white: white, alpha: alpha))
    }
    
    open static func backgroundColor(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) -> Attributes {
        return Attributes().backgroundColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
    
    /**
     Sets the background color attribute and returns the receiver.
     
     - parameter hue:        The hue component of the color object.
     - parameter saturation: The saturation component of the color object.
     - parameter brightness: The brightness component of the color object.
     - parameter alpha:      The opacity value of the color object.
     
     - returns: The receiver.
     */
    @discardableResult
    open func backgroundColor(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) -> Self {
        return backgroundColor(Color(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha))
    }
    
    open static func backgroundColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> Attributes {
        return Attributes().backgroundColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     Sets the background color attribute and returns the receiver.
     
     - parameter red:   The red component of the color object.
     - parameter green: The green component of the color object.
     - parameter blue:  The blue component of the color object.
     - parameter alpha: The opacity value of the color object.
     
     - returns: The receiver.
     */
    @discardableResult
    open func backgroundColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> Self {
        return backgroundColor(Color(red: red, green: green, blue: blue, alpha: alpha))
    }
    
    open static func backgroundColor(patternImage image: Image) -> Attributes {
        return Attributes().backgroundColor(patternImage: image)
    }
    
    /**
     Sets the background color attribute and returns the receiver.
     
     - parameter image: The image to use when creating the pattern color.
     
     - returns: The receiver.
     */
    @discardableResult
    open func backgroundColor(patternImage image: Image) -> Self {
        return backgroundColor(Color(patternImage: image))
    }
    
    open static func backgroundColor(_ color: Color?) -> Attributes {
        return Attributes().backgroundColor(color)
    }
    
    /**
     Sets the background color attribute and returns the receiver.
     
     - parameter color: The color.
     
     - returns: The receiver.
     */
    @discardableResult
    open func backgroundColor(_ color: Color?) -> Self {
        self.backgroundColor = color
        return self
    }
    
    // MARK: - Paragraph style
    
    /// The paragraph style attribute.
    open var paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle() {
        didSet {
            dictionary[NSParagraphStyleAttributeName] = paragraphStyle
        }
    }
    
    open static func paragraphStyle(_ style: NSMutableParagraphStyle) -> Attributes {
        return Attributes().paragraphStyle(style)
    }
    
    /**
     Sets the paragraph style attribute and returns the receiver.
     
     - parameter style: The paragraph style.
     
     - returns: The receiver.
     */
    @discardableResult
    open func paragraphStyle(_ style: NSMutableParagraphStyle) -> Self {
        self.paragraphStyle = style
        return self
    }
    
    // MARK: - Alignment
    
    /// The text alignment of the paragraph style.
    open var alignment: NSTextAlignment {
        get { return paragraphStyle.alignment }
        set { paragraphStyle.alignment = newValue }
    }
    
    open static func alignment(_ alignment: NSTextAlignment) -> Attributes {
        return Attributes().alignment(alignment)
    }
    
    /**
     Sets the text alignment of the paragraph style and returns the receiver.
     
     - parameter alignment: The text alignment.
     
     - returns: The receiver.
     */
    @discardableResult
    open func alignment(_ alignment: NSTextAlignment) -> Self {
        self.alignment = alignment
        return self
    }
    
    // MARK: - First line head indent
    
    /// The indentation of the first line of the paragraph style.
    open var firstLineHeadIndent: CGFloat {
        get { return paragraphStyle.firstLineHeadIndent }
        set { paragraphStyle.firstLineHeadIndent = newValue }
    }
    
    open static func firstLineHeadIndent(_ value: CGFloat) -> Attributes {
        return Attributes().firstLineHeadIndent(value)
    }
    
    /**
     Sets the indentation of the first line of the paragraph style and returns the receiver.
     
     - parameter value: The indentation.
     
     - returns: The receiver.
     */
    @discardableResult
    open func firstLineHeadIndent(_ value: CGFloat) -> Self {
        self.firstLineHeadIndent = value
        return self
    }
    
    // MARK: - Head indent
    
    /// The indentation of the paragraph style lines other than the first.
    open var headIndent: CGFloat {
        get { return paragraphStyle.headIndent }
        set { paragraphStyle.headIndent = newValue }
    }
    
    open static func headIndent(_ value: CGFloat) -> Attributes {
        return Attributes().headIndent(value)
    }
    
    /**
     Sets the indentation of the paragraph style lines other than the first and returns the receiver.
     
     - parameter value: The indentation of the lines other than the first.
     
     - returns: The receiver.
     */
    @discardableResult
    open func headIndent(_ value: CGFloat) -> Self {
        self.headIndent = value
        return self
    }
    
    // MARK: - Tail indent
    
    /// The trailing indentation of the paragraph style.
    open var tailIndent: CGFloat {
        get { return paragraphStyle.tailIndent }
        set { paragraphStyle.tailIndent = newValue }
    }
    
    open static func tailIndent(_ value: CGFloat) -> Attributes {
        return Attributes().tailIndent(value)
    }
    
    /**
     Sets the trailing indentation of the paragraph style and returns the receiver.
     
     - parameter value: The trailing indentation.
     
     - returns: The receiver.
     */
    @discardableResult
    open func tailIndent(_ value: CGFloat) -> Self {
        self.tailIndent = value
        return self
    }
    
    // MARK: - Line height multiple
    
    /// The line height multiple of the paragraph style.
    open var lineHeightMultiple: CGFloat {
        get { return paragraphStyle.lineHeightMultiple }
        set { paragraphStyle.lineHeightMultiple = newValue }
    }
    
    open static func lineHeightMultiple(_ value: CGFloat) -> Attributes {
        return Attributes().lineHeightMultiple(value)
    }
    
    /**
     Sets the line height multiple of the paragraph style and returns the receiver.
     
     - parameter value: The line height multiple.
     
     - returns: The receiver.
     */
    @discardableResult
    open func lineHeightMultiple(_ value: CGFloat) -> Self {
        self.lineHeightMultiple = value
        return self
    }
    
    // MARK: - Maximum line height
    
    /// The maximum line height of the paragraph style.
    open var maximumLineHeight: CGFloat {
        get { return paragraphStyle.maximumLineHeight }
        set { paragraphStyle.maximumLineHeight = newValue }
    }
    
    open static func maximumLineHeight(_ value: CGFloat) -> Attributes {
        return Attributes().maximumLineHeight(value)
    }
    
    /**
     Sets the maximum line height of the paragraph style and returns the receiver.
     
     - parameter value: The maximum line height.
     
     - returns: The receiver.
     */
    @discardableResult
    open func maximumLineHeight(_ value: CGFloat) -> Self {
        self.maximumLineHeight = value
        return self
    }
    
    // MARK: - Minimum line height
    
    /// The minimum line height of the paragraph style.
    open var minimumLineHeight: CGFloat {
        get { return paragraphStyle.minimumLineHeight }
        set { paragraphStyle.minimumLineHeight = newValue }
    }
    
    open static func minimumLineHeight(_ value: CGFloat) -> Attributes {
        return Attributes().minimumLineHeight(value)
    }
    
    /**
     Sets the minimum line height of the paragraph style and returns the receiver.
     
     - parameter value: The minimum line height.
     
     - returns: The receiver.
     */
    @discardableResult
    open func minimumLineHeight(_ value: CGFloat) -> Self {
        self.minimumLineHeight = value
        return self
    }
    
    // MARK: - Line spacing
    
    /// The line spacing of the paragraph style.
    open var lineSpacing: CGFloat {
        get { return paragraphStyle.lineSpacing }
        set { paragraphStyle.lineSpacing = newValue }
    }
    
    open static func lineSpacing(_ value: CGFloat) -> Attributes {
        return Attributes().lineSpacing(value)
    }
    
    /**
     Sets the line spacing of the paragraph style and returns the receiver.
     
     - parameter value: The line spacing.
     
     - returns: The receiver.
     */
    @discardableResult
    open func lineSpacing(_ value: CGFloat) -> Self {
        self.lineSpacing = value
        return self
    }
    
    // MARK: - Paragraph spacing
    
    /// The paragraph spacing of the paragraph style.
    open var paragraphSpacing: CGFloat {
        get { return paragraphStyle.paragraphSpacing }
        set { paragraphStyle.paragraphSpacing = newValue }
    }
    
    open static func paragraphSpacing(_ value: CGFloat) -> Attributes {
        return Attributes().paragraphSpacing(value)
    }
    
    /**
     Sets the paragraph spacing of the paragraph style and returns the receiver.
     
     - parameter value: The paragraph spacing.
     
     - returns: The receiver.
     */
    @discardableResult
    open func paragraphSpacing(_ value: CGFloat) -> Self {
        self.paragraphSpacing = value
        return self
    }
    
    // MARK: - Paragraph spacing before
    
    /// The distance between the paragraph's top and the beginning of its text content.
    open var paragraphSpacingBefore: CGFloat {
        get { return paragraphStyle.paragraphSpacingBefore }
        set { paragraphStyle.paragraphSpacingBefore = newValue }
    }
    
    open static func paragraphSpacingBefore(_ value: CGFloat) -> Attributes {
        return Attributes().paragraphSpacingBefore(value)
    }
    
    /**
     Sets the distance between the paragraph's top and the beginning of its text content and returns the receiver.
     
     - parameter value: The distance between the paragraph's top and the beginning of its text content.
     
     - returns: The receiver.
     */
    @discardableResult
    open func paragraphSpacingBefore(_ value: CGFloat) -> Self {
        self.paragraphSpacingBefore = value
        return self
    }
    
    // MARK: - Line Break Mode
    
    /// The mode that should be used to break lines.
    open var lineBreakMode: NSLineBreakMode {
        get { return paragraphStyle.lineBreakMode }
        set { paragraphStyle.lineBreakMode = newValue }
    }
    
    open static func lineBreakMode(_ value: NSLineBreakMode) -> Attributes {
        return Attributes().lineBreakMode(value)
    }
    
    /**
     Sets the mode that should be used to break lines and returns the receiver.
     
     - parameter value: The mode that should be used to break lines.
     
     - returns: The receiver.
     */
    @discardableResult
    open func lineBreakMode(_ value: NSLineBreakMode) -> Self {
        self.lineBreakMode = value
        return self
    }
}

#if !os(watchOS)
extension Attributes {
    // MARK: - Shadow
    
    /// The shadow attribute.
    open var shadow: NSShadow? {
        get {
            return dictionary[NSShadowAttributeName] as? NSShadow
        }
        set {
            dictionary[NSShadowAttributeName] = newValue
        }
    }
    
    #if os(OSX)
    open static func shadow(color: NSColor?, offset: CGSize, blurRadius: CGFloat) -> Attributes {
        return Attributes().shadow(color: color, offset: offset, blurRadius: blurRadius)
    }

    /**
     Sets the shadow attribute and returns the receiver.
     
     - parameter color:      The color of the shadow.
     - parameter offset:     The offset values of the shadow.
     - parameter blurRadius: The blur radius of the shadow.
     
     - returns: The receiver.
     */
    @discardableResult
    open func shadow(color: NSColor?, offset: CGSize, blurRadius: CGFloat) -> Self {
        return shadow({
            let shadow = NSShadow()
            shadow.shadowColor = color
            shadow.shadowOffset = offset
            shadow.shadowBlurRadius = blurRadius
            return shadow
        }() as NSShadow)
    }
    #else
    open static func shadow(color: AnyObject?, offset: CGSize, blurRadius: CGFloat) -> Attributes {
        return Attributes().shadow(color: color, offset: offset, blurRadius: blurRadius)
    }

    /**
     Sets the shadow attribute and returns the receiver.
     
     - parameter color:      The color of the shadow.
     - parameter offset:     The offset values of the shadow.
     - parameter blurRadius: The blur radius of the shadow.
     
     - returns: The receiver.
     */
    @discardableResult
    open func shadow(color: AnyObject?, offset: CGSize, blurRadius: CGFloat) -> Self {
        return shadow({
            let shadow = NSShadow()
            shadow.shadowColor = color
            shadow.shadowOffset = offset
            shadow.shadowBlurRadius = blurRadius
            return shadow
        }() as NSShadow)
    }
    #endif
    
    open static func shadow(_ shadow: NSShadow?) -> Attributes {
        return Attributes().shadow(shadow)
    }
    
    /**
     Sets the shadow attribute and returns the receiver.
     
     - parameter shadow: The shadow.
     
     - returns: The receiver.
     */
    @discardableResult
    open func shadow(_ shadow: NSShadow?) -> Self {
        self.shadow = shadow
        return self
    }
    
    // MARK: - Attachment
    
    /// The attachment attribute.
    open var attachment: NSTextAttachment? {
        get {
            return dictionary[NSAttachmentAttributeName] as? NSTextAttachment
        }
        set {
            dictionary[NSAttachmentAttributeName] = newValue
        }
    }
    
    open static func attachment(_ attachment: NSTextAttachment?) -> Attributes {
        return Attributes().attachment(attachment)
    }
    
    /**
     Sets the attachment attribute and returns the receiver.
     
     - parameter attachment: The text attachment.
     
     - returns: The receiver.
     */
    @discardableResult
    open func attachment(_ attachment: NSTextAttachment?) -> Self {
        self.attachment = attachment
        return self
    }
}
#endif
