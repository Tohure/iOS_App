//
//  StreamingViewController.swift
//  RppApp_iOS
//
//  Created by Huamán Torres, Carlo Renzo on 24/08/16.
//  Copyright © 2016 Grupo RPP. All rights reserved.
//

import UIKit
import AVFoundation

class StreamingViewController: UIViewController {
    
    
    class PlayerAv {
        var audioLink: String?
        var player: AVPlayer
        init(link: String) {
            self.audioLink = link
            self.player = AVPlayer(URL: NSURL(string: link)!)
        }
    }
    
    var myPlayer = PlayerAv(link: "http://gruporemux-live.hls.adaptive.level3.net/hls-live/gruporemux-streamRPPRD/_definst_/live/stream1.m3u8")
 
    
    override func viewDidLoad() {
        /*
        myPlayer.player.play()
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            print("AVAudioSession Category Playback OK")
            do {
                try AVAudioSession.sharedInstance().setActive(true)
                print("AVAudioSession is Active")
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }*/
        
        
        
        super.viewDidLoad()
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}