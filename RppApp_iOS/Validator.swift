//
//  Validator.swift
//  Culture
//
//  Created by J on 3/19/16.
//  Copyright © 2016 LIMAAPP E.I.R.L. All rights reserved.
//

import Foundation

class Validator {
    
    class func regexToArray(regexPattern: String , string: String) -> NSArray {
        let data = NSMutableArray()
        
        let regEx = try! NSRegularExpression(pattern: regexPattern,
                                             options: [.CaseInsensitive])
        
        let range = NSMakeRange(0, string.characters.count)
        let matches = regEx.matchesInString(string, options: [], range: range)
        
        for match in matches {
            let replaceRange = match.rangeAtIndex(0)
            let uc = string[replaceRange]!
            data.addObject(uc)
        }
        
        return data
    }
   
}


public extension String {
    
    public var ns : NSString {return self as NSString}
    public subscript (aRange: NSRange) -> String? {
        get {return self.substringWithRange(self.rangeFromNSRange(aRange)!)}
    }
    
    func rangeFromNSRange(nsRange: NSRange) -> Range<String.Index>? {
        let from16 = utf16.startIndex.advancedBy(nsRange.location, limit: utf16.endIndex)
        let to16 = from16.advancedBy(nsRange.length, limit: utf16.endIndex)
        if let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self) {
            return from ..< to
        }
        return nil
    }
    
    public var cdr: String {return isEmpty ? "" : String(characters.dropFirst())}
    
    public func toCamel() throws -> String {
        var s = self
        let regex = try NSRegularExpression(pattern: "_+(.)", options: [])
        let matches = regex.matchesInString(s, options:[], range:NSMakeRange(0, s.ns.length)).reverse()
        for match in matches {
            print("match = \(s[match.range]!)")
            let matchRange = s.rangeFromNSRange(match.range) // the whole match range
            let replaceRange = match.rangeAtIndex(1)         // range of the capture group
            let uc = s[replaceRange]!.uppercaseString
            s.replaceRange(matchRange!, with: uc)
        }
        if s.hasPrefix("_") {s = s.cdr}
        return s
    }
}
