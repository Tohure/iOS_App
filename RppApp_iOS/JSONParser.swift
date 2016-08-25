//
//  JSONParser.swift
//  
//
//  Created by Tohure on 4/21/16.
//  Copyright © 2016 RPP All rights reserved.
//

import UIKit

class JSONParser {
    
    static func objectWithData(data: NSData) throws -> AnyObject {
        let json = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
        
        return json
    }
    
    static func dataWithObject(object: AnyObject) throws -> NSData {
        let json = try NSJSONSerialization.dataWithJSONObject(object, options: NSJSONWritingOptions(rawValue: 0))
        return json
    }
    
    static func errorFromJSONObject(jsonObject:[String:AnyObject]) -> NSError {
        
        if let errorDictionary = jsonObject["error"] {
            
            let statusCode = errorDictionary["statusCode"] as! Int
            
            return NSError(domain: "UpArtError", code: statusCode, userInfo: JSONParser.createErrorInfoDictionary(errorDictionary as! [String : AnyObject]))

        
        } else {
            
            if let _ = jsonObject["statusCode"] {
                
                let statusCode = jsonObject["statusCode"] as! Int
                
                return NSError(domain: "UpArtError", code: statusCode, userInfo: JSONParser.createErrorInfoDictionary(jsonObject))
            }
        }
        
        return NSError(domain: "UpArtError", code: -999, userInfo: [NSLocalizedDescriptionKey:"Error"])
    }
    
    static func createErrorInfoDictionary(errorDictionary:[String:AnyObject]) -> [String:String] {
        return [NSLocalizedDescriptionKey:errorDictionary["message"] as! String]
    }
}

