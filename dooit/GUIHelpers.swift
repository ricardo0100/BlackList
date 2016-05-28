//
//  GUIHelpers.swift
//  dooit
//
//  Created by Ricardo Gehrke Filho on 28/05/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation
import UIKit

class GUIHelpers {
    static func setUpTitle() -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "dooit")
        let color = UIColor.whiteColor()
        let blackFont = UIFont(name: "Avenir-Black", size: 20)!
        let attributeBlack = [NSForegroundColorAttributeName: color, NSFontAttributeName: blackFont]
        attributedText.addAttributes(attributeBlack, range: NSRange(location: 0, length: 3))
        let blackLight = UIFont(name: "Avenir-Light", size: 24)!
        let attributeLight = [NSForegroundColorAttributeName: color, NSFontAttributeName: blackLight]
        attributedText.addAttributes(attributeLight, range: NSRange(location: 3, length: 2))
        return attributedText
    }
}