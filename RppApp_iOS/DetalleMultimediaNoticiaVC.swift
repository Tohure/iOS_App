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
    
    override func viewDidAppear(animated: Bool) {
        self.createPlayer()
        self.view.addSubview(player.view)
        //self.setupCallbacks()
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
       //
        //print(currentShownEvent.desarrollo)
    }
    
    func createPlayer() {
        // basic config
        
        /*
         JWConfig can be created with a single file reference
         var config: JWConfig = JWConfig(contentURL:"http://content.bitsontherun.com/videos/3XnJSIm4-injeKYZS.mp4")
         */
        
        let config: JWConfig = JWConfig()
        config.sources = [JWSource (file: "http://content.bitsontherun.com/videos/bkaovAYt-injeKYZS.mp4", label: "180p Streaming", isDefault: true),
                          JWSource (file: "http://content.bitsontherun.com/videos/bkaovAYt-52qL9xLP.mp4", label: "270p Streaming"),
                          JWSource (file: "http://content.bitsontherun.com/videos/bkaovAYt-DZ7jSYgM.mp4", label: "720p Streaming")]
        
        config.image = "http://content.bitsontherun.com/thumbs/bkaovAYt-480.jpg"
        config.title = "JWPlayer Demo"
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
        adConfig.skipMessage = "Skip in xx"
        adConfig.skipText = "Move on"
        adConfig.skipOffset = 3
        adConfig.adClient = vastPlugin
        config.adConfig = adConfig
        
        //auto start
        //        config.autostart = true
        
        //waterfall tags
        let waterfallTags: NSArray = ["bad tag", "another bad tag", "http://playertest.longtailvideo.com/adtags/preroll_newer.xml"]
        //ad breaks
        config.adSchedule = [JWAdBreak(tags:waterfallTags as! [String], offset:"1"),
                             JWAdBreak(tag: "http://playertest.longtailvideo.com/adtags/preroll_newer.xml", offset:"5"),
                             JWAdBreak(tag: "http://demo.jwplayer.com/player-demos/assets/overlay.xml", offset: "7", nonLinear: true),
                             //                           JWAdBreak(tag: "http://playertest.longtailvideo.com/adtags/preroll_newer.xml", offset:"0:00:05"),
            JWAdBreak(tag: "http://playertest.longtailvideo.com/adtags/preroll_newer.xml", offset:"50%"),
            JWAdBreak(tag: "http://playertest.longtailvideo.com/adtags/preroll_newer.xml", offset:"post")]
        
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
}