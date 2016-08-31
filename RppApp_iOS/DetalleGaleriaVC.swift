//
//  DetalleGaleriaVC.swift
//  RppApp_iOS
//
//  Created by Huamán Torres, Carlo Renzo on 29/08/16.
//  Copyright © 2016 Grupo RPP. All rights reserved.
//

import UIKit
import ImageSlideshow

class DetalleGaleriaVC: UIViewController {
    
   
    @IBOutlet weak var slideshow: ImageSlideshow!
    var slideshowTransitioningDelegate: ZoomAnimatedTransitioningDelegate?
    
    var currentShownEvent : Noticia!
    
    override func viewWillLayoutSubviews() {
        
        var sdWebImageSource = [SDWebImageSource]()
        
        for item in currentShownEvent.urlBullets {
            sdWebImageSource.append(SDWebImageSource(urlString: item.foto)!)
        }
        
        slideshow.backgroundColor = UIColor.whiteColor()
        slideshow.slideshowInterval = 5.0
        slideshow.pageControlPosition = PageControlPosition.InsideScrollView
        slideshow.pageControl.currentPageIndicatorTintColor = UIColor.lightGrayColor();
        slideshow.pageControl.pageIndicatorTintColor = UIColor.blackColor();
        slideshow.contentScaleMode = UIViewContentMode.ScaleAspectFill
        
        slideshow.setImageInputs(sdWebImageSource)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(DetalleGaleriaVC.click))
        slideshow.addGestureRecognizer(recognizer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func viewDidAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().postNotificationName("llamaMiControlador", object: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().postNotificationName("llamaMiControlador", object: false)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func click() {
        let ctr = FullScreenSlideshowViewController()
        ctr.pageSelected = {(page: Int) in
            self.slideshow.setScrollViewPage(page, animated: false)
        }
        
        ctr.initialImageIndex = slideshow.scrollViewPage
        ctr.inputs = slideshow.images
        slideshowTransitioningDelegate = ZoomAnimatedTransitioningDelegate(slideshowView: slideshow, slideshowController: ctr)
        // Uncomment if you want disable the slide-to-dismiss feature on full screen preview
        // self.transitionDelegate?.slideToDismissEnabled = false
        ctr.transitioningDelegate = slideshowTransitioningDelegate
        self.presentViewController(ctr, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
    override func preferredStatusBarStyle() -> UIStatusBarStyle { return .LightContent }
}