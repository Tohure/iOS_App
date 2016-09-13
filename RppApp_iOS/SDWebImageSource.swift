//
//  SDWebImageSource.swift
//  ImageSlideshow
//
//  Created by Huamán Torres, Carlo Renzo on 20/08/16.
//  Copyright © 2016 Grupo RPP. All rights reserved.
//
//

import SDWebImage
import ImageSlideshow

public class SDWebImageSource: NSObject, InputSource {
    var url: NSURL
    var placeholder: UIImage?
    
    public init(url: NSURL) {
        self.url = url
        super.init()
    }
    
    public init(url: NSURL, placeholder: UIImage) {
        self.url = url
        self.placeholder = placeholder
        super.init()
    }
    
    public init?(urlString: String) {
        if let validUrl = NSURL(string: urlString) {
            self.url = validUrl
            self.placeholder = UIImage(named: "placeholder_img")
            super.init()
        } else {
            return nil
        }
    }
    
    @objc public func setToImageView(imageView: UIImageView) {
        imageView.sd_setImageWithURL(self.url, placeholderImage: self.placeholder)
    }
}