//
//  NowPlayingViewController.swift
//  Swift Radio
//
//  Created by Matthew Fecher on 7/22/15.
//  Copyright (c) 2015 MatthewFecher.com. All rights reserved.
//

import UIKit
import MediaPlayer

//*****************************************************************
// Protocol
// Updates the StationsViewController when the track changes
//*****************************************************************

protocol NowPlayingViewControllerDelegate: class {
    func songMetaDataDidUpdate(track: Track)
    func artworkDidUpdate(track: Track)
    func trackPlayingToggled(track: Track)
}


//*****************************************************************
// NowPlayingViewController
//*****************************************************************

class NowPlayingViewController: UIViewController {

    @IBOutlet weak var albumHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var albumImageView: SpringImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var songLabel: SpringLabel!
    @IBOutlet weak var stationDescLabel: UILabel!
    @IBOutlet weak var volumeParentView: UIView!
    @IBOutlet weak var slider = UISlider()
    
    var currentStation: RadioStation!
    var downloadTask: NSURLSessionDownloadTask?
    var iPhone4 = false
    var justBecameActive = false
    var newStation = true
    var nowPlayingImageView: UIImageView!
    let radioPlayer = Player.radio
    var track: Track!
    var mpVolumeSlider = UISlider()
    
    let streamURL = "http://gruporemux-live.hls.adaptive.level3.net/hls-live/gruporemux-streamRPPRD/_definst_/live/stream1.m3u8"
    
    weak var delegate: NowPlayingViewControllerDelegate?
    
    //*****************************************************************
    // MARK: - ViewDidLoad
    //*****************************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup handoff functionality - GH
        setupUserActivity()
        
        // Create Now Playing BarItem
        createNowPlayingAnimation()
        
        // Setup MPMoviePlayerController
        // If you're building an app for a client, you may want to
        // replace the MediaPlayer player with a more robust 
        // streaming library/SDK. Preferably one that supports interruptions, etc.
        // Most of the good streaming libaries are in Obj-C, however they
        // will work nicely with this Swift code. There is a branch using RadioKit if 
        // you need an example of how nicely this code integrates with libraries.
        setupPlayer()
        
        // Notification for when app becomes active
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: #selector(NowPlayingViewController.didBecomeActiveNotificationReceived),
            name: "UIApplicationDidBecomeActiveNotification",
            object: nil)
        
        // Notification for MediaPlayer metadata updated
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: #selector(NowPlayingViewController.metadataUpdated(_:)),
            name:MPMoviePlayerTimedMetadataUpdatedNotification,
            object: nil)
        
        // Notification for AVAudioSession Interruption (e.g. Phone call)
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: #selector(NowPlayingViewController.sessionInterrupted(_:)),
            name: AVAudioSessionInterruptionNotification,
            object: AVAudioSession.sharedInstance())
        
        // Check for station change
        if newStation {
            track = Track()
            stationDidChange()
        } else {
            albumImageView.image = track.artworkImage
            
            if !track.isPlaying {
                pausePressed()
            } else {
                nowPlayingImageView.startAnimating()
            }
        }
        
        // Setup slider
        setupVolumeSlider()
        
    }
    
    func didBecomeActiveNotificationReceived() {
        // View became active
        justBecameActive = true
        updateAlbumArtwork()
    }
    
    deinit {
        // Be a good citizen
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name:"UIApplicationDidBecomeActiveNotification",
            object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: MPMoviePlayerTimedMetadataUpdatedNotification,
            object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: AVAudioSessionInterruptionNotification,
            object: AVAudioSession.sharedInstance())
    }
    
    //*****************************************************************
    // MARK: - Setup
    //*****************************************************************
    
    func setupPlayer() {
        radioPlayer.view.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        radioPlayer.view.sizeToFit()
        radioPlayer.movieSourceType = MPMovieSourceType.Streaming
        radioPlayer.fullscreen = false
        radioPlayer.shouldAutoplay = true
        radioPlayer.prepareToPlay()
        radioPlayer.controlStyle = MPMovieControlStyle.None
    }
  
    func setupVolumeSlider() {
        // Note: This slider implementation uses a MPVolumeView
        // The volume slider only works in devices, not the simulator.
        volumeParentView.backgroundColor = UIColor.clearColor()
        let volumeView = MPVolumeView(frame: volumeParentView.bounds)
        for view in volumeView.subviews {
            let uiview: UIView = view as UIView
             if (uiview.description as NSString).rangeOfString("MPVolumeSlider").location != NSNotFound {
                mpVolumeSlider = (uiview as! UISlider)
            }
        }
        
        let thumbImageNormal = UIImage(named: "slider-ball")
        slider?.setThumbImage(thumbImageNormal, forState: .Normal)
        
    }
    
    func stationDidChange() {
        radioPlayer.stop()
        
        radioPlayer.contentURL = NSURL(string: streamURL)
        radioPlayer.prepareToPlay()
        radioPlayer.play()
        
        track.isPlaying = true
    }
    
    //*****************************************************************
    // MARK: - Player Controls (Play/Pause/Volume)
    //*****************************************************************
    
    @IBAction func playPressed() {
        track.isPlaying = true
        playButtonEnable(false)
        radioPlayer.play()
        
        // songLabel Animation
        /*
        songLabel.animation = "flash"
        songLabel.animate()
        */
        // Start NowPlaying Animation
        nowPlayingImageView.startAnimating()
        
        // Update StationsVC
        self.delegate?.trackPlayingToggled(self.track)
    }
    
    @IBAction func pausePressed() {
        track.isPlaying = false
        
        playButtonEnable()
        
        radioPlayer.pause()
        nowPlayingImageView.stopAnimating()
        
        // Update StationsVC
        self.delegate?.trackPlayingToggled(self.track)
    }
    
    @IBAction func volumeChanged(sender:UISlider) {
        mpVolumeSlider.value = sender.value
    }
    
    //*****************************************************************
    // MARK: - UI Helper Methods
    //*****************************************************************
    
    
    func playButtonEnable(enabled: Bool = true) {
        if enabled {
            playButton.enabled = true
            pauseButton.enabled = false
            track.isPlaying = false
        } else {
            playButton.enabled = false
            pauseButton.enabled = true
            track.isPlaying = true
        }
    }
    
    func createNowPlayingAnimation() {
        
        // Setup ImageView
        nowPlayingImageView = UIImageView(image: UIImage(named: "NowPlayingBars-3"))
        nowPlayingImageView.autoresizingMask = UIViewAutoresizing.None
        nowPlayingImageView.contentMode = UIViewContentMode.Center
        
        // Create Animation
        nowPlayingImageView.animationImages = AnimationFrames.createFrames()
        nowPlayingImageView.animationDuration = 0.7
        
        // Create Top BarButton
        let barButton = UIButton(type: UIButtonType.Custom)
        barButton.frame = CGRectMake(0, 0, 40, 40);
        barButton.addSubview(nowPlayingImageView)
        nowPlayingImageView.center = barButton.center
        
        let barItem = UIBarButtonItem(customView: barButton)
        self.navigationItem.rightBarButtonItem = barItem
        
    }
    
    func startNowPlayingAnimation() {
        nowPlayingImageView.startAnimating()
    }
    
    //*****************************************************************
    // MARK: - Album Art
    //*****************************************************************
    
    func resetAlbumArtwork() {
        track.artworkLoaded = false
        track.artworkURL = currentStation.stationImageURL
        updateAlbumArtwork()
        stationDescLabel.hidden = false
    }
    
    func updateAlbumArtwork() {
        track.artworkLoaded = false
        if track.artworkURL.rangeOfString("http") != nil {
            
            // Hide station description
            dispatch_async(dispatch_get_main_queue()) {
                //self.albumImageView.image = nil
                self.stationDescLabel.hidden = false
            }
            
            // Attempt to download album art from an API
            if let url = NSURL(string: track.artworkURL) {
                
                self.downloadTask = self.albumImageView.loadImageWithURL(url) { (image) in
                    
                    // Update track struct
                    self.track.artworkImage = image
                    self.track.artworkLoaded = true
                    
                    // Turn off network activity indicator
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                        
                    // Animate artwork
                    self.albumImageView.animation = "wobble"
                    self.albumImageView.duration = 2
                    self.albumImageView.animate()
                    self.stationDescLabel.hidden = true

                    // Update lockscreen
                    self.updateLockScreen()
                    
                    // Call delegate function that artwork updated
                    self.delegate?.artworkDidUpdate(self.track)
                }
            }
            
            // Hide the station description to make room for album art
            if track.artworkLoaded && !self.justBecameActive {
                self.stationDescLabel.hidden = true
                self.justBecameActive = false
            }
            
        } else if track.artworkURL != "" {
            // Local artwork
            self.albumImageView.image = UIImage(named: track.artworkURL)
            track.artworkImage = albumImageView.image
            track.artworkLoaded = true
            
            // Call delegate function that artwork updated
            self.delegate?.artworkDidUpdate(self.track)
            
        } else {
            // No Station or API art found, use default art
            self.albumImageView.image = UIImage(named: "albumArt")
            track.artworkImage = albumImageView.image
        }
        
        // Force app to update display
        self.view.setNeedsDisplay()
    }

    
    //*****************************************************************
    // MARK: - Segue
    //*****************************************************************
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        /*
        if segue.identifier == "InfoDetail" {
            let infoController = segue.destinationViewController as! InfoDetailViewController
            infoController.currentStation = currentStation
        }*/
    }
    
    @IBAction func infoButtonPressed(sender: UIButton) {
        //performSegueWithIdentifier("InfoDetail", sender: self)
    }
    
    @IBAction func shareButtonPressed(sender: UIButton) {
        let songToShare = "I'm listening to \(track.title) on \(currentStation.stationName) via Swift Radio Pro"
        let activityViewController = UIActivityViewController(activityItems: [songToShare, track.artworkImage!], applicationActivities: nil)
        presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    //*****************************************************************
    // MARK: - MPNowPlayingInfoCenter (Lock screen)
    //*****************************************************************
    
    func updateLockScreen() {
        
        // Update notification/lock screen
        let albumArtwork = MPMediaItemArtwork(image: track.artworkImage!)
        
        MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo = [
            MPMediaItemPropertyArtist: track.artist,
            MPMediaItemPropertyTitle: track.title,
            MPMediaItemPropertyArtwork: albumArtwork
        ]
    }
    
    override func remoteControlReceivedWithEvent(receivedEvent: UIEvent?) {
        super.remoteControlReceivedWithEvent(receivedEvent)
        
        if receivedEvent!.type == UIEventType.RemoteControl {
            
            switch receivedEvent!.subtype {
            case .RemoteControlPlay:
                playPressed()
            case .RemoteControlPause:
                pausePressed()
            default:
                break
            }
        }
    }
    
    //*****************************************************************
    // MARK: - MetaData Updated Notification
    //*****************************************************************
    
    func metadataUpdated(n: NSNotification)
    {
        if(radioPlayer.timedMetadata != nil && radioPlayer.timedMetadata.count > 0)
        {
            startNowPlayingAnimation()
            
            let firstMeta: MPTimedMetadata = radioPlayer.timedMetadata.first as! MPTimedMetadata
            let metaData = firstMeta.value as! String
            
            var stringParts = [String]()
            if metaData.rangeOfString(" - ") != nil {
                stringParts = metaData.componentsSeparatedByString(" - ")
            } else {
                stringParts = metaData.componentsSeparatedByString("-")
            }
            
            // Set artist & songvariables
            let currentSongName = track.title
            track.artist = stringParts[0]
            track.title = stringParts[0]
            
            if stringParts.count > 1 {
                track.title = stringParts[1]
            }
            
            if track.artist == "" && track.title == "" {
                track.artist = currentStation.stationDesc
                track.title = currentStation.stationName
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                
                if currentSongName != self.track.title {
                    
                    if kDebugLog {
                        print("METADATA artist: \(self.track.artist) | title: \(self.track.title)")
                    }
                    
                    // Update Labels
                    self.artistLabel.text = self.track.artist
                    self.songLabel.text = self.track.title
                    self.updateUserActivityState(self.userActivity!)
                    
                    // songLabel animation
                    self.songLabel.animation = "zoomIn"
                    self.songLabel.duration = 1.5
                    self.songLabel.damping = 1
                    self.songLabel.animate()
                    
                    // Update Stations Screen
                    self.delegate?.songMetaDataDidUpdate(self.track)
                    
                    // Query API for album art
                    self.resetAlbumArtwork()
                    self.updateLockScreen()
                    
                }
            }
        }
    }
    
    //*****************************************************************
    // MARK: - AVAudio Sesssion Interrupted
    //*****************************************************************
    
    // Example code on handling AVAudio interruptions (e.g. Phone calls)
    func sessionInterrupted(notification: NSNotification) {
        if let typeValue = notification.userInfo?[AVAudioSessionInterruptionTypeKey] as? NSNumber{
            if let type = AVAudioSessionInterruptionType(rawValue: typeValue.unsignedLongValue){
                if type == .Began {
                    print("interruption: began")
                    // Add your code here
                } else{
                    print("interruption: ended")
                    // Add your code here
                }
            }
        }
    }
    
    //*****************************************************************
    // MARK: - Handoff Functionality - GH
    //*****************************************************************
    
    func setupUserActivity() {
        /*
        let activity = NSUserActivity(activityType: NSUserActivityTypeBrowsingWeb ) //"com.graemeharrison.handoff.googlesearch" //NSUserActivityTypeBrowsingWeb
        userActivity = activity
        let url = "https://www.google.com/search?q=\(self.artistLabel.text!)+\(self.songLabel.text!)"
        let urlStr = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        let searchURL : NSURL = NSURL(string: urlStr!)!
        activity.webpageURL = searchURL
        userActivity?.becomeCurrent()*/
    }
    
    override func updateUserActivityState(activity: NSUserActivity) {
        /*
        let url = "https://www.google.com/search?q=\(self.artistLabel.text!)+\(self.songLabel.text!)"
        let urlStr = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        let searchURL : NSURL = NSURL(string: urlStr!)!
        activity.webpageURL = searchURL
        super.updateUserActivityState(activity)*/
    }
}
