<p align="center">
  <img src="https://raw.githubusercontent.com/delba/TextAttributes/assets/TextAttributes@2x.png">
</p>

<p align="center">
  <a href="https://travis-ci.org/delba/TextAttributes"><img alt="Travis Status" src="https://img.shields.io/travis/delba/TextAttributes.svg"/></a>
  <a href="https://img.shields.io/cocoapods/v/TextAttributes.svg"><img alt="CocoaPods compatible" src="https://img.shields.io/cocoapods/v/TextAttributes.svg"/></a>
  <a href="https://github.com/Carthage/Carthage"><img alt="Carthage compatible" src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat"/></a>
  <a href="https://img.shields.io/cocoapods/p/TextAttributes.svg"><img alt="Platform" src="https://img.shields.io/cocoapods/p/TextAttributes.svg"/></a>
</p>

**TextAttributes** makes it easy to compose attributed strings.

```swift
let attrs = TextAttributes()
    .font(name: "HelveticaNeue", size: 16)
    .foregroundColor(white: 0.2, alpha: 1)
    .lineHeightMultiple(1.5)

NSAttributedString("The quick brown fox jumps over the lazy dog", attributes: attrs)
```

<p align="center">
    <a href="#features">Features</a> • <a href="#usage">Usage</a> • <a href="#demo">Demo</a> • <a href="#references">References</a> • <a href="#installation">Installation</a> • <a href="#license">License</a>
</p>

## Features

- [x] Strongly typed properties
- [x] Chainable setter methods
- [x] A direct access to the `NSParagraphStyle` properties
- [x] Better autocompletion

## Usage

- **Get or set the `TextAttributes` properties:**

```swift
attrs.font = UIFont(name: "HelveticaNeue", size: 16)
attrs.backgroundColor = .white
```

> See [all the properties](#references)

- **Method chaining:**

The `TextAttributes` methods return `Self` to allow method chaining:

```swift
attrs
    .lineHeightMultiple(1.5)
    .underlineStyle(.styleSingle)
```

> See [all the methods](#references)

- **The methods are also constructors:**

The following are equivalent:

```swift
attrs
    .font(name: "HelveticaNeue", size: 16)
    .foregroundColor(white: 0.2, alpha: 1)
```

```swift
let font  = UIFont(name: "HelveticaNeue", size: 16)
let color = UIColor(white: 0.2, alpha: 1)

attrs
    .font(font)
    .foregroundColor(color)
```

- **Access the underlying dictionary:**

```swift
attrs.dictionary // Returns the attributes dictionary of type [String: AnyObject]
```

#### Third-party libraries:

- [muukii/**TextAttributesUtil**](https://github.com/muukii/TextAttributesUtil) Quickly create NSAttributedString with TextAttributes

## Demo

<p align="center">
  <img src="https://raw.githubusercontent.com/delba/TextAttributes/assets/demo.gif" />
  <em>Live updates with <a href="https://github.com/johnno1962/injectionforxcode" alt="Injection for Xcode">Injection for Xcode</a></em>
</p>

## References

### Attributes dictionary

| Dictionary Key                      | `TextAttributes` Property | `TextAttributes` Method                                |
| ----------------------------------- | ------------------------- | ------------------------------------------------------ |
| `NSFontAttributeName`               | `font`                    | `font(name:size:)`                                     |
|                                     |                           | `font(_:)`                                             |
| `NSParagraphStyleAttributeName`     | `paragraphStyle`          | `paragraphStyle(_:)`                                   |
| `NSForegroundColorAttributeName`    | `foregroundColor`         | `foregroundColor(_:)`                                  |
|                                     |                           |  `foregroundColor(white:alpha:)`                       |
|                                     |                           | `foregroundColor(hue:saturation:brightness:alpha:)`    |
|                                     |                           | `foregroundColor(red:green:blue:alpha:)`               |
|                                     |                           | `foregroundColor(patternImage:)`                       |
| `NSBackgroundColorAttributeName`    | `backgroundColor`         | `backgroundColor(_:)`                                  |
|                                     |                           | `backgroundColor(white:alpha:)`                        |
|                                     |                           | `backgroundColor(hue:saturation:brightness:alpha:)`    |
|                                     |                           | `backgroundColor(red:green:blue:alpha:)`               |
|                                     |                           | `backgroundColor(patternImage:)`                       |
| `NSLigatureAttributeName`           | `ligature`                | `ligature(_:)`                                         |
| `NSKernAttributeName`               | `kern`                    | `kern(_:)`                                             |
| `NSStrikethroughStyleAttributeName` | `strikethroughStyle`      | `strikethroughStyle(_:)`                               |
| `NSStrikethroughColorAttributeName` | `strikethroughColor`      | `strikethroughColor(_:)`                               |
|                                     |                           | `strikethroughColor(white:alpha:)`                     |
|                                     |                           | `strikethroughColor(hue:saturation:brightness:alpha:)` |
|                                     |                           | `strikethroughColor(red:green:blue:alpha:)`            |
|                                     |                           | `strikethroughColor(patternImage:)`                    |
| `NSUnderlineStyleAttributeName`     | `underlineStyle`          | `underlineStyle(_:)`                                   |
| `NSUnderlineColorAttributeName`     | `underlineColor`          | `underlineColor(_:)`                                   |
|                                     |                           | `underlineColor(white:alpha:)`                         |
|                                     |                           | `underlineColor(hue:saturation:brightness:alpha:)`     |
|                                     |                           | `underlineColor(red:green:blue:alpha:)`                |
|                                     |                           | `underlineColor(patternImage:)`                        |
| `NSStrokeWidthAttributeName`        | `strokeWidth`             | `strokeWidth(_:)`                                      |
| `NSStrokeColorAttributeName`        | `strokeColor`             | `strokeColor(_:)`                                      |
|                                     |                           | `strokeColor(white:alpha:)`                            |
|                                     |                           | `strokeColor(hue:saturation:brightness:alpha:)`        |
|                                     |                           | `strokeColor(red:green:blue:alpha:)`                   |
|                                     |                           | `strokeColor(patternImage:)`                           |
| `NSShadowAttributeName`             | `shadow`                  | `shadow(_:)`                                           |
|                                     |                           | `shadow(color:offset:blurRadius:)`                     |
| `NSTextEffectAttributeName`         | `textEffect`              | `textEffect(_:)`                                       |
| `NSAttachmentAttributeName`         | `attachment`              | `attachment(_:)`                                       |
| `NSLinkAttributeName`               | `link`                    | `link(_:)`                                             |
|                                     |                           | `link(string:)`                                        |
|                                     |                           | `link(string:relativeToURL:)`                          |
| `NSBaselineOffsetAttributeName`     | `baselineOffset`          | `baselineOffset(_:)`                                   |
| `NSObliquenessAttributeName`        | `obliqueness`             | `obliqueness(_:)`                                      |
| `NSExpansionAttributeName`          | `expansion`               | `expansion(_:)`                                        |
| `NSVerticalGlyphFormAttributeName`  | `verticalGlyphForm`       | `verticalGlyphForm(_:)`                                |

### Paragraph style

| `NSMutableParagraphStyle` Property | `TextAttributes` Property | `TextAttributes` Method      |
| ---------------------------------- | ------------------------- | ---------------------------- |
| `alignment`                        | `alignment`               | `alignment(_:)`              |
| `firstLineHeadIndent`              | `firstLineHeadIndent`     | `firstLineHeadIndent(_:)`    |
| `headIndent`                       | `headIndent`              | `headIndent(_:)`             |
| `tailIndent`                       | `tailIndent`              | `tailIndent(_:)`             |
| `lineBreakMode`                    | `lineBreakMode`           | `lineBreakMode(_:)`          |
| `maximumLineHeight`                | `maximumLineHeight`       | `maximumLineHeight(_:)`      |
| `lineSpacing`                      | `lineSpacing`             | `lineSpacing(_:)`            |
| `paragraphSpacing`                 | `paragraphSpacing`        | `paragraphSpacing(_:)`       |
| `paragraphSpacingBefore`           | `paragraphSpacingBefore`  | `paragraphSpacingBefore(_:)` |
| `baseWritingDirection`             | `baseWritingDirection`    | `baseWritingDirection(_:)`   |
| `lineHeightMultiple`               | `lineHeightMultiple`      | `lineHeightMultiple(_:)`     |

## Installation

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that automates the process of adding frameworks to your Cocoa application.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate TextAttributes into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "delba/TextAttributes"
```

### Cocoapods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate TextAttributes into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
use_frameworks!

pod 'TextAttributes'
```

## License

Copyright (c) 2016 Damien (http://delba.io)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
