//
//  ReasonTableViewCell.swift
//  BlackList
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
    
    var item: Item? {
        didSet {
            reasonSelected = item!.marked
            name.text = item!.name
        }
    }
    
    var reasonSelected = false {
        didSet {
            if reasonSelected {
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ItemTableViewCell.selectReasonClicked))
        radioButton.addGestureRecognizer(tapGesture)
    }
    
    func selectReasonClicked() {
        reasonSelected = !reasonSelected
        //TODO: Persist change
    }

}
