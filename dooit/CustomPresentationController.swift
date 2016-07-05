//
//  Created by Pete Callaway on 26/06/2014.
//  Copyright (c) 2014 Dative Studios. All rights reserved.
//

import UIKit

class CustomPresentationController: UIPresentationController {
    
    lazy var dimmingView: UIView = {
        let effect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let view = UIVisualEffectView(effect: effect)
        view.alpha = 0.0
        return view
    }()

    override func presentationTransitionWillBegin() {
        dimmingView.frame = containerView!.bounds
        containerView!.addSubview(dimmingView)
        
        let pv = presentedView()
        pv?.layer.masksToBounds = true
        pv?.layer.cornerRadius = 6.0

        if let transitionCoordinator = self.presentingViewController.transitionCoordinator() {
            transitionCoordinator.animateAlongsideTransition({(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
                self.dimmingView.alpha = 1.0
            }, completion:nil)
        }
    }

    override func presentationTransitionDidEnd(completed: Bool)  {
        if !completed {
            self.dimmingView.removeFromSuperview()
        }
    }

    override func dismissalTransitionWillBegin()  {
        if let transitionCoordinator = self.presentingViewController.transitionCoordinator() {
            transitionCoordinator.animateAlongsideTransition({(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
                self.dimmingView.alpha  = 0.0
            }, completion:nil)
        }
    }

    override func dismissalTransitionDidEnd(completed: Bool) {
        if completed {
            self.dimmingView.removeFromSuperview()
        }
    }

    override func frameOfPresentedViewInContainerView() -> CGRect {
        var frame = containerView!.bounds
        frame = CGRectInset(frame, 20.0, 100.0)
        frame.size = CGSize(width: frame.width, height: 110.0)
        return frame
    }


    // ---- UIContentContainer protocol methods

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator transitionCoordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: transitionCoordinator)

        transitionCoordinator.animateAlongsideTransition({(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
            self.dimmingView.frame = self.containerView!.bounds
        }, completion:nil)
    }
}
