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
    
   
    @IBOutlet weak var talbeContent: UITableView!
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
        
        self.talbeContent.estimatedRowHeight = 80
        self.talbeContent.rowHeight = UITableViewAutomaticDimension
        
        self.talbeContent.setNeedsLayout()
        self.talbeContent.layoutIfNeeded()
        
        //self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0) // Status bar inset
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.edgesForExtendedLayout = .None
        talbeContent .reloadData()

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

extension DetalleGaleriaVC : UITableViewDataSource {
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DynamicCell", forIndexPath: indexPath) as! DynamicTableViewCell
        
        cell.titleLabel.text = currentShownEvent.titular
        cell.bodyLabel.attributedText = handleHtml(currentShownEvent.desarrollo)
        
        return cell
    }
    
    func handleHtml(string : String) -> NSAttributedString{
        var returnStr = NSMutableAttributedString()
        do {
            returnStr = try NSMutableAttributedString(data: string.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!, options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
            
            let fullRange : NSRange = NSMakeRange(0, returnStr.length)
            returnStr.addAttributes([NSFontAttributeName : UIFont(name: "Helvetica Neue", size: 18.0)!], range: fullRange)
            
        } catch {
            print(error)
        }
        return returnStr
    }
    
}