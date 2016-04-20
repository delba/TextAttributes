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

public enum LigatureStyle {
    case None
    case Default
    case All
}

public enum VerticalGlyphForm {
    case Horizontal
    case Vertical
}

public enum TextEffect {
    case Letterpress
    
    var name: String {
        switch self {
        case .Letterpress: return NSTextEffectLetterpressStyle
        }
    }
}

public class TextAttributes {
    /// The attributes dictionary.
    public var dictionary: [String: AnyObject] = [:]
    
    /**
     Create an instance of TextAttributes with a base.
     
     - parameter base: The base.
     
     - returns: The created TextAttributes.
     */
    @available(*, deprecated=1, message="Please use the clone() method.")
    public init(base: TextAttributes) {
        dictionary = base.dictionary
        paragraphStyle = base.paragraphStyle.clone()
        dictionary[NSParagraphStyleAttributeName] = paragraphStyle
    }
    
    /**
     Create an instance of TextAttributes.
     
     - returns: The created TextAttributes.
     */
    public init() {
        dictionary[NSParagraphStyleAttributeName] = paragraphStyle
    }
    
    /**
     Creates a copy of the receiver.
     
     - returns: A copy of the receiver.
     */
    public func clone() -> TextAttributes {
        let clone = TextAttributes()
        clone.dictionary = dictionary
        clone.paragraphStyle = paragraphStyle.clone()
        return clone
    }
    
    // MARK: - Font
    
    /// The font attribute.
    public var font: UIFont? = UIFont(name: "HelveticaNeue", size: 12) {
        didSet {
            dictionary[NSFontAttributeName] = font
        }
    }
    
    /**
     Sets the font attribute and returns the receiver.
     
     - parameter name: The fully specified name of the font.
     - parameter size: The size (in points) to which the font is scaled.
     
     - returns: The receiver.
     */
    public func font(name name: String, size: CGFloat) -> Self {
        return font(UIFont(name: name, size: size))
    }
    
    /**
     Sets the font attribute and returns the receiver.
     
     - parameter font: The font.
     
     - returns: The receiver.
     */
    public func font(font: UIFont?) -> Self {
        self.font = font
        return self
    }
    
    // MARK: - Ligature
    
    /// The ligature attribute.
    public var ligature: LigatureStyle = .Default {
        didSet {
            dictionary[NSLigatureAttributeName] = NSNumber(integer: ligature.hashValue)
        }
    }
    
    /**
     Sets the ligature attribute and returns the receiver.
     
     - parameter style: The ligature style.
     
     - returns: The receiver.
     */
    public func ligature(style: LigatureStyle) -> Self {
        self.ligature = style
        return self
    }
    
    // MARK: - Kern
    
    /// The number of points by which to adjust kern-pair characters.
    public var kern: CGFloat = 0 {
        didSet {
            dictionary[NSKernAttributeName] = kern as NSNumber
        }
    }
    
    /**
     Sets the number of points by which to adjust kern-pair characters and returns the receiver.
     
     - parameter value: The number of points by which to adjust kern-pair characters.
     
     - returns: The receiver.
     */
    public func kern(value: CGFloat) -> Self {
        self.kern = value
        return self
    }
    
    // MARK: - Striketrough style
    
    /// The strikethrough style attribute.
    public var strikethroughStyle: NSUnderlineStyle = .StyleNone {
        didSet {
            dictionary[NSStrikethroughStyleAttributeName] = NSNumber(integer: strikethroughStyle.rawValue)
        }
    }
    
    /**
     Sets the strikethrough style attribute and returns the receiver.
     
     - parameter style: The strikethrough style.
     
     - returns: The receiver.
     */
    public func strikethroughStyle(style: NSUnderlineStyle) -> Self {
        self.strikethroughStyle = style
        return self
    }
    
    // MARK: - Strikethrough color
    
    /// The strikethrough color attribute.
    var strikethroughColor: UIColor? = nil {
        didSet {
            dictionary[NSStrikethroughColorAttributeName] = strikethroughColor
        }
    }
    
    /**
     Sets the strikethrough color attribute and returns the receiver.
     
     - parameter white: The grayscale value of the color object.
     - parameter alpha: The opacity value of the color object.
     
     - returns: The receiver.
     */
    public func strikethroughColor(white white: CGFloat, alpha: CGFloat) -> Self {
        return strikethroughColor(UIColor(white: white, alpha: alpha))
    }
    
    /**
     Sets the strikethrough color attribute and returns the receiver.
     
     - parameter hue:        The hue component of the color object.
     - parameter saturation: The saturation component of the color object.
     - parameter brightness: The brightness component of the color object.
     - parameter alpha:      The opacity value of the color object.
     
     - returns: The receiver.
     */
    public func strikethroughColor(hue hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) -> Self {
        return strikethroughColor(UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha))
    }
    
    /**
     Sets the strikethrough color attribute and returns the receiver.
     
     - parameter red:   The red component of the color object.
     - parameter green: The green component of the color object.
     - parameter blue:  The blue component of the color object.
     - parameter alpha: The opacity value of the color object.
     
     - returns: The receiver.
     */
    public func strikethroughColor(red red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> Self {
        return strikethroughColor(UIColor(red: red, green: green, blue: blue, alpha: alpha))
    }
    
    /**
     Sets the strikethrough color attribute and returns the receiver.
     
     - parameter image: The image to use when creating the pattern color.
     
     - returns: The receiver.
     */
    public func strikethroughColor(patternImage image: UIImage) -> Self {
        return strikethroughColor(UIColor(patternImage: image))
    }
    
    /**
     Sets the strikethrough color attribute and returns the receiver.
     
     - parameter color: The color.
     
     - returns: The receiver.
     */
    public func strikethroughColor(color: UIColor?) -> Self {
        self.strikethroughColor = color
        return self
    }
    
    // MARK: - Underline style
    
    /// The underline style attribute.
    public var underlineStyle: NSUnderlineStyle = .StyleNone {
        didSet {
            dictionary[NSUnderlineStyleAttributeName] = NSNumber(integer: underlineStyle.rawValue)
        }
    }
    
    /**
     Sets the underline style attribute and returns the receiver.
     
     - parameter style: The underline style.
     
     - returns: The receiver.
     */
    public func underlineStyle(style: NSUnderlineStyle) -> Self {
        self.underlineStyle = style
        return self
    }
    
    // MARK: - Underline color
    
    /// The underline color attribute.
    public var underlineColor: UIColor? = nil {
        didSet {
            dictionary[NSUnderlineColorAttributeName] = underlineColor
        }
    }
    
    /**
     Sets the underline color attribute and returns the receiver.
     
     - parameter white: The grayscale value of the color object.
     - parameter alpha: The opacity value of the color object.
     
     - returns: The receiver.
     */
    public func underlineColor(white white: CGFloat, alpha: CGFloat) -> Self {
        return underlineColor(UIColor(white: white, alpha: alpha))
    }
    
    /**
     Sets the underline color attribute and returns the receiver.
     
     - parameter hue:        The hue component of the color object.
     - parameter saturation: The saturation component of the color object.
     - parameter brightness: The brightness component of the color object.
     - parameter alpha:      The opacity value of the color object.
     
     - returns: The receiver.
     */
    public func underlineColor(hue hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) -> Self {
        return underlineColor(UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha))
    }
    
    /**
     Sets the underline color attribute and returns the receiver.
     
     - parameter red:   The red component of the color object.
     - parameter green: The green component of the color object.
     - parameter blue:  The blue component of the color object.
     - parameter alpha: The opacity value of the color object.
     
     - returns: The receiver.
     */
    public func underlineColor(red red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> Self {
        return underlineColor(UIColor(red: red, green: green, blue: blue, alpha: alpha))
    }
    
    /**
     Sets the underline color attribute and returns the receiver.
     
     - parameter image: The image to use when creating the pattern color.
     
     - returns: The receiver.
     */
    public func underlineColor(patternImage image: UIImage) -> Self {
        return underlineColor(UIColor(patternImage: image))
    }
    
    /**
     Sets the underline color attribute and returns the receiver.
     
     - parameter color: The color.
     
     - returns: The receiver.
     */
    public func underlineColor(color: UIColor?) -> Self {
        self.underlineColor = color
        return self
    }
    
    // MARK: - Stroke color
    
    /// The stroke color attribute.
    public var strokeColor: UIColor? = nil {
        didSet {
            dictionary[NSStrokeColorAttributeName] = strokeColor
        }
    }
    
    /**
     Sets the stroke color attribute and returns the receiver.
     
     - parameter white: The grayscale value of the color object.
     - parameter alpha: The opacity value of the color object.
     
     - returns: The receiver.
     */
    public func strokeColor(white white: CGFloat, alpha: CGFloat) -> Self {
        return strokeColor(UIColor(white: white, alpha: alpha))
    }
    
    /**
     Sets the stroke color attribute and returns the receiver.
     
     - parameter hue:        The hue component of the color object.
     - parameter saturation: The saturation component of the color object.
     - parameter brightness: The brightness component of the color object.
     - parameter alpha:      The opacity value of the color object.
     
     - returns: The receiver.
     */
    public func strokeColor(hue hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) -> Self {
        return strokeColor(UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha))
    }
    
    /**
     Sets the stroke color attribute and returns the receiver.
     
     - parameter red:   The red component of the color object.
     - parameter green: The green component of the color object.
     - parameter blue:  The blue component of the color object.
     - parameter alpha: The opacity value of the color object.
     
     - returns: The receiver.
     */
    public func strokeColor(red red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> Self {
        return strokeColor(UIColor(red: red, green: green, blue: blue, alpha: alpha))
    }
    
    /**
     Sets the stroke color attribute and returns the receiver.
     
     - parameter image: The image to use when creating the pattern color.
     
     - returns: The receiver.
     */
    public func strokeColor(patternImage image: UIImage) -> Self {
        return strokeColor(UIColor(patternImage: image))
    }
    
    /**
     Sets the underline color attribute and returns the receiver.
     
     - parameter color: The color.
     
     - returns: The receiver.
     */
    public func strokeColor(color: UIColor?) -> Self {
        self.strokeColor = color
        return self
    }
    
    // MARK: - Stroke width
    
    /// The stroke width attribute.
    public var strokeWidth: CGFloat = 0 {
        didSet {
            dictionary[NSStrokeWidthAttributeName] = strokeWidth as NSNumber
        }
    }
    
    /**
     Sets the stroke width attribute and returns the receiver.
     
     - parameter width: The stroke width.
     
     - returns: The receiver.
     */
    public func strokeWidth(width: CGFloat) -> Self {
        self.strokeWidth = width
        return self
    }
    
    // MARK: - Foreground color
    
    /// The foreground color attribute.
    public var foregroundColor: UIColor? {
        didSet {
            dictionary[NSForegroundColorAttributeName] = foregroundColor
        }
    }
    
    /**
     Sets the foreground color attribute and returns the receiver.
     
     - parameter white: The grayscale value of the color object.
     - parameter alpha: The opacity value of the color object.
     
     - returns: The receiver.
     */
    public func foregroundColor(white white: CGFloat, alpha: CGFloat) -> Self {
        return foregroundColor(UIColor(white: white, alpha: alpha))
    }
    
    /**
     Sets the foreground color attribute and returns the receiver.
     
     - parameter hue:        The hue component of the color object.
     - parameter saturation: The saturation component of the color object.
     - parameter brightness: The brightness component of the color object.
     - parameter alpha:      The opacity value of the color object.
     
     - returns: The receiver.
     */
    public func foregroundColor(hue hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) -> Self {
        return foregroundColor(UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha))
    }
    
    /**
     Sets the foreground color attribute and returns the receiver.
     
     - parameter red:   The red component of the color object.
     - parameter green: The green component of the color object.
     - parameter blue:  The blue component of the color object.
     - parameter alpha: The opacity value of the color object.
     
     - returns: The receiver.
     */
    public func foregroundColor(red red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> Self {
        return foregroundColor(UIColor(red: red, green: green, blue: blue, alpha: alpha))
    }
    
    /**
     Sets the foreground color attribute and returns the receiver.
     
     - parameter image: The image to use when creating the pattern color.
     
     - returns: The receiver.
     */
    public func foregroundColor(patternImage image: UIImage) -> Self {
        return foregroundColor(UIColor(patternImage: image))
    }
    
    /**
     Sets the foreground color attribute and returns the receiver.
     
     - parameter color: The color.
     
     - returns: The receiver.
     */
    public func foregroundColor(color: UIColor?) -> Self {
        self.foregroundColor = color
        return self
    }
    
    // MARK: - Shadow
    
    /// The shadow attribute.
    public var shadow: NSShadow? = nil {
        didSet {
            dictionary[NSShadowAttributeName] = shadow
        }
    }
    
    /**
     Sets the shadow attribute and returns the receiver.
     
     - parameter color:      The color of the shadow.
     - parameter offset:     The offset values of the shadow.
     - parameter blurRadius: The blur radius of the shadow.
     
     - returns: The receiver.
     */
    public func shadow(color color: AnyObject?, offset: CGSize, blurRadius: CGFloat) -> Self {
        return shadow({
            let shadow = NSShadow()
            shadow.shadowColor = color
            shadow.shadowOffset = offset
            shadow.shadowBlurRadius = blurRadius
            return shadow
        }() as NSShadow)
    }
    
    /**
     Sets the shadow attribute and returns the receiver.
     
     - parameter shadow: The shadow.
     
     - returns: The receiver.
     */
    public func shadow(shadow: NSShadow?) -> Self {
        self.shadow = shadow
        return self
    }
    
    // MARK: - TextEffect
    
    /// The text effect attribute.
    public var textEffect: TextEffect? = nil {
        didSet {
            if let name = textEffect?.name {
                dictionary[NSTextEffectAttributeName] = NSString(string: name)
            } else {
                dictionary[NSTextEffectAttributeName] = nil
            }
        }
    }
    
    /**
     Sets the text effect attribute and returns the receiver.
     
     - parameter style: The text effect.
     
     - returns: The receiver.
     */
    public func textEffect(style: TextEffect?) -> Self {
        self.textEffect = style
        return self
    }
    
    // MARK: - Attachment
    
    /// The attachment attribute.
    public var attachment: NSTextAttachment? = nil {
        didSet {
            dictionary[NSAttachmentAttributeName] = attachment
        }
    }
    
    /**
     Sets the attachment attribute and returns the receiver.
     
     - parameter attachment: The text attachment.
     
     - returns: The receiver.
     */
    public func attachment(attachment: NSTextAttachment?) -> Self {
        self.attachment = attachment
        return self
    }
    
    // MARK: - Link
    
    /// The link attribute.
    public var link: NSURL? = nil {
        didSet {
            dictionary[NSLinkAttributeName] = link
        }
    }
    
    /**
     Sets the link attribute and returns the receiver.
     
     - parameter string: The URL string with which to initialize the NSURL object.
     
     - returns: The receiver.
     */
    public func link(string string: String) -> Self {
        return link(NSURL(string: string))
    }
    
    /**
     Sets the link attribute and returns the receiver.
     
     - parameter string:  The URL string with which to initialize the NSURL object.
     - parameter baseURL: The base URL for the NSURL object.
     
     - returns: The receiver.
     */
    public func link(string string: String, relativeToURL baseURL: NSURL?) -> Self {
        return link(NSURL(string: string, relativeToURL: baseURL))
    }
    
    /**
     Sets the link attribute and returns the receiver.
     
     - parameter URL: The URL.
     
     - returns: The receiver.
     */
    public func link(URL: NSURL?) -> Self {
        self.link = URL
        return self
    }
    
    // MARK: - Baseline offset
    
    /// The baseline offset attribute.
    public var baselineOffset: CGFloat = 0 {
        didSet {
            dictionary[NSBaselineOffsetAttributeName] = baselineOffset as NSNumber
        }
    }
    
    /**
     Sets the baseline offset attribute and return the receiver.
     
     - parameter value: The baseline offset.
     
     - returns: The receiver.
     */
    public func baselineOffset(value: CGFloat) -> Self {
        self.baselineOffset = value
        return self
    }
    
    // MARK: - Obliqueness
    
    /// The oliqueness attribute.
    public var obliqueness: CGFloat = 0 {
        didSet {
            dictionary[NSObliquenessAttributeName] = obliqueness as NSNumber
        }
    }
    
    /**
     Sets the obliqueness attribute and returns the receiver.
     
     - parameter value: The obliqueness.
     
     - returns: The receiver.
     */
    public func obliqueness(value: CGFloat) -> Self {
        self.obliqueness = value
        return self
    }
    
    // MARK: - Expansion
    
    /// The expansion attribute.
    public var expansion: CGFloat = 0 {
        didSet {
            dictionary[NSExpansionAttributeName] = expansion as NSNumber
        }
    }
    
    /**
     Sets the expansion attribute and returns the receiver.
     
     - parameter value: The expansion attribute.
     
     - returns: The receiver.
     */
    public func expansion(value: CGFloat) -> Self {
        self.expansion = value
        return self
    }
    
    // MARK: - Vertical glyph form
    
    /// The vertical glyph form attribute.
    public var verticalGlyphForm: VerticalGlyphForm = .Horizontal {
        didSet {
            dictionary[NSVerticalGlyphFormAttributeName] = NSNumber(integer: verticalGlyphForm.hashValue)
        }
    }
    
    /**
     Sets the vertical glyph form attribute and returns the receiver.
     
     - parameter value: The vertical glyph form.
     
     - returns: The receiver.
     */
    public func verticalGlyphForm(value: VerticalGlyphForm) -> Self {
        self.verticalGlyphForm = value
        return self
    }
    
    // MARK: - Background color
    
    /// The background color attribute.
    var backgroundColor: UIColor? {
        didSet {
            dictionary[NSBackgroundColorAttributeName] = backgroundColor
        }
    }
    
    /**
     Sets the background color attribute and returns the receiver.
     
     - parameter white: The grayscale value of the color object.
     - parameter alpha: The opacity value of the color object.
     
     - returns: The receiver.
     */
    public func backgroundColor(white white: CGFloat, alpha: CGFloat) -> Self {
        return backgroundColor(UIColor(white: white, alpha: alpha))
    }
    
    /**
     Sets the background color attribute and returns the receiver.
     
     - parameter hue:        The hue component of the color object.
     - parameter saturation: The saturation component of the color object.
     - parameter brightness: The brightness component of the color object.
     - parameter alpha:      The opacity value of the color object.
     
     - returns: The receiver.
     */
    public func backgroundColor(hue hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) -> Self {
        return backgroundColor(UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha))
    }
    
    /**
     Sets the background color attribute and returns the receiver.
     
     - parameter red:   The red component of the color object.
     - parameter green: The green component of the color object.
     - parameter blue:  The blue component of the color object.
     - parameter alpha: The opacity value of the color object.
     
     - returns: The receiver.
     */
    public func backgroundColor(red red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> Self {
        return backgroundColor(UIColor(red: red, green: green, blue: blue, alpha: alpha))
    }
    
    /**
     Sets the background color attribute and returns the receiver.
     
     - parameter image: The image to use when creating the pattern color.
     
     - returns: The receiver.
     */
    public func backgroundColor(patternImage image: UIImage) -> Self {
        return backgroundColor(UIColor(patternImage: image))
    }
    
    /**
     Sets the background color attribute and returns the receiver.
     
     - parameter color: The color.
     
     - returns: The receiver.
     */
    public func backgroundColor(color: UIColor?) -> Self {
        self.backgroundColor = color
        return self
    }
    
    // MARK: - Paragraph style
    
    /// The paragraph style attribute.
    public var paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle() {
        didSet {
            dictionary[NSParagraphStyleAttributeName] = paragraphStyle
        }
    }
    
    /**
     Sets the paragraph style attribute and returns the receiver.
     
     - parameter style: The paragraph style.
     
     - returns: The receiver.
     */
    public func paragraphStyle(style: NSMutableParagraphStyle) -> Self {
        self.paragraphStyle = style
        return self
    }
    
    // MARK: - Alignment
    
    /// The text alignment of the paragraph style.
    public var alignment: NSTextAlignment {
        get { return paragraphStyle.alignment }
        set { paragraphStyle.alignment = newValue }
    }
    
    /**
     Sets the text alignment of the paragraph style and returns the receiver.
     
     - parameter alignment: The text alignment.
     
     - returns: The receiver.
     */
    public func alignment(alignment: NSTextAlignment) -> Self {
        self.alignment = alignment
        return self
    }
    
    // MARK: - First line head indent
    
    /// The indentation of the first line of the paragraph style.
    public var firstLineHeadIndent: CGFloat {
        get { return paragraphStyle.firstLineHeadIndent }
        set { paragraphStyle.firstLineHeadIndent = newValue }
    }
    
    /**
     Sets the indentation of the first line of the paragraph style and returns the receiver.
     
     - parameter value: The indentation.
     
     - returns: The receiver.
     */
    public func firstLineHeadIndent(value: CGFloat) -> Self {
        self.firstLineHeadIndent = value
        return self
    }
    
    // MARK: - Head indent
    
    /// The indentation of the paragraph style lines other than the first.
    public var headIndent: CGFloat {
        get { return paragraphStyle.headIndent }
        set { paragraphStyle.headIndent = newValue }
    }
    
    /**
     Sets the indentation of the paragraph style lines other than the first and returns the receiver.
     
     - parameter value: The indentation of the lines other than the first.
     
     - returns: The receiver.
     */
    public func headIndent(value: CGFloat) -> Self {
        self.headIndent = value
        return self
    }
    
    // MARK: - Tail indent
    
    /// The trailing indentation of the paragraph style.
    public var tailIndent: CGFloat {
        get { return paragraphStyle.tailIndent }
        set { paragraphStyle.tailIndent = newValue }
    }
    
    /**
     Sets the trailing indentation of the paragraph style and returns the receiver.
     
     - parameter value: The trailing indentation.
     
     - returns: The receiver.
     */
    public func tailIndent(value: CGFloat) -> Self {
        self.tailIndent = value
        return self
    }
    
    // MARK: - Line height multiple
    
    /// The line height multiple of the paragraph style.
    public var lineHeightMultiple: CGFloat {
        get { return paragraphStyle.lineHeightMultiple }
        set { paragraphStyle.lineHeightMultiple = newValue }
    }
    
    /**
     Sets the line height multiple of the paragraph style and returns the receiver.
     
     - parameter value: The line height multiple.
     
     - returns: The receiver.
     */
    public func lineHeightMultiple(value: CGFloat) -> Self {
        self.lineHeightMultiple = value
        return self
    }
    
    // MARK: - Maximum line height
    
    /// The maximum line height of the paragraph style.
    public var maximumLineHeight: CGFloat {
        get { return paragraphStyle.maximumLineHeight }
        set { paragraphStyle.maximumLineHeight = newValue }
    }
    
    /**
     Sets the maximum line height of the paragraph style and returns the receiver.
     
     - parameter value: The maximum line height.
     
     - returns: The receiver.
     */
    public func maximumLineHeight(value: CGFloat) -> Self {
        self.maximumLineHeight = value
        return self
    }
    
    // MARK: - Minimum line height
    
    /// The minimum line height of the paragraph style.
    public var minimumLineHeight: CGFloat {
        get { return paragraphStyle.minimumLineHeight }
        set { paragraphStyle.minimumLineHeight = newValue }
    }
    
    /**
     Sets the minimum line height of the paragraph style and returns the receiver.
     
     - parameter value: The minimum line height.
     
     - returns: The receiver.
     */
    public func minimumLineHeight(value: CGFloat) -> Self {
        self.minimumLineHeight = value
        return self
    }
    
    // MARK: - Line spacing
    
    /// The line spacing of the paragraph style.
    public var lineSpacing: CGFloat {
        get { return paragraphStyle.lineSpacing }
        set { paragraphStyle.lineSpacing = newValue }
    }
    
    /**
     Sets the line spacing of the paragraph style and returns the receiver.
     
     - parameter value: The line spacing.
     
     - returns: The receiver.
     */
    public func lineSpacing(value: CGFloat) -> Self {
        self.lineSpacing = value
        return self
    }
    
    // MARK: - Paragraph spacing
    
    /// The paragraph spacing of the paragraph style.
    public var paragraphSpacing: CGFloat {
        get { return paragraphStyle.paragraphSpacing }
        set { paragraphStyle.paragraphSpacing = newValue }
    }
    
    /**
     Sets the paragraph spacing of the paragraph style and returns the receiver.
     
     - parameter value: The paragraph spacing.
     
     - returns: The receiver.
     */
    public func paragraphSpacing(value: CGFloat) -> Self {
        self.paragraphSpacing = value
        return self
    }
    
    // MARK: - Paragraph spacing before
    
    /// The distance between the paragraph's top and the beginning of its text content.
    public var paragraphSpacingBefore: CGFloat {
        get { return paragraphStyle.paragraphSpacingBefore }
        set { paragraphStyle.paragraphSpacingBefore = newValue }
    }
    
    /**
     Sets the distance between the paragraph's top and the beginning of its text content and returns the receiver.
     
     - parameter value: The distance between the paragraph's top and the beginning of its text content.
     
     - returns: The receiver.
     */
    public func paragraphSpacingBefore(value: CGFloat) -> Self {
        self.paragraphSpacingBefore = value
        return self
    }
}