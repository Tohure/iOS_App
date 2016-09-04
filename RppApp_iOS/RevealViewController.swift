//
//  RevealViewController.swift
//  
//
//  Created by Huamán Torres, Carlo Renzo on 24/08/16.
//  Copyright © 2016 Grupo RPP. All rights reserved.
//

import UIKit

class RevealViewController: SWRevealViewController {

    var opacityView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        basicSetup()
    }
    
    func basicSetup() {
        self.delegate = self
        
        opacityView = UIView(frame: UIScreen.mainScreen().bounds)
        //opacityView.backgroundColor = UIColor.quickColorWith(0, green: 0, blue: 0, alpha: 0.45)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SWRevealViewController.revealToggle(_:)))
        opacityView.addGestureRecognizer(tapGesture)
    }
    
    func moveToShowAllContent() {
        revealController(self, animateToPosition: .Left)
    }
}

extension RevealViewController: SWRevealViewControllerDelegate {
    
    func revealController(revealController: SWRevealViewController!, animateToPosition position: FrontViewPosition) {
        
        if position == .Right {
            
            UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseOut, animations: { 
                
                self.opacityView.alpha = 0.0
                self.frontViewController.view.addSubview(self.opacityView)
                self.opacityView.alpha = 1.0
                self.view.addGestureRecognizer(self.panGestureRecognizer())
                }, completion: { (completed) in
                    self.opacityView.alpha = 1.0
            })
        }
        
        else {
            UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseOut, animations: {
                
                self.opacityView.alpha = 0.0
                }, completion: { (completed) in
         
                    self.view.removeGestureRecognizer(self.panGestureRecognizer())
                    self.opacityView.removeFromSuperview()
            })
        }
    }
}
