//
//  EventDetailsCell.swift
//  
//
//  Created by Tohure on 4/21/16.
//  Copyright © 2016 RPP All rights reserved.
//

import UIKit

class EventDetailsCell: UITableViewCell {
    
    @IBOutlet weak var iconNotice: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconTypeNotice: UIImageView!

    override func awakeFromNib() {
        
        super.awakeFromNib()
    }
    
    func loadNoticia(noticia: Noticia) {
        
        self.titleLabel.text = noticia.titular
        self.descriptionLabel.text = noticia.gorro
        self.iconNotice.sd_setImageWithURL(NSURL(string: noticia.linkimg), placeholderImage: UIImage(named: "placeholder_img"))
        
        switch noticia.tipo {
        case "video":
            iconTypeNotice.image = UIImage(named: "ic_video")
        case "audio":
            iconTypeNotice.image = UIImage(named: "ic_audio")
        case "galeria":
            iconTypeNotice.image = UIImage(named: "ic_galeria")
        case "infografia":
            iconTypeNotice.image = UIImage(named: "ic_infografia")
        default:
            iconTypeNotice.image = nil
            break
            
        }
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}