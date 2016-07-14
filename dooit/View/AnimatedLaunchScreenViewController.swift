//
//  InitialViewController.swift
//  dooit
//
//  Created by Ricardo Gehrke Filho on 11/07/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit

class AnimatedLaunchScreenViewController: UIViewController {
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.label1.transform = CGAffineTransformScale(self.label1.transform, 1, 1)
        UIView.animateWithDuration(0.5, delay: 0.5, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.label1.transform = CGAffineTransformScale(self.label1.transform, 0.5, 0.5)
            self.label1.alpha = 0.0
        }, completion: nil)
        
        self.label2.transform = CGAffineTransformScale(self.label2.transform, 1, 1)
        UIView.animateWithDuration(0.5, delay: 0.7, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.label2.transform = CGAffineTransformScale(self.label2.transform, 0.5, 0.5)
            self.label2.alpha = 0.0
            }, completion: nil)
        
        self.label3.transform = CGAffineTransformScale(self.label3.transform, 1, 1)
        UIView.animateWithDuration(0.5, delay: 0.9, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.label3.transform = CGAffineTransformScale(self.label3.transform, 0.5, 0.5)
            self.label3.alpha = 0.0
            }, completion: nil)
        
        self.label4.transform = CGAffineTransformScale(self.label4.transform, 1, 1)
        UIView.animateWithDuration(0.5, delay: 1.1, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.label4.transform = CGAffineTransformScale(self.label4.transform, 3.5, 3.5)
            self.label4.alpha = 0.0
        }) { (finished) in
            self.performSegueWithIdentifier("Start App", sender: nil)
        }
        
    }
    
    func launchShowListsViewController(timer : NSTimer) {
        performSegueWithIdentifier("Show Lists", sender: nil)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

}
