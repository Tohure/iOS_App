//
//  StreamingViewController.swift
//  RppApp_iOS
//
//  Created by Huamán Torres, Carlo Renzo on 24/08/16.
//  Copyright © 2016 Grupo RPP. All rights reserved.
//

import UIKit

class StreamingViewController: UIViewController {
    
    private var delegado:AppDelegate!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    override func viewDidLoad() {
        
        delegado = UIApplication.sharedApplication().delegate as! AppDelegate
        delegado.playerPlaying()
        
        super.viewDidLoad()
    }
    
    @IBAction func playPressed(sender: AnyObject) {
        playButtonEnable(false)
        delegado.playerPlaying()
    }
   
    @IBAction func pausePressed(sender: AnyObject) {
        playButtonEnable()
        delegado.playerStoping()
    }
    
    func playButtonEnable(enabled: Bool = true) {
        if enabled {
            playButton.enabled = true
            pauseButton.enabled = false
        } else {
            playButton.enabled = false
            pauseButton.enabled = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}