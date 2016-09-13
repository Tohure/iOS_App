//
//  NoticiasServices.swift
//  RppApp_iOS
//
//  Created by Huamán Torres, Carlo Renzo on 20/08/16.
//  Copyright © 2016 Grupo RPP. All rights reserved.
//

import Foundation


class NoticiasServices {
    
    static func fetchAllEvents(urlPath: String, completionHandler:([Noticia]?, error:NSError?) -> Void) {
    
        let request = RequestBuilder.GET(path: urlPath)
        
        NetworkManager().dataTaskWithRequest(request) { (jsonObject, error) -> Void in
            
            var objects = [Noticia]()
            
            if (error != nil) {
                completionHandler(nil, error: error)
            } else {
        
                if let jsonObjectArray = jsonObject as? NSArray {
                    for event in (jsonObjectArray as! [[String:AnyObject]]) {
                        objects.append(Noticia(jsonObject: event))
                    }
                    completionHandler(objects, error: nil)
                } else {
                    completionHandler(nil, error: NSError.errorWithMessage("Error"))
                }
            }
        }
    }
    
    
}
