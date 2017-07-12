//
// TextAttributes.swift
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

public enum LigatureStyle: Int {
    case none
    case `default`
    case all
}

public enum VerticalGlyphForm: Int {
    case horizontal
    case vertical
}

public enum TextEffect {
    case letterpress
    
    init?(name: String) {
        if name == NSAttributedString.TextEffectStyle.letterpressStyle.rawValue {
            self = .letterpress
        } else {
            return nil
        }
    }
    
    var name: String {
        switch self {
        case .letterpress: return NSAttributedString.TextEffectStyle.letterpressStyle.rawValue
        }
    }
}

open class TextAttributes {
    /// The attributes dictionary.
    open fileprivate(set) var dictionary: [NSAttributedStringKey: Any] = [:]
    
    /**
     Create an instance of TextAttributes with a base.
     
     - parameter base: The base.
     
     - returns: The created TextAttributes.
     */
    @available(*, deprecated: 1, message: "Please use the clone() method.")
    public init(base: TextAttributes) {
        dictionary = base.dictionary
        paragraphStyle = base.paragraphStyle.clone()
        dictionary[NSAttributedStringKey.paragraphStyle] = paragraphStyle
    }
    
    /**
     Create an instance of TextAttributes.
     
     - returns: The created TextAttributes.
     */
    public init() {
        dictionary[NSAttributedStringKey.paragraphStyle] = paragraphStyle
    }
    
    /**
     Creates a copy of the receiver.
     
     - returns: A copy of the receiver.
     */
    open func clone() -> TextAttributes {
        let clone = TextAttributes()
        
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
            return dictionary[NSAttributedStringKey.font] as? Font ?? Font(name: "HelveticaNeue", size: 12)
        }
        set {
            dictionary[NSAttributedStringKey.font] = newValue
        }
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
            if let int = dictionary[NSAttributedStringKey.ligature] as? Int, let ligature = LigatureStyle(rawValue: int) {
                return ligature
            } else {
                return .default
            }
        }
        
        set {
            dictionary[NSAttributedStringKey.ligature] = NSNumber(value: newValue.hashValue)
        }
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
            return dictionary[NSAttributedStringKey.kern] as? CGFloat ?? 0
        }
        
        set {
            dictionary[NSAttributedStringKey.kern] = newValue as NSNumber
        }
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
            if let int = dictionary[NSAttributedStringKey.strikethroughStyle] as? Int, let style = NSUnderlineStyle(rawValue: int) {
                return style
            } else {
                return .styleNone
            }
        }
        
        set {
            dictionary[NSAttributedStringKey.strikethroughStyle] = NSNumber(value: newValue.rawValue)
        }
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
            return dictionary[NSAttributedStringKey.strikethroughColor] as? Color
        }
        set {
            dictionary[NSAttributedStringKey.strikethroughColor] = newValue
        }
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
    
    /**
     Sets the strikethrough color attribute and returns the receiver.
     
     - parameter image: The image to use when creating the pattern color.
     
     - returns: The receiver.
     */
    @discardableResult
    open func strikethroughColor(patternImage image: Image) -> Self {
        return strikethroughColor(Color(patternImage: image))
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
            if let int = dictionary[NSAttributedStringKey.underlineStyle] as? Int, let style = NSUnderlineStyle(rawValue: int) {
                return style
            } else {
                return .styleNone
            }
        }
        
        set {
            dictionary[NSAttributedStringKey.underlineStyle] = NSNumber(value: newValue.rawValue)
        }
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
            return dictionary[NSAttributedStringKey.underlineColor] as? Color
        }
        set {
            dictionary[NSAttributedStringKey.underlineColor] = newValue
        }
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
    
    /**
     Sets the underline color attribute and returns the receiver.
     
     - parameter image: The image to use when creating the pattern color.
     
     - returns: The receiver.
     */
    @discardableResult
    open func underlineColor(patternImage image: Image) -> Self {
        return underlineColor(Color(patternImage: image))
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
            return dictionary[NSAttributedStringKey.strokeColor] as? Color
        }
        set {
            dictionary[NSAttributedStringKey.strokeColor] = newValue
        }
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
    
    /**
     Sets the stroke color attribute and returns the receiver.
     
     - parameter image: The image to use when creating the pattern color.
     
     - returns: The receiver.
     */
    @discardableResult
    open func strokeColor(patternImage image: Image) -> Self {
        return strokeColor(Color(patternImage: image))
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
            return dictionary[NSAttributedStringKey.strokeWidth] as? CGFloat ?? 0
        }
        set {
            dictionary[NSAttributedStringKey.strokeWidth] = newValue as NSNumber
        }
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
            return dictionary[NSAttributedStringKey.foregroundColor] as? Color
        }
        set {
            dictionary[NSAttributedStringKey.foregroundColor] = newValue
        }
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
    
    /**
     Sets the foreground color attribute and returns the receiver.
     
     - parameter image: The image to use when creating the pattern color.
     
     - returns: The receiver.
     */
    @discardableResult
    open func foregroundColor(patternImage image: Image) -> Self {
        return foregroundColor(Color(patternImage: image))
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
            if let string = dictionary[NSAttributedStringKey.textEffect] as? String, let effect = TextEffect(name: string) {
                return effect
            }
            return nil
        }
        set {
            if let name = newValue?.name {
                dictionary[NSAttributedStringKey.textEffect] = NSString(string: name)
            } else {
                dictionary[NSAttributedStringKey.textEffect] = nil
            }
        }
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
            if let URL = dictionary[NSAttributedStringKey.link] as? URL {
                return URL
            } else if let string = dictionary[NSAttributedStringKey.link] as? String {
                return URL(string: string)
            } else {
                return nil
            }
        }
        set {
            dictionary[NSAttributedStringKey.link] = newValue
        }
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
            return dictionary[NSAttributedStringKey.baselineOffset] as? CGFloat ?? 0
        }
        set {
            dictionary[NSAttributedStringKey.baselineOffset] = newValue as NSNumber
        }
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
            return dictionary[NSAttributedStringKey.obliqueness] as? CGFloat ?? 0
        }
        set {
            dictionary[NSAttributedStringKey.obliqueness] = newValue as NSNumber
        }
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
            return dictionary[NSAttributedStringKey.expansion] as? CGFloat ?? 0
        }
        set {
            dictionary[NSAttributedStringKey.expansion] = newValue as NSNumber
        }
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
            if let int = dictionary[NSAttributedStringKey.verticalGlyphForm] as? Int, let form = VerticalGlyphForm(rawValue: int) {
                return form
            } else {
                return .horizontal
            }
        }
        set {
            dictionary[NSAttributedStringKey.verticalGlyphForm] = NSNumber(value: newValue.hashValue)
        }
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
            return dictionary[NSAttributedStringKey.backgroundColor] as? Color
        }
        set {
            dictionary[NSAttributedStringKey.backgroundColor] = newValue
        }
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
    
    /**
     Sets the background color attribute and returns the receiver.
     
     - parameter image: The image to use when creating the pattern color.
     
     - returns: The receiver.
     */
    @discardableResult
    open func backgroundColor(patternImage image: Image) -> Self {
        return backgroundColor(Color(patternImage: image))
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
            dictionary[NSAttributedStringKey.paragraphStyle] = paragraphStyle
        }
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
    extension TextAttributes {
        // MARK: - Shadow
        
        /// The shadow attribute.
        public var shadow: NSShadow? {
            get {
                return dictionary[NSAttributedStringKey.shadow] as? NSShadow
            }
            set {
                dictionary[NSAttributedStringKey.shadow] = newValue
            }
        }
        
        #if os(OSX)
            /**
             Sets the shadow attribute and returns the receiver.
             
             - parameter color:      The color of the shadow.
             - parameter offset:     The offset values of the shadow.
             - parameter blurRadius: The blur radius of the shadow.
             
             - returns: The receiver.
             */
            @discardableResult
            public func shadow(color: NSColor?, offset: CGSize, blurRadius: CGFloat) -> Self {
                return shadow({
                    let shadow = NSShadow()
                    shadow.shadowColor = color
                    shadow.shadowOffset = offset
                    shadow.shadowBlurRadius = blurRadius
                    return shadow
                }() as NSShadow)
            }
        #else
            /**
             Sets the shadow attribute and returns the receiver.
             
             - parameter color:      The color of the shadow.
             - parameter offset:     The offset values of the shadow.
             - parameter blurRadius: The blur radius of the shadow.
             
             - returns: The receiver.
             */
            @discardableResult
            public func shadow(color: AnyObject?, offset: CGSize, blurRadius: CGFloat) -> Self {
                return shadow({
                    let shadow = NSShadow()
                    shadow.shadowColor = color
                    shadow.shadowOffset = offset
                    shadow.shadowBlurRadius = blurRadius
                    return shadow
                }() as NSShadow)
            }
        #endif
        
        /**
         Sets the shadow attribute and returns the receiver.
         
         - parameter shadow: The shadow.
         
         - returns: The receiver.
         */
        @discardableResult
        public func shadow(_ shadow: NSShadow?) -> Self {
            self.shadow = shadow
            return self
        }
        
        // MARK: - Attachment
        
        /// The attachment attribute.
        public var attachment: NSTextAttachment? {
            get {
                return dictionary[NSAttributedStringKey.attachment] as? NSTextAttachment
            }
            set {
                dictionary[NSAttributedStringKey.attachment] = newValue
            }
        }
        
        /**
         Sets the attachment attribute and returns the receiver.
         
         - parameter attachment: The text attachment.
         
         - returns: The receiver.
         */
        @discardableResult
        public func attachment(_ attachment: NSTextAttachment?) -> Self {
            self.attachment = attachment
            return self
        }
    }
#endif
