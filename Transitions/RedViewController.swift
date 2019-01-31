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
    
    @IBAction func pan(_ sender: Any) {
        
    }
    
    // MARK: - Super class lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }
    
    let animator = Animator()
}
