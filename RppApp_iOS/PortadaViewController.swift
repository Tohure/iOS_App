//
//  PortadaViewController.swift
//  RppApp_iOS
//
//  Created by Huamán Torres, Carlo Renzo on 20/08/16.
//  Copyright © 2016 Grupo RPP. All rights reserved.
//

import UIKit
import QuartzCore

class PortadaViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var currentShownEvent : Noticia!
    var pathURL: String!
    var events = [Noticia]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchShares()
        NSNotificationCenter.defaultCenter().postNotificationName("llamaMiControlador", object: false)
    }
    
    func fetchShares() {
        
        let pathURLConcatenado = "/" + pathURL
        
        NoticiasServices.fetchAllEvents(pathURLConcatenado) { (array, error) -> Void in
            
            NSOperationQueue.mainQueue().addOperationWithBlock {
                
                if error == nil {
                    self.setupTableView()
                    self.events = array!
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle { return .LightContent }

}

extension PortadaViewController {
    
    func setupTableView () {

        tableView.allowsSelection = true
        
        self.automaticallyAdjustsScrollViewInsets = false
        //tableView.rowHeight = UITableViewAutomaticDimension
        //tableView.estimatedRowHeight = 160
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "BackIcon"), style: .Plain, target: self, action: #selector(EventListViewController.popToViewController))
    }
    
}

extension PortadaViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 368
        }
        
        return 100
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.events.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("NoticeDetailsProminentCell", forIndexPath: indexPath) as! NoticeDetailsProminentCell
            
            let event = events[indexPath.section]
            
            cell.loadNoticia(event)
            
            let contentView = cell.viewWithTag(11)! as UIView
            let shadowPath = UIBezierPath(rect: view.bounds)
            contentView.layer.masksToBounds = false
            contentView.layer.shadowColor = UIColor.lightGrayColor().CGColor
            contentView.layer.shadowOffset = CGSize(width: 0, height: 0.5)
            contentView.layer.shadowOpacity = 0.2
            contentView.layer.shadowPath = shadowPath.CGPath
            
            return cell
            
        }else {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("EventDetailsCell", forIndexPath: indexPath) as! EventDetailsCell
            
            let event = events[indexPath.section]
            
            cell.loadNoticia(event)
            
            let contentView = cell.viewWithTag(10)! as UIView
            let shadowPath = UIBezierPath(rect: view.bounds)
            contentView.layer.masksToBounds = false
            contentView.layer.shadowColor = UIColor.lightGrayColor().CGColor
            contentView.layer.shadowOffset = CGSize(width: 0, height: 0.5)
            contentView.layer.shadowOpacity = 0.2
            contentView.layer.shadowPath = shadowPath.CGPath
            
            return cell
        }
    

    }
    
    func toEventDetailsViewController() {
        
        dispatch_async(dispatch_get_main_queue()) {
            // update some UI
            self.performSegueWithIdentifier("toEventDetailsViewController", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toEventDetailsViewController" {
            //let eventDetailsViewController = segue.destinationViewController as! EventDetailsViewController
            //eventDetailsViewController.event = currentShownEvent
        }
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section != 0 {
            return 10
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section != 0 {
            let header = UIView()
            header.backgroundColor = UIColor.whiteColor()
            return header
        }
        
        return nil
    }
    
    
}

extension PortadaViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        dispatch_async(dispatch_get_main_queue(), {
            let event = self.events[indexPath.section]
            
            switch event.tipo {
            case "video", "audio":
                let vc = storyboard.instantiateViewControllerWithIdentifier("DetalleMultimediaNoticiaVC") as! DetalleMultimediaNoticiaVC
                vc.currentShownEvent = event
                self.navigationController?.pushViewController(vc, animated: true)
            case "galeria", "infografia":
                let vc = storyboard.instantiateViewControllerWithIdentifier("DetalleNoticiaVC") as! DetalleNoticiaVC
                vc.currentShownEvent = event
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                let vc = storyboard.instantiateViewControllerWithIdentifier("DetalleNoticiaVC") as! DetalleNoticiaVC
                vc.currentShownEvent = event
                self.navigationController?.pushViewController(vc, animated: true)
            }

        })
        
    }
    
}