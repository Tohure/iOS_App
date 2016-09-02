//
//  DefaultColors.swift
//  Culture
//
//  Created by J on 4/2/16.
//  Copyright © 2016 LIMAAPP E.I.R.L. All rights reserved.
//

import UIKit

extension UIColor {

    static func quickColorWith(red:Int, green:Int, blue:Int, alpha:CGFloat) -> UIColor {
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
    }
    
    static func watermelonColor() -> UIColor {
        return UIColor.quickColorWith(255, green: 78, blue: 92, alpha: 1.0)
    }
    
    static func backgroundBlack() -> UIColor {
        return UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 0.8)
    }
    
    static func darkGreyDefaultColor() -> UIColor  {
        return UIColor.quickColorWith(153, green: 153, blue: 153, alpha: 1.0)
    }
    
    static func lightGreyDefaultColor() -> UIColor  {
        return UIColor.quickColorWith(204, green: 204, blue: 204, alpha: 1.0)
    }
    
    static func greyDefaultColor() -> UIColor  {
        return UIColor.quickColorWith(102, green: 102, blue: 102, alpha: 1.0)
    }
    
    static func grayTextfieldBackground() -> UIColor {
        return UIColor.quickColorWith(85, green: 85, blue: 85, alpha: 1.0)
    }
    
    static func selectedButtonColor() -> UIColor  {
        return UIColor.quickColorWith(165, green: 165, blue: 165, alpha: 1.0)
    }
    
    static func unselectedButtonColor() -> UIColor  {
        return UIColor.quickColorWith(165, green: 165, blue: 165, alpha: 1.0)
    }
    
    //Category Colors
    
    static func urbanCategoryColor() -> UIColor {
        return UIColor.quickColorWith(96, green: 66, blue: 168, alpha: 1.0)
    }
    
    static func theaterCategoryColor() -> UIColor {
        return UIColor.quickColorWith(119, green: 159, blue: 40, alpha: 1.0)
    }
    
    static func peintureCategoryColor() -> UIColor {
        return UIColor.quickColorWith(99, green: 176, blue: 223, alpha: 1.0)
    }
    
    static func performanceCategoryColor() -> UIColor {
        return UIColor.quickColorWith(138, green: 168, blue: 88, alpha: 1.0)
    }
    
    static func patrimonioCategoryColor() -> UIColor {
        return UIColor.quickColorWith(210, green: 149, blue: 136, alpha: 1.0)
    }
    
    static func musicCategoryColor() -> UIColor {
        return UIColor.quickColorWith(215, green: 139, blue: 44, alpha: 1.0)
    }
    
    static func liteatureCategoryColor() -> UIColor {
        return UIColor.quickColorWith(93, green: 163, blue: 113, alpha: 1.0)
    }
    
    static func instalacionCategoryColor() -> UIColor {
        return UIColor.quickColorWith(142, green: 202, blue: 179, alpha: 1.0)
    }
    
    static func ilustracionCategoryColor() -> UIColor {
        return UIColor.quickColorWith(183, green: 27, blue: 93, alpha: 1.0)
    }
    
    static func photographyCategoryColor() -> UIColor {
        return UIColor.quickColorWith(222, green: 79, blue: 41, alpha: 1.0)
    }
    
    static func scultureCategoryColor() -> UIColor {
        return UIColor.quickColorWith(142, green: 210, blue: 231, alpha: 1.0)
    }
    
    static func designCategoryColor() -> UIColor {
        return UIColor.quickColorWith(223, green: 96, blue: 89, alpha: 1.0)
    }
    
    static func danceCategoryColor() -> UIColor {
        return UIColor.quickColorWith(201, green: 129, blue: 162, alpha: 1.0)
    }
    
    static func circusCategoryColor() -> UIColor {
        return UIColor.quickColorWith(179, green: 37, blue: 32, alpha: 1.0)
    }
    
    static func cineCategoryColor() -> UIColor {
        return UIColor.quickColorWith(229, green: 158, blue: 54, alpha: 1.0)
    }
    
    static func audiovisualCategoryColor() -> UIColor {
        return UIColor.quickColorWith(87, green: 106, blue: 173, alpha: 1.0)
    }
    
    static func architectureCategoryColor() -> UIColor {
        return UIColor.quickColorWith(190, green: 193, blue: 210, alpha: 1.0)
    }
    
    //Basic Colors
    
    
    static func appRedColor() -> UIColor {
        return UIColor.quickColorWith(251, green: 52, blue: 75, alpha: 1.0)
    }
    
    static func appGrayColor() -> UIColor {
        return UIColor.quickColorWith(153, green: 153, blue: 153, alpha: 1.0)
    }
    
    static func transparentBlack() -> UIColor {
        return UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.8)
    }
}

