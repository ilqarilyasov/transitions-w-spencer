//
//  Animator.swift
//  Transitions
//
//  Created by Ilgar Ilyasov on 1/31/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

typealias LabelProvidingVC = LabelProviding & UIViewController

class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? LabelProvidingVC,
            let toVC = transitionContext.viewController(forKey: .to) as? LabelProvidingVC,
            let toView = transitionContext.view(forKey: .to) else { return }
        
        // This is the fake view for deceiving people
        let containerView = transitionContext.containerView
        
        let toViewEndFrame = transitionContext.finalFrame(for: toVC)
        containerView.addSubview(toView)
        toView.frame = toViewEndFrame
        toView.alpha = 0.0 // Hide it
        
        // Get actual labels inside of to/from VC
        let fromLabel = fromVC.label!
        let toLabel = toVC.label!
        
        // Hide real/actual labels
        fromLabel.alpha = 0.0
        toLabel.alpha = 0.0
        
        // Converting labels bounds related to itself to a frame related to containerView
        let transitionLabelInitialFrame = containerView.convert(fromLabel.bounds, from: fromLabel)
        let transitioningLabel = UILabel(frame: transitionLabelInitialFrame)
        
        // Match look of fake and actual labels
        transitioningLabel.font = fromLabel.font
        transitioningLabel.text = fromLabel.text
        transitioningLabel.textColor = fromLabel.textColor
        
        // Add fake label to our fake view, containerView
        containerView.addSubview(transitioningLabel)
        
        // Perform the animation to move from fromView's position to toViw's position to deceive people.
        let transitionDuration = self.transitionDuration(using: transitionContext)
        
        toView.layoutIfNeeded() // WHY ??
        
        UIView.animate(withDuration: transitionDuration, animations: {
            
            // Fake labels end frame. Convertiong from actual one
            let transitioningLabelEndFrame = containerView.convert(toLabel.bounds, from: toLabel)
            transitioningLabel.frame = transitioningLabelEndFrame
            toView.alpha = 1.0
        }) { (_) in
            // Reset to views to their original state and remove fake label
            fromLabel.alpha = 1.0
            toLabel.alpha = 1.0
            transitioningLabel.removeFromSuperview()
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
