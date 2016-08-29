//
//  DetalleGaleriaVC.swift
//  RppApp_iOS
//
//  Created by Huamán Torres, Carlo Renzo on 29/08/16.
//  Copyright © 2016 Grupo RPP. All rights reserved.
//

import UIKit
import ImageSlideshow
import SDWebImage

class DetalleGaleriaVC: UIViewController {

    
    @IBOutlet weak var slideshow: ImageSlideshow!
    var slideshowTransitioningDelegate: ZoomAnimatedTransitioningDelegate?
    
    var currentShownEvent : Noticia!
    
    let sdWebImageSource = [SDWebImage(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, SDWebImage(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, SDWebImage(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]
    
    override func viewDidLoad() {
        
        
        
        
        //thumbNotice.sd_setImageWithURL(NSURL(string: currentShownEvent.linkimg), placeholderImage: UIImage(named: "placeholder_img"))

        slideshow.backgroundColor = UIColor.whiteColor()
        slideshow.slideshowInterval = 5.0
        slideshow.pageControlPosition = PageControlPosition.UnderScrollView
        slideshow.pageControl.currentPageIndicatorTintColor = UIColor.lightGrayColor();
        slideshow.pageControl.pageIndicatorTintColor = UIColor.blackColor();
        slideshow.contentScaleMode = UIViewContentMode.ScaleAspectFill
        
        // try out other sources such as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource`
        slideshow.setImageInputs(localSource)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(DetalleGaleriaVC.click))
        slideshow.addGestureRecognizer(recognizer)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
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