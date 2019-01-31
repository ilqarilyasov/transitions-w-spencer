//
//  ViewController.swift
//  Transitions
//
//  Created by Ilgar Ilyasov on 1/31/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ViewController: LabelProvidingVC, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var label: UILabel!
    
    // MARK: - Super class lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return animator
    }
    
    let animator = Animator()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.transitioningDelegate = self
    }
}

