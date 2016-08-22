//
//  NetworkManager.swift
//  Culture
//
//  Created by J on 3/17/16.
//  Copyright © 2016 LIMAAPP E.I.R.L. All rights reserved.


import Foundation
import UIKit


class NetworkManager {
    
    var jsonObject: AnyObject?
    let session: NSURLSession
    
    init() {
        
        let sessionConfigurarion = NSURLSessionConfiguration.defaultSessionConfiguration()
        sessionConfigurarion.timeoutIntervalForRequest = 30
        session = NSURLSession(configuration:sessionConfigurarion)
    }
    
    func dataTaskWithRequest(request:NSURLRequest, completionHandler:(jsonObject:AnyObject?, error:NSError?) -> Void) -> NSURLSessionTask {
        
        self.showNetworkActivityIndicator(true)
        
        let task = session.dataTaskWithRequest(request) { (optionalData, response, networkError) -> Void in
            
            self.showNetworkActivityIndicator(false)
            
            if let error = networkError {
                completionHandler(jsonObject: nil, error: error)
            } else if let data = optionalData, jsonObject = try? NSJSONSerialization.JSONObjectWithData(data, options: []) {
                
                if jsonObject.isKindOfClass(NSArray) {
                    completionHandler(jsonObject: jsonObject, error: nil)
                }
                if jsonObject.isKindOfClass(NSDictionary) {
                    if let error = NSError.errorWithMessageFromJSONObject(jsonObject as! [String : AnyObject]) {
                        completionHandler(jsonObject: jsonObject, error: error)
                    } else {
                        completionHandler(jsonObject: jsonObject, error: nil)
                    }
                }
            } else {
                completionHandler(jsonObject: nil, error: NSError.errorWithMessage("Respuesta inesperada del servidor.", code: -1))
            }
            
        }
        
        task.resume()
        
        return task
    }
    
    func showNetworkActivityIndicator(show:Bool) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = show
        })
    }
}

