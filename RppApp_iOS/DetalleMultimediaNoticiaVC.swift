//
//  DetalleMultimediaNoticiaVC.swift
//  RppApp_iOS
//
//  Created by Huamán Torres, Carlo Renzo on 25/08/16.
//  Copyright © 2016 Grupo RPP. All rights reserved.
//


import UIKit
import MediaPlayer

class DetalleMultimediaNoticiaVC: UIViewController, JWPlayerDelegate {
    
    private var player:JWPlayerController!
    var currentShownEvent : Noticia!
    
    @IBOutlet weak var tableViewNew: UITableView!
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().postNotificationName("llamaMiControlador", object: false)
    }
    
    override func viewDidAppear(animated: Bool) {
        
        NSNotificationCenter.defaultCenter().postNotificationName("llamaMiControlador", object: true)
        self.createPlayer()
        self.view.addSubview(player.view)
        
        let btnBack = UIButton(type: .Custom)
        btnBack.frame = CGRectMake(13, 20, 40, 40)
        btnBack.setBackgroundImage(UIImage(named: "back_button"), forState: .Normal)
        btnBack.adjustsImageWhenHighlighted = false
        btnBack.addTarget(self, action: #selector(DetalleMultimediaNoticiaVC.popToViewController), forControlEvents: .TouchUpInside)
        self.view.addSubview(btnBack)

        super.viewDidAppear(animated)
    }
    
    func popToViewController() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        
        self.tableViewNew.estimatedRowHeight = 80
        self.tableViewNew.rowHeight = UITableViewAutomaticDimension
        
        self.tableViewNew.setNeedsLayout()
        self.tableViewNew.layoutIfNeeded()
        
        print(currentShownEvent.elemento)
        
        //self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0) // Status bar inset
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.edgesForExtendedLayout = .None
        tableViewNew .reloadData()
    }
    
    func createPlayer() {
        // basic config
        
        /*
         JWConfig can be created with a single file reference
         var config: JWConfig = JWConfig(contentURL:"http://content.bitsontherun.com/videos/3XnJSIm4-injeKYZS.mp4")
         */
        
        let imageURLArray = currentShownEvent.elemento.componentsSeparatedByString("dev.")
        
        let config: JWConfig = JWConfig()
        
        if imageURLArray.count > 1 {
            
            config.sources = [JWSource (file: "http://\(String(format: "%@",imageURLArray.last!))" , label: "180p Streaming", isDefault: true)]
        }
        

        
        config.image = currentShownEvent.linkimg
        //config.title = currentShownEvent.titular
        config.controls = true  //default
        config.`repeat` = false   //default
        config.premiumSkin = JWPremiumSkinRoundster
        
        /*
         custom css skin can be applied using:
         config.cssSkin = "http://p.jwpcdn.com/iOS/Skins/ethan.css"
         */
        
        //captions
        config.tracks = [JWTrack (file: "http://playertest.longtailvideo.com/caption-files/sintel-en.srt", label: "English", isDefault: true),
                         JWTrack (file: "http://playertest.longtailvideo.com/caption-files/sintel-sp.srt", label: "Spanish"),
                         JWTrack (file: "http://playertest.longtailvideo.com/caption-files/sintel-ru.srt", label: "Russian")]
        
        //caption config
        let captionStyling: JWCaptionStyling = JWCaptionStyling()
        captionStyling.font = UIFont (name: "Zapfino", size: 20)
        captionStyling.edgeStyle = raised
        captionStyling.windowColor = UIColor.purpleColor()
        captionStyling.backgroundColor = UIColor(red: 0.3, green: 0.6, blue: 0.3, alpha: 0.7)
        captionStyling.fontColor = UIColor.blueColor()
        config.captionStyling = captionStyling
        
        //ad config
        let adConfig: JWAdConfig = JWAdConfig()
        adConfig.adMessage = "Ad duration countdown xx"
        adConfig.skipMessage = "Saltar en xx"
        adConfig.skipText = "Move on"
        adConfig.skipOffset = 3
        adConfig.adClient = vastPlugin
        config.adConfig = adConfig
        
        //auto start
        //        config.autostart = true
        
        //waterfall tags
        //let waterfallTags: NSArray = ["bad tag", "another bad tag", "http://playertest.longtailvideo.com/adtags/preroll_newer.xml"]
        //ad breaks
        /*config.adSchedule = [JWAdBreak(tags:waterfallTags as! [String], offset:"20"),
                             JWAdBreak(tag: "http://playertest.longtailvideo.com/adtags/preroll_newer.xml", offset:"27"),
                             JWAdBreak(tag: "http://demo.jwplayer.com/player-demos/assets/overlay.xml", offset: "30", nonLinear: true),
                             JWAdBreak(tag: "http://playertest.longtailvideo.com/adtags/preroll_newer.xml", offset:"0:00:05"),
                             JWAdBreak(tag: "http://playertest.longtailvideo.com/adtags/preroll_newer.xml", offset:"50%"),
                             JWAdBreak(tag: "http://playertest.longtailvideo.com/adtags/preroll_newer.xml", offset:"post")]*/
        
        self.player = JWPlayerController(config: config)
        self.player.delegate = self
        
        //sets player frame to be half the screen
        //alternatively config.size can be used during the player creation
        var frame: CGRect = self.view.bounds
        frame.size.height /= 2
        frame.size.height -= 44
        
        self.player.view.frame = frame
        self.player.view.autoresizingMask = [UIViewAutoresizing.FlexibleBottomMargin, UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleLeftMargin, UIViewAutoresizing.FlexibleRightMargin, UIViewAutoresizing.FlexibleTopMargin, UIViewAutoresizing.FlexibleWidth];
        
        self.player.openSafariOnAdClick = true
        self.player.forceFullScreenOnLandscape = true
        self.player.forceLandscapeOnFullScreen = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle { return .LightContent }
    
}

extension DetalleMultimediaNoticiaVC : UITableViewDataSource {
    
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
        //cell.bodyLabel.text = currentShownEvent.desarrollo
        
        /*let attrStr = try! NSAttributedString(
            data: currentShownEvent.desarrollo.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        cell.bodyLabel.attributedText = attrStr*/
        
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