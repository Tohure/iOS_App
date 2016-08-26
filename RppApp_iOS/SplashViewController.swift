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
        
        sendNoticias()
        /*
        if NetworkUtil.isConnectedToNetwork() { launchTimer() }
        else
        {
            dispatch_async(dispatch_get_main_queue(), {
                let connectionAlert = UIAlertController(title: "RPP dice:", message: "No cuentas con acceso a internet, para continuar por favor conecta tu dispositivo a una red Wi-Fi o 3G/4G e intente nuevamente", preferredStyle: .Alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in exit(0) }
                
                connectionAlert.addAction(OKAction)
                
                UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(connectionAlert, animated: true, completion: nil)
            })
        }*/
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
                    
                    self.sendNoticias()
                }
            }
        }
    }
    
    func sendNoticias() {
        
        let categories = Category.getCategoryItems()
        
        let tc = TabPageViewController.create()
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PortadaViewController") as! PortadaViewController
        vc.pathURL = categories[0].path
        let vc1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PortadaViewController") as! PortadaViewController
        vc1.pathURL = categories[1].path
        let vc2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PortadaViewController") as! PortadaViewController
        vc2.pathURL = categories[2].path
        let vc3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PortadaViewController") as! PortadaViewController
        vc3.pathURL = categories[3].path
        let vc4 = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PortadaViewController") as! PortadaViewController
        vc4.pathURL = categories[4].path
        let vc5 = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PortadaViewController") as! PortadaViewController
        vc5.pathURL = categories[5].path
        let vc6 = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PortadaViewController") as! PortadaViewController
        vc6.pathURL = categories[6].path
        let vc7 = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PortadaViewController") as! PortadaViewController
        vc7.pathURL = categories[7].path
        let vc8 = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PortadaViewController") as! PortadaViewController
        vc8.pathURL = categories[8].path
        let vc9 = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PortadaViewController") as! PortadaViewController
        vc9.pathURL = categories[9].path
        let vc10 = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PortadaViewController") as! PortadaViewController
        vc10.pathURL = categories[10].path
        
        tc.tabItems = [(vc, categories[0].name), (vc1, categories[1].name), (vc2, categories[2].name), (vc3, categories[3].name), (vc4, categories[4].name), (vc5, categories[5].name), (vc6, categories[6].name), (vc7, categories[7].name), (vc8, categories[8].name), (vc9, categories[9].name), (vc10, categories[10].name)]
        
        //tc.isInfinity = true
        
        let nc = UINavigationController()
        nc.viewControllers = [tc]
        var option = TabPageOption()
        option.currentColor = UIColor(red: 0/255, green: 96/255, blue: 171/255, alpha: 1.0)
        option.tabHeight = 50
        tc.option = option
        navigationController?.pushViewController(tc, animated: true)
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

