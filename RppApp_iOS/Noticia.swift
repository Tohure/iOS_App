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
        static let titularcorto = "titularcorto"
        static let gorro = "gorro"
        static let linkimg = "linkimg"
        static let fuentefoto = "fuentefoto"
        static let creditos = "creditos"
        static let elemento = "elemento"
        static let desarrollo = "desarrollo"
        static let seccionruta = "seccionruta"
        static let bullets = "bullets"
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
    var titularcorto: String!
    var gorro: String!
    var linkimg: String!
    var fuentefoto: String!
    var creditos: String!
    var elemento: String!
    var desarrollo: String!
    var seccionruta: String!
    var urlBullets = [Multimedia]()
    
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
        
        if let titularcorto = jsonObject[NoticiaJSONKeys.titularcorto] {
            self.titularcorto = titularcorto as! String
        }
        
        if let gorro = jsonObject[NoticiaJSONKeys.gorro] {
            self.gorro = gorro as! String
        }
        
        
        if let linkimg = jsonObject[NoticiaJSONKeys.linkimg] {
            self.linkimg = linkimg as! String
        }
        
        if let fuentefoto = jsonObject[NoticiaJSONKeys.fuentefoto] {
            self.fuentefoto = fuentefoto as! String
        }
        
        if let creditos = jsonObject[NoticiaJSONKeys.creditos] {
            self.creditos = creditos as! String
        }
        
        if let elemento = jsonObject[NoticiaJSONKeys.elemento] {
            self.elemento = elemento as! String
        }
        
        if let desarrollo = jsonObject[NoticiaJSONKeys.desarrollo] {
            self.desarrollo = desarrollo as! String
        }
        
        if let seccionruta = jsonObject[NoticiaJSONKeys.seccionruta] {
            self.seccionruta = seccionruta as! String
        }
        
        
        if let multimedia = jsonObject[NoticiaJSONKeys.bullets] {
            
            for bullet in (multimedia as! [[String:AnyObject]]) {
                
                self.urlBullets.append(Multimedia(jsonObject: bullet))
            }
        }
    }
    
}


