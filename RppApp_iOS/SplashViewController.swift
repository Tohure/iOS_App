//
//  SplashViewController.swift
//  RppApp_iOS
//
//  Created by Huamán Torres, Carlo Renzo on 17/08/16.
//  Copyright © 2016 Grupo RPP. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    var timer:NSTimer? = nil;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getEventsInformation()
        
        if NetworkUtil.isConnectedToNetwork() { launchTimer() }
        else
        {
            dispatch_async(dispatch_get_main_queue(), {
                let connectionAlert = UIAlertController(title: "RPP dice:", message: "No cuentas con acceso a internet, para continuar por favor conecta tu dispositivo a una red Wi-Fi o 3G/4G e intente nuevamente", preferredStyle: .Alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in exit(0) }
                
                connectionAlert.addAction(OKAction)
                
                UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(connectionAlert, animated: true, completion: nil)
            })
        }
    }
    
    func getEventsInformation() {
        
        let pathURL = "/deportes"
        
        NoticiasServices.fetchAllEvents(pathURL) { (array, error) -> Void in
            
            NSOperationQueue.mainQueue().addOperationWithBlock {
                
                if let error = error {
                    
                    let alertController = UIAlertController(title: error.localizedDescription, message: "¿Quieres intentarlo de nuevo?", preferredStyle: .Alert)
                    
                    alertController.addAction(UIAlertAction(title: "Reintentar", style: .Default, handler: { (alert) -> Void in
                        self.getEventsInformation()
                    }))
                    
                    alertController.addAction(UIAlertAction(title: "Cancelar", style: .Cancel, handler: nil))
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
                } else {
                    for item in array! {
                        print("titular \(item.titular) linkimg \(item.linkimg)")
                    }
                }
            }
        }
    }
    
    func launchTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(SplashViewController.launchAction(_:)), userInfo: nil, repeats: false)
    }
    
    
    func launchAction(timer:NSTimer){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("portadaView") as! PortadaViewController
        dispatch_async(dispatch_get_main_queue(), {
            self.presentViewController(vc, animated: true, completion: nil)
        })
    }
    
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle { return .LightContent }

}

