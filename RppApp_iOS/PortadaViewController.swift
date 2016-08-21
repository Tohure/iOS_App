//
//  PortadaViewController.swift
//  RppApp_iOS
//
//  Created by Huamán Torres, Carlo Renzo on 20/08/16.
//  Copyright © 2016 Grupo RPP. All rights reserved.
//

import UIKit

class PortadaViewController: UIViewController {
    
    
    @IBOutlet weak var thumbP: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        thumbP.sd_setImageWithURL(NSURL(string: "http://p-gruporpp-media.s3.amazonaws.com/2016/08/20/540054_224608.png"), placeholderImage: UIImage(named: "defaultBackground"))
        
        
    }
    
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle { return .LightContent }

}