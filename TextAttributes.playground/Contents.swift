//: Playground - noun: a place where people can play with TextAttributes

import Foundation
import UIKit
import TextAttributes

//: Basic Use

let attrs = TextAttributes()
    .font(name: "HelveticaNeue", size: 16)
    .foregroundColor(white: 0.2, alpha: 1)
    .lineHeightMultiple(1.5)

let myString = NSAttributedString(string: "The quick brown fox jumps over the lazy dog", attributes: attrs)


//: Operators

let blueAttributes =  TextAttributes().foregroundColor(.blueColor())
let redAttributes = TextAttributes().foregroundColor(.redColor()).font(UIFont.systemFontOfSize(18))

let blueString: NSAttributedString = ("The quick brown fox jumps over the lazy dog" + blueAttributes)

let redString: NSAttributedString  = "Red Alert! " + redAttributes

let multiColorString = redString + blueString

let moreInformativeString = redString + " Look at the fox."
