//
//  ReasonTableViewCell.swift
//  dooit
//
//  Created by Ricardo Gehrke Filho on 19/05/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var radioButton: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    let selectedRadioImage = UIImage(named: "ic_radio_button_checked")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
    let unselectedRadioImage = UIImage(named: "ic_radio_button_unchecked")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
    
    var markedTapped: ((Item) -> Void)? = nil
    
    var item: Item? {
        didSet {
            marked = item!.marked
            name.text = item!.title
        }
    }
    
    var marked = false {
        didSet {
            if marked {
                radioButton.image = selectedRadioImage
            } else {
                radioButton.image = unselectedRadioImage
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        radioButton.image = unselectedRadioImage
        radioButton.tintColor = UIColor.whiteColor()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ItemTableViewCell.radioButtonTaped))
        radioButton.addGestureRecognizer(tapGesture)
    }
    
    func radioButtonTaped() {
        markedTapped!(item!)
    }

}
