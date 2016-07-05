//
//  RoundedButton.swift
//  dooit
//
//  Created by Ricardo Gehrke Filho on 30/06/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        backgroundColor = UIColor.blueColor()
        layer.masksToBounds = true
        layer.cornerRadius = 4.0
    }
}
