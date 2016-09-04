//
//  BlackTransparentNavigationController.swift
//  
//
//  Created by Huamán Torres, Carlo Renzo on 24/08/16.
//  Copyright © 2016 Grupo RPP. All rights reserved.
//

import UIKit

class BlackTransparentNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationBar.setBackgroundImage(UIImage.fromColor(.backgroundBlack()), forBarMetrics: .Default)
//        navigationBar.translucent = true
//
//        UINavigationBar.appearance().barTintColor = UIColor.backgroundBlack()
//        view.backgroundColor = UIColor.clearColor()
//    
//        navigationBar.tintColor = UIColor.whiteColor()
//        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Avenir-Light", size: 15.0)!]
//        
//        self.navigationBar.shadowImage = UIImage()

        self.interactivePopGestureRecognizer!.enabled = false
    }
    
    override func childViewControllerForStatusBarStyle() -> UIViewController? {
        return topViewController
    }
}

extension UIImage {
    static func fromColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}
