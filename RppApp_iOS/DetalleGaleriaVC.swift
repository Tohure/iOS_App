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
  
    override func viewDidLayoutSubviews() {
        
        print(currentShownEvent.urlBullets.count)
        
        var sdWebImageSource = [InputSource]()
        
        for item in currentShownEvent.urlBullets {
            print(item.foto)
            sdWebImageSource.append(SDWebImageSource(urlString: item.foto)!)
        }
        
        slideshow.backgroundColor = UIColor.redColor()
        slideshow.slideshowInterval = 5.0
        slideshow.pageControlPosition = PageControlPosition.UnderScrollView
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
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().postNotificationName("llamaMiControlador", object: false)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
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