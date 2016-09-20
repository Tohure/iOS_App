//
//  RequestBuilder.swift
//  
//
//  Created by Huamán Torres, Carlo Renzo on 20/08/16.
//  Copyright © 2016 Grupo RPP. All rights reserved.
//

import Foundation
import UIKit

class RequestBuilder {
    
    static let baseURL = "http://rpp.pe/lgfeed/"
    
    //MARK : URL for Path
    
    static func URLforPath(path: String) -> NSURL {
        
        let urlString = baseURL + path
        let url = NSURL(string: urlString)!
        return url
    }
    
    static func URLforPath(path: String, query: [NSURLQueryItem]) -> NSURL {
        
        let urlString = baseURL + path
        let components = NSURLComponents(string: urlString)!
        components.queryItems = query
        return components.URL!
    }
    
    
    //MARK : build Request
    
    static func buildRequestWithURL(URL: NSURL, HTTPMethod: String) -> NSMutableURLRequest {
        
        return buildRequestWithURL(URL, HTTPMethod: HTTPMethod, contentType: "application/json")
    }
    
    static func buildRequestWithURL(URL: NSURL, HTTPMethod: String, contentType:String) -> NSMutableURLRequest {
        
        let request = NSMutableURLRequest(URL: URL)
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = HTTPMethod
        return request
    }
    
    
    //MARK : GET
    
    static func GET(path path: String) -> NSMutableURLRequest {
        let URL = URLforPath(path)
        return buildRequestWithURL(URL, HTTPMethod: "GET")
    }
    
    static func GET(path path: String, query: [NSURLQueryItem]) -> NSMutableURLRequest {
        let URL = URLforPath(path, query: query)
        return buildRequestWithURL(URL, HTTPMethod: "GET")
    }
    
    
    //MARK : POST
    
    static func POST(path path: String, body: AnyObject?, contentType:String) -> NSMutableURLRequest {
        let URL = URLforPath(path)
        let request = buildRequestWithURL(URL, HTTPMethod: "POST", contentType: contentType)
        
        if let bodyDictionary = body {
            
            request.HTTPBody = try! JSONParser.dataWithObject(bodyDictionary)
        }
        
        return request
    }
    
    static func POST(URL:NSURL) -> NSMutableURLRequest {
        return buildRequestWithURL(URL, HTTPMethod: "POST")
    }
    
    static func POST(path path: String, body: AnyObject?) -> NSMutableURLRequest {
        let URL = URLforPath(path)
        let request = buildRequestWithURL(URL, HTTPMethod: "POST")
        
        if let bodyDictionary = body {
            
            let data = try! JSONParser.dataWithObject(bodyDictionary) as NSData
            request.HTTPBody = data
            request.setValue("\(data.length)", forHTTPHeaderField: "Content-Length")

        }
        
        return request
    }
    
    //MARK : PUT
    
    static func PUT(path path: String, body: AnyObject?) -> NSMutableURLRequest {
        let URL = URLforPath(path)
        let request = buildRequestWithURL(URL, HTTPMethod: "PUT")
        
        if let bodyDictionary = body {
            
            request.HTTPBody = try! JSONParser.dataWithObject(bodyDictionary)
        }
        
        return request
    }
    
    //MARK : DELETE
    
    static func DELETE(path path: String, body: AnyObject?) -> NSMutableURLRequest {
        let URL = URLforPath(path)
        let request = buildRequestWithURL(URL, HTTPMethod: "DELETE")
        
        if let bodyDictionary = body {
            
            request.HTTPBody = try! JSONParser.dataWithObject(bodyDictionary)
        }
        
        return request
    }
}
