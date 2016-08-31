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
        static let leyenda = "leyenda"
        static let fuente = "fuente"
        static let gorro = "gorro"
        static let creditos = "creditos"
        static let foto = "foto"
    }
    
    var leyenda :String!
    var fuente :String!
    var gorro :String!
    var creditos :String!
    var foto :String!
    
    init(jsonObject: [String:AnyObject]) {
        
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
        
        if let foto = jsonObject[MultimediaJSONKeys.foto] {
            
            let imageURLArray = foto.componentsSeparatedByString("dev.")
            
            if imageURLArray.count > 1 {
                self.foto = String(format: "http://%@",imageURLArray.last!)
            }else {
                self.foto = ""
            }
            
        }
        
    }
    
}
