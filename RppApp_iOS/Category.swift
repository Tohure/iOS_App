//
//  Category.swift
//  Culture
//
//  Created by J on 3/24/16.
//  Copyright © 2016 LIMAAPP E.I.R.L. All rights reserved.
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
    var active: Bool!
    
    init(name: String) {
        
        self.name = name
    }
    
   
    static func getCategoryItems() -> [Category] {
        
        var category = [Category]()
        
        let teatro = Category(name: "PORTADA")
        category.append(teatro)
        
        let escultura = Category(name: "POLITICA")
        category.append(escultura)
        
        let literatura = Category(name: "ACTUALIDAD")
        category.append(literatura)
        
        let cine = Category(name: "DEPORTES")
        category.append(cine)
        
        let musica = Category(name: "ENTRETENIMIENTO")
        category.append(musica)
        
        let fotografia = Category(name: "PERU")
        category.append(fotografia)
        
        let arquitectura = Category(name: "MUNDO")
        category.append(arquitectura)
        
        let diseno = Category(name: "ECONOMIA")
        category.append(diseno)
        
        let pintura = Category(name: "VIDA")
        category.append(pintura)
        
        let danza = Category(name: "TECNO")
        category.append(danza)
        
        let ilustracion = Category(name: "VIRAL")
        category.append(ilustracion)
        
        return category
    }
    
}
