//
//  Category.swift
//  
//
//  Created by Huamán Torres, Carlo Renzo on 20/08/16.
//  Copyright © 2016 Grupo RPP. All rights reserved.
//

import UIKit

class Category: NSObject {
    
    struct CategoryNames {
        
        static let portada = "Portada"
        
        static let politica = "Politica"
        
        static let actualidad = "Actualidad"
        
        static let deportes = "Deportes"
        
        static let entretenimiento = "Entretenimiento"
        
        static let peru = "Peru"
        
        static let  mundo = "Mundo"
        
        static let  economia = "Economia"
        
        static let vida = "Vida"
        
        static let tecno = "Tecno"
        
        static let viral = "Viral"
    }
    
    struct CategoryJSONKeys {
        static let categoryID = "id"
        static let name = "name"
        static let events = "eventsArray"
        static let selectedImage = "selectedImage"
        static let unselectedImage = "unselectedImage"
        static let active = "active"
        static let arrayOfCategoriesKey = "arrayOfCategoriesKey"
    }
    
    var categoryID: String!
    var name: String!
    var path: String!
    var active: Bool!
    
    init(name: String, path: String) {
        
        self.name = name
        self.path = path
    }
    
   
    static func getCategoryItems() -> [Category] {
        
        var category = [Category]()
        
        let teatro = Category(name: "PORTADA", path: "")
        category.append(teatro)
        
        let escultura = Category(name: "POLITICA", path: "politica")
        category.append(escultura)
        
        let literatura = Category(name: "ACTUALIDAD", path: "actualidad")
        category.append(literatura)
        
        let cine = Category(name: "DEPORTES", path: "deportes")
        category.append(cine)
        
        let musica = Category(name: "ENTRETENIMIENTO", path: "entretenimiento")
        category.append(musica)
        
        let fotografia = Category(name: "PERU", path: "peru")
        category.append(fotografia)
        
        let arquitectura = Category(name: "MUNDO", path: "mundo")
        category.append(arquitectura)
        
        let diseno = Category(name: "ECONOMIA", path: "economia")
        category.append(diseno)
        
        let pintura = Category(name: "VIDA", path: "vida")
        category.append(pintura)
        
        let danza = Category(name: "TECNO", path: "tecno")
        category.append(danza)
        
        let ilustracion = Category(name: "VIRAL", path: "viral")
        category.append(ilustracion)
        
        return category
    }
    
}
