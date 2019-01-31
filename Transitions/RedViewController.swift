//
//  RedViewController.swift
//  Transitions
//
//  Created by Ilgar Ilyasov on 1/31/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class RedViewController: LabelProvidingVC, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var label: UILabel!
    
    @IBAction func dismiss(_ sender: Any) {
        transitioningDelegate = self
        dismiss(animated: true, completion: nil)
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        // Interaction controller is going to control the transition
        return interactionController
    }
    
    @IBAction func pan(_ sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        case .began:
            interactionController = UIPercentDrivenInteractiveTransition()
            dismiss(sender)
        case .changed:
            let translation = sender.translation(in: view)
            let percentage = abs(translation.y / view.bounds.height)
            interactionController?.update(percentage)
        case .ended:
            let velocity = sender.velocity(in: view).y
            
            if velocity > 100 {
                interactionController?.finish()
            } else {
                interactionController?.cancel()
            }
        default:
            break
        }
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }
    
    let animator = Animator()
    private var interactionController: UIPercentDrivenInteractiveTransition?
}
