//
//  Noticia.swift
//  RppApp_iOS
//
//  Created by Huamán Torres, Carlo Renzo on 20/08/16.
//  Copyright © 2016 Grupo RPP. All rights reserved.
//

import UIKit

class Noticia: NSObject {
    
    struct NoticiaJSONKeys {
        static let noticiaID = "id"
        static let nid = "nid"
        static let timestamp = "timestamp"
        static let fecha = "fecha"
        static let hora = "hora"
        static let tipo = "tipo"
        static let seccion = "seccion"
        static let slug = "slug"
        static let titular = "titular"
        static let titularCorto = "titularCorto"
        static let gorro = "gorro"
        static let linkImg = "linkImg"
        static let fuenteFoto = "fuenteFoto"
        static let creditosFoto = "creditosFoto"
        static let elementoMultimedia = "elementoMultimedia"
        static let cuerpo = "cuerpo"
        static let seccionRuta = "seccionRuta"
    }
    
    var noticiaID: String!
    var nid: String!
    var timestamp: String!
    var fecha: String!
    var hora: String!
    var tipo: String!
    var seccion: String!
    var slug: String!
    var titular: String!
    var titularCorto: String!
    var gorro: String!
    var linkImg: String!
    var fuenteFoto: String!
    var creditosFoto: String!
    var elementoMultimedia: String!
    var cuerpo: String!
    var seccionRuta: String!
    
    init(jsonObject: [String:AnyObject]) {
        
        if let noticiaID = jsonObject[NoticiaJSONKeys.noticiaID] {
            self.noticiaID = noticiaID as! String
        }
        
        if let nid = jsonObject[NoticiaJSONKeys.nid] {
            self.nid = nid as! String
        }
        
        if let timestamp = jsonObject[NoticiaJSONKeys.timestamp] {
            self.timestamp = timestamp as! String
        }
        
        if let fecha = jsonObject[NoticiaJSONKeys.fecha] {
            self.fecha = fecha as! String
        }
        
        if let hora = jsonObject[NoticiaJSONKeys.hora] {
            self.hora = hora as! String
        }
        
        if let tipo = jsonObject[NoticiaJSONKeys.tipo] {
            self.tipo = tipo as! String
        }
        
        if let seccion = jsonObject[NoticiaJSONKeys.seccion] {
            self.seccion = seccion as! String
        }
        
        if let slug = jsonObject[NoticiaJSONKeys.slug] {
            self.slug = slug as! String
        }
        
        if let titular = jsonObject[NoticiaJSONKeys.titular] {
            self.titular = titular as! String
        }
        
        if let titularCorto = jsonObject[NoticiaJSONKeys.titularCorto] {
            self.titularCorto = titularCorto as! String
        }
        
        if let gorro = jsonObject[NoticiaJSONKeys.gorro] {
            self.gorro = gorro as! String
        }
        
        if let linkImg = jsonObject[NoticiaJSONKeys.linkImg] {
            self.linkImg = linkImg as! String
        }
        
        if let fuenteFoto = jsonObject[NoticiaJSONKeys.fuenteFoto] {
            self.fuenteFoto = fuenteFoto as! String
        }
        
        if let creditosFoto = jsonObject[NoticiaJSONKeys.creditosFoto] {
            self.creditosFoto = creditosFoto as! String
        }
        
        if let elementoMultimedia = jsonObject[NoticiaJSONKeys.elementoMultimedia] {
            self.elementoMultimedia = elementoMultimedia as! String
        }
        
        if let cuerpo = jsonObject[NoticiaJSONKeys.cuerpo] {
            self.cuerpo = cuerpo as! String
        }
        
        if let seccionRuta = jsonObject[NoticiaJSONKeys.seccionRuta] {
            self.seccionRuta = seccionRuta as! String
        }
    }        
    
}


