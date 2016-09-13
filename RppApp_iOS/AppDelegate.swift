//
//  AppDelegate.swift
//  RppApp_iOS
//
//  Created by Huamán Torres, Carlo Renzo on 17/08/16.
//  Copyright © 2016 Grupo RPP. All rights reserved.
//

import UIKit
import AVFoundation
import AWSCognito
import AWSSNS

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var myPlayer = PlayerAv(link: "http://gruporemux-live.hls.adaptive.level3.net/hls-live/gruporemux-streamRPPRD/_definst_/live/stream1.m3u8")
    
    
    enum ShortcutIdentifier: String {
        case First
        case Second
        case Third
        case Fourth
        
        // MARK: Initializers
        
        init?(fullType: String) {
            guard let last = fullType.componentsSeparatedByString(".").last else { return nil }
            
            self.init(rawValue: last)
        }
        
        // MARK: Properties
        
        var type: String {
            return NSBundle.mainBundle().bundleIdentifier! + ".\(self.rawValue)"
        }
    }
    
    func playerPlaying() {
        
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
        }
    }
    
    func playerStoping() {
        
        myPlayer.player.pause()
    }
    
    
    // MARK: Static Properties
    
    static let applicationShortcutUserInfoIconKey = "applicationShortcutUserInfoIconKey"
    
    var window: UIWindow?


    /// Saved shortcut item used as a result of an app launch, used later when app is activated.
    var launchedShortcutItem: UIApplicationShortcutItem?
    
    func handleShortCutItem(shortcutItem: UIApplicationShortcutItem) -> Bool {
        var handled = false
        
        // Verify that the provided `shortcutItem`'s `type` is one handled by the application.
        guard ShortcutIdentifier(fullType: shortcutItem.type) != nil else { return false }
        
        guard let shortCutType = shortcutItem.type as String? else { return false }
        
        switch (shortCutType) {
        case ShortcutIdentifier.First.type:
            // Handle shortcut 1 (static).
            handled = true
            break
        case ShortcutIdentifier.Second.type:
            // Handle shortcut 2 (static).
            handled = true
            break
        case ShortcutIdentifier.Third.type:
            // Handle shortcut 3 (dynamic).
            handled = true
            break
        case ShortcutIdentifier.Fourth.type:
            // Handle shortcut 4 (dynamic).
            var navigationController:UINavigationController!
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            navigationController = self.window?.rootViewController as! UINavigationController
            let vc = storyboard.instantiateViewControllerWithIdentifier("StreamingViewController") as! StreamingViewController
            navigationController .pushViewController(vc, animated: true)
            handled = true
            break
        default:
            break
        }
        
        // Construct an alert using the details of the shortcut used to open the application.
        /*let alertController = UIAlertController(title: "Shortcut Handled", message: "\"\(shortcutItem.localizedTitle)\"", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(okAction)*/
        
        // Display an alert indicating the shortcut selected from the home screen.
        //window!.rootViewController?.presentViewController(alertController, animated: true, completion: nil)
        
        return handled
    }

    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
    
        // Override point for customization after application launch.
        
        // MPNowPlayingInfoCenter
        UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            //print("AVAudioSession Category Playback OK")
            do {
                try AVAudioSession.sharedInstance().setActive(true)
                //print("AVAudioSession is Active")
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        application.applicationIconBadgeNumber = 0
        
        let readAction = UIMutableUserNotificationAction()
        readAction.identifier = "READ_IDENTIFIER"
        readAction.title = "Read"
        readAction.activationMode = .Foreground
        readAction.destructive = false
        readAction.authenticationRequired = true

        let ignoreAction = UIMutableUserNotificationAction()
        ignoreAction.identifier = "IGNORE_IDENTIFIER"
        ignoreAction.title = "Ignore"
        ignoreAction.activationMode = .Background
        ignoreAction.destructive = false
        ignoreAction.authenticationRequired = true
        
        let deleteAction = UIMutableUserNotificationAction()
        deleteAction.identifier = "DELETE_IDENTIFIER"
        deleteAction.title = "Delete"
        deleteAction.activationMode = .Foreground;
        deleteAction.destructive = true
        deleteAction.authenticationRequired = true
        
        let messageCategory = UIMutableUserNotificationCategory()
        messageCategory.identifier = "MESSAGE_CATEGORY"
        messageCategory .setActions([readAction, ignoreAction, deleteAction], forContext: .Default)
        messageCategory .setActions([readAction,deleteAction], forContext: .Minimal)
        
        let categories = NSSet(objects: messageCategory)
        
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound,], categories: categories as? Set<UIUserNotificationCategory>)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        UIApplication.sharedApplication().registerForRemoteNotifications()
        
        // Override point for customization after application launch.
        var shouldPerformAdditionalDelegateHandling = true
        
        // If a shortcut was launched, display its information and take the appropriate action
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsShortcutItemKey] as? UIApplicationShortcutItem {
            
            launchedShortcutItem = shortcutItem
            
            // This will block "performActionForShortcutItem:completionHandler" from being called.
            shouldPerformAdditionalDelegateHandling = false
        }
        
        // Install initial versions of our two extra dynamic shortcuts.
        if let shortcutItems = application.shortcutItems where shortcutItems.isEmpty {
            // Construct the items.
            let shortcut3 = UIMutableApplicationShortcutItem(type: ShortcutIdentifier.Third.type, localizedTitle: "Últimas Noticias", localizedSubtitle: "Revisa las últimas noticias RPP", icon: nil, userInfo: nil
            )
            
            let shortcut4 = UIMutableApplicationShortcutItem(type: ShortcutIdentifier.Fourth.type, localizedTitle: "Radio en Vivo", localizedSubtitle: "Escucha nuestra radio en vivo", icon: UIApplicationShortcutIcon(type: .Play), userInfo: [
                AppDelegate.applicationShortcutUserInfoIconKey: UIApplicationShortcutIconType.Play.rawValue
                ]
            )
            
            // Update the application providing the initial 'dynamic' shortcut items.
            application.shortcutItems = [shortcut3, shortcut4]
        }
        
        /* Add this so we can see logging to calls to AWS
         options:
         AWSLogLevelNone
         AWSLogLevelError (default. Only error logs are printed to the console.)
         AWSLogLevelWarn
         AWSLogLevelInfo
         AWSLogLevelDebug
        
         */
        AWSLogger.defaultLogger().logLevel = .None
        
        return shouldPerformAdditionalDelegateHandling
        //return true
    }
    
    /*
     Called when the user activates your application by selecting a shortcut on the home screen, except when
     application(_:,willFinishLaunchingWithOptions:) or application(_:didFinishLaunchingWithOptions) returns `false`.
     You should handle the shortcut in those callbacks and return `false` if possible. In that case, this
     callback is used if your application is already launched in the background.
     */
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: Bool -> Void) {
        let handledShortCutItem = handleShortCutItem(shortcutItem)
        
        completionHandler(handledShortCutItem)
    }


    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        guard let shortcut = launchedShortcutItem else { return }
        
        handleShortCutItem(shortcut)
        
        launchedShortcutItem = nil
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        
        UIApplication.sharedApplication().endReceivingRemoteControlEvents()
        
    }
    
    class PlayerAv {
        var audioLink: String?
        var player: AVPlayer
        init(link: String) {
            self.audioLink = link
            self.player = AVPlayer(URL: NSURL(string: link)!)
        }
    }

}

//MARK: Notificaciones

extension AppDelegate {
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        //Amazon Credentials & Register
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType:.USEast1,identityPoolId:"us-east-1:b9d9ffa9-da62-4f6c-bca1-40f091d2ac3a")
        
        let configuration = AWSServiceConfiguration(region:.USEast1, credentialsProvider:credentialsProvider)
        
        AWSServiceManager.defaultServiceManager().defaultServiceConfiguration = configuration
        
        let syncClient = AWSCognito.defaultCognito()
        
        let dataset = syncClient.openOrCreateDataset("RPP_Notifications_Beta")
        dataset.setString("APN_Token", forKey: deviceTokenAsString(deviceToken))
        dataset.synchronize().continueWithBlock {(task: AWSTask!) -> AnyObject! in
            if task.error != nil {
                print("Error: \(task.error)")
            } else {
                self.AWScreateEndPoint(deviceToken,confAWS: configuration)
            }
            
            return nil
        }
        
        NSLog("deviceToken: %@", deviceToken);
    }
    
    func AWScreateEndPoint(deviceToken: NSData,confAWS: AWSServiceConfiguration){
        let myArn = "arn:aws:sns:us-east-1:217243875767:app/APNS_SANDBOX/Test_iOS_Renzo"
        
        let platformEndpointRequest = AWSSNSCreatePlatformEndpointInput()
        platformEndpointRequest.customUserData = "jyanayaco_iPhone6s"
        platformEndpointRequest.token = self.deviceTokenAsString(deviceToken)
        platformEndpointRequest.platformApplicationArn = myArn
        let snsManager = AWSSNS.defaultSNS()
        
        snsManager.createPlatformEndpoint(platformEndpointRequest).continueWithExecutor(AWSExecutor.mainThreadExecutor(), withBlock: { (task: AWSTask!) -> AnyObject! in
            if task.error != nil {
                print("Error: \(task.error)")
            } else {
                let createEndpointResponse = task.result as! AWSSNSCreateEndpointResponse
                print("endpointArn: \(createEndpointResponse.endpointArn)")
                NSUserDefaults.standardUserDefaults().setObject(createEndpointResponse.endpointArn, forKey: "endpointArn")
                self.AWSSubscribeToTopic(createEndpointResponse.endpointArn!);
            }
            
            return nil
        })
    }
    
    func AWSSubscribeToTopic(endPointARN: String){
        
        let topicARN = "arn:aws:sns:us-east-1:217243875767:RPP_Push_Notifications"
        
        let subscriptionRequest = AWSSNSSubscribeInput()
        subscriptionRequest.protocols = "application"
        subscriptionRequest.topicArn = topicARN
        subscriptionRequest.endpoint = endPointARN
        
        let snsManager = AWSSNS.defaultSNS()
        snsManager.subscribe(subscriptionRequest)
    }
 
    func deviceTokenAsString(deviceTokenData: NSData) -> String {
        let rawDeviceTring = "\(deviceTokenData.description)"
        let noSpaces = rawDeviceTring.stringByReplacingOccurrencesOfString(" ", withString: "")
        let tmp1 = noSpaces.stringByReplacingOccurrencesOfString("<", withString: "")
        return tmp1.stringByReplacingOccurrencesOfString(">", withString: "")
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        NSLog("Failed to register with error : %@", error);
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        application.applicationIconBadgeNumber = 0
        let msg = String(format: "%@", userInfo)
        createAlert(msg)
    }
    
    func createAlert(mensaje: String) {
        let alert = UIAlertController(title: "Alerta", message: mensaje, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
        
        if identifier == "READ_IDENTIFIER" {
            let msg = String(format: "%@","read")
            createAlert(msg)
        }else if identifier == "DELETE_IDENTIFIER"{
            let msg = String(format: "%@","delete")
            createAlert(msg)
        }
        
        completionHandler()
    }
    
}

