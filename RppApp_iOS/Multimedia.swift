//
//  Multimedia.swift
//  RppApp_iOS
//
//  Created by Huamán Torres, Carlo Renzo on 20/08/16.
//  Copyright © 2016 Grupo RPP. All rights reserved.
//

import UIKit

class Multimedia: NSObject {
    
    struct MultimediaJSONKeys {
        static let multimediaID = "id"
        static let nid = "nid"
        static let leyenda = "leyenda"
        static let fuente = "fuente"
        static let gorro = "gorro"
        static let creditos = "creditos"
        static let seccionSlug = "seccionSlug"
        static let urlElemento = "urlElemento"
    }
    
    var multimediaID :String!
    var nid :String!
    var leyenda :String!
    var fuente :String!
    var gorro :String!
    var creditos :String!
    var seccionSlug :String!
    var urlElemento :String!
    
    init(jsonObject: [String:AnyObject]) {
        
        if let multimediaID = jsonObject[MultimediaJSONKeys.multimediaID] {
            self.multimediaID = multimediaID as! String
        }
        
        if let nid = jsonObject[MultimediaJSONKeys.nid] {
            self.nid = nid as! String
        }
        
        if let leyenda = jsonObject[MultimediaJSONKeys.leyenda] {
            self.leyenda = leyenda as! String
        }
        
        if let fuente = jsonObject[MultimediaJSONKeys.fuente] {
            self.fuente = fuente as! String
        }
        
        if let gorro = jsonObject[MultimediaJSONKeys.gorro] {
            self.gorro = gorro as! String
        }
        
        if let creditos = jsonObject[MultimediaJSONKeys.creditos] {
            self.creditos = creditos as! String
        }
        
        if let seccionSlug = jsonObject[MultimediaJSONKeys.seccionSlug] {
            self.seccionSlug = seccionSlug as! String
        }
        
        if let urlElemento = jsonObject[MultimediaJSONKeys.urlElemento] {
            self.urlElemento = urlElemento as! String
        }
    }
    
}
