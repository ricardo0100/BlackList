//
//  ShowAsPopoverSegue.swift
//  dooit
//
//  Created by Ricardo Gehrke Filho on 30/06/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit

class ShowAsPopoverSegue: UIStoryboardSegue, UIViewControllerTransitioningDelegate {
    
    override func perform() {
        destinationViewController.modalPresentationStyle = .Custom
        destinationViewController.transitioningDelegate = self
        sourceViewController.presentViewController(destinationViewController, animated: true, completion: nil)
    }
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return CustomPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
    
//    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return CustomPresentationAnimationController(isPresenting: true)
//    }
//    
//    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return CustomPresentationAnimationController(isPresenting: false)
//    }
    
}
