//
//  ShowWithFadeAnimationSegue.swift
//  dooit
//
//  Created by Ricardo Gehrke Filho on 13/07/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit

class ShowWithFadeAnimationSegue: UIStoryboardSegue, UIViewControllerTransitioningDelegate {
    
    override func perform() {
        destinationViewController.transitioningDelegate = self
        sourceViewController.presentViewController(destinationViewController, animated: true, completion: nil)
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadePresentationAnimationController(isPresenting: true)
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadePresentationAnimationController(isPresenting: false)
    }
    
}
