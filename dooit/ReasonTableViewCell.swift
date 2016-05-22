//
//  ReasonTableViewCell.swift
//  BlackList
//
//  Created by Ricardo Gehrke Filho on 19/05/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit

class ReasonTableViewCell: UITableViewCell {

    @IBOutlet weak var radioButton: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    let selectedRadioImage = UIImage(named: "ic_radio_button_checked")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
    let unselectedRadioImage = UIImage(named: "ic_radio_button_unchecked")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
    
    var reason: Reason?
    
    var addReasonToPersonCallback: ((Reason) -> Void)? = nil
    var removeReasonToPersonCallback: ((Reason) -> Void)? = nil
    
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ReasonTableViewCell.selectReasonClicked))
        radioButton.addGestureRecognizer(tapGesture)
    }
    
    func selectReasonClicked() {
        reasonSelected = !reasonSelected
        if reasonSelected {
            addReasonToPersonCallback!(reason!)
        } else {
            removeReasonToPersonCallback!(reason!)
        }
        
    }

}
