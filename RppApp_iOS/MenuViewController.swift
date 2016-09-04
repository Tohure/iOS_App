//
//  MenuViewController.swift
//  Culture
//
//  Created by J on 3/23/16.
//  Copyright © 2016 LIMAAPP E.I.R.L. All rights reserved.
//

import UIKit

let searchTitle = "Buscar"
let calendarTitle = "Mi agenda"
let notificationTitle =  "Mis Notificaciones"
let favoriteTitle = "Mis favoritos"
let profileTitle = "Perfil"
let settingsTitle = "Configuración"
let logOutTitle = "Salir"

class MenuViewController: UIViewController {
    
    let searchImage = "ProfileMenu"
    let calendarImage = "ProfileMenu"
    let notificationImage = "ProfileMenu"
    let favoriteImage = "ProfileMenu"
    let profileImage = "ProfileMenu"
    let settingsImage = "ProfileMenu"
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var profileName: UILabel!
    
    var previouslyPresentedRow = 0
    
    var mylocationViewController: UINavigationController?
    var searchViewController: UINavigationController?
    var calendarViewController: UINavigationController?
    var notificationViewController: UINavigationController?
    var favoriteViewController: UINavigationController?
    var profileViewControler: UINavigationController?
    var settingsViewController: UINavigationController?
    
    var menuItemTitles = [searchTitle, calendarTitle, notificationTitle, favoriteTitle, profileTitle, settingsTitle]

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        //addUserNotifications()
        
    }
    
//    func addUserNotifications() {
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MenuViewController.changeProfile), name: User.didUpdateCurrentUserNotification, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MenuViewController.logOut), name: User.didLogoutNotification, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MenuViewController.logIn), name: User.didLoginNotification, object: nil)
//    }
//    
//    deinit {
//        NSNotificationCenter.defaultCenter().removeObserver(self, name: User.didLoginNotification, object: nil)
//        NSNotificationCenter.defaultCenter().removeObserver(self, name: User.didLogoutNotification, object: nil)
//        NSNotificationCenter.defaultCenter().removeObserver(self, name: User.didUpdateCurrentUserNotification, object: nil)
//    }

    
    //MARK: image For Optio nWith Title
    func imageForOptionWithTitle(title:String) -> UIImage? {
    
        var imageName: String!
    
        if (title == searchTitle) {
            imageName = searchImage
        }
        
        else if (title == calendarTitle) {
            imageName = calendarImage
        }
        
        else if (title == notificationTitle) {
            imageName = notificationImage
        }
        
        else if (title == favoriteTitle) {
            imageName = favoriteImage
        }
        
        else if (title == profileTitle) {
            imageName = profileImage
        }
        
        else if (title == settingsTitle) {
            imageName = settingsImage
        }
        
        else {
            return nil
        }
        
        return UIImage(named: imageName)
    }
  
}

extension MenuViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItemTitles.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let title = menuItemTitles[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuItemCell", forIndexPath: indexPath) as! MenuItemCell
        cell.menuItemTitle.text = title
        cell.menuIconImageView.contentMode = .ScaleAspectFit
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.blackColor()
        cell.selectedBackgroundView = bgColorView
        
        if let image = imageForOptionWithTitle(title) {
            cell.menuIconImageView.image = image
        }

//        if indexPath.row == menuItemTitles.count - 1 && UserManager.hasCurrentUser() {
//            cell.menuItemTitle.textColor = UIColor.watermelonColor()
//        }
//        else {
//            cell.menuItemTitle.textColor = UIColor.whiteColor()
//        }
        
        
        cell.setNeedsLayout()
        return cell
    }
}

extension MenuViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     
        let previouslyPresentedCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: previouslyPresentedRow, inSection: 0))
            previouslyPresentedCell?.setSelected(false, animated: false)
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath)
        currentCell!.setSelected(true, animated: false)
        
//        if indexPath.row == previouslyPresentedRow {
//        
//            self.revealViewController().setFrontViewPosition(.Left, animated: true)
//            return;
//        }

        var newFrontController : UIViewController!

        let title = menuItemTitles[indexPath.row]
        
        
        //Inicio
        if title == searchTitle {
            
            if let locationViewController = self.mylocationViewController {
                newFrontController = locationViewController
            }
            
            else {
                let nav = self.storyboard?.instantiateViewControllerWithIdentifier("MyLocationNavController") as! UINavigationController
                let locationViewController = self.storyboard?.instantiateViewControllerWithIdentifier("StreamingViewController") as! StreamingViewController
                nav.setViewControllers([locationViewController], animated: true)
                self.mylocationViewController = nav
                newFrontController = self.mylocationViewController
            }
        }
            
        //Agenda
            
        else if title == calendarTitle {
            
            let nav = self.storyboard?.instantiateViewControllerWithIdentifier("Playing") as! BlackTransparentNavigationController
            let locationViewController = self.storyboard?.instantiateViewControllerWithIdentifier("StreamingViewController") as! StreamingViewController
            nav.setViewControllers([locationViewController], animated: true)
            self.mylocationViewController = nav
            newFrontController = self.mylocationViewController
        }

        
        //Notificaciones
        else if title == notificationTitle {
            
            let nav = self.storyboard?.instantiateViewControllerWithIdentifier("MyLocationNavController") as! BlackTransparentNavigationController
            let locationViewController = self.storyboard?.instantiateViewControllerWithIdentifier("StreamingViewController") as! StreamingViewController
            nav.setViewControllers([locationViewController], animated: true)
            self.mylocationViewController = nav
            newFrontController = self.mylocationViewController
        }
        
        //Favoritos
            
        else if title == favoriteTitle {
            
            let nav = self.storyboard?.instantiateViewControllerWithIdentifier("MyLocationNavController") as! BlackTransparentNavigationController
            let locationViewController = self.storyboard?.instantiateViewControllerWithIdentifier("StreamingViewController") as! StreamingViewController
            nav.setViewControllers([locationViewController], animated: true)
            self.mylocationViewController = nav
            newFrontController = self.mylocationViewController

        }
        
        //Perfil
        else if title == profileTitle {
            
            let nav = self.storyboard?.instantiateViewControllerWithIdentifier("MyLocationNavController") as! BlackTransparentNavigationController
            let locationViewController = self.storyboard?.instantiateViewControllerWithIdentifier("StreamingViewController") as! StreamingViewController
            nav.setViewControllers([locationViewController], animated: true)
            self.mylocationViewController = nav
            newFrontController = self.mylocationViewController
        }
            
        //Configuracion
            
        else if title == settingsTitle {
            
            if let settingsViewController = self.settingsViewController {
                newFrontController = settingsViewController
            }
                
            else {
                let nav = self.storyboard?.instantiateViewControllerWithIdentifier("MyLocationNavController") as! BlackTransparentNavigationController
                let locationViewController = self.storyboard?.instantiateViewControllerWithIdentifier("StreamingViewController") as! StreamingViewController
                nav.setViewControllers([locationViewController], animated: true)
                self.mylocationViewController = nav
                newFrontController = self.mylocationViewController
            }
        }
        
        else if title == logOutTitle {
            
            let alertController = UIAlertController(title: nil, message: "Seguro deseas salir?", preferredStyle: .ActionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancelar", style: .Cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            let destroyAction = UIAlertAction(title: "Salir", style: .Destructive) { (action) in
                
            }
            
            alertController.addAction(destroyAction)
            
            self.presentViewController(alertController, animated:true, completion: nil)
            
            return
        }

        revealViewController().pushFrontViewController(newFrontController, animated: true)

        previouslyPresentedRow = indexPath.row
        
    }
    
}


