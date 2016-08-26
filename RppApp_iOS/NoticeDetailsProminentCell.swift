//
//  NoticeDetailsProminentCell.swift
//  RppApp_iOS
//
//  Created by Luis on 25/08/16.
//  Copyright © 2016 Grupo RPP. All rights reserved.
//

import UIKit

class NoticeDetailsProminentCell: UITableViewCell {

    @IBOutlet weak var imageProminent: UIImageView!
    @IBOutlet weak var iconTypeNota: UIImageView!
    @IBOutlet weak var titleNota: UILabel!
    @IBOutlet weak var gorroNota: UILabel!
    @IBOutlet weak var seccionNotaLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadNoticia(noticia: Noticia) {
        
        self.titleNota.text = noticia.titular
        self.gorroNota.text = noticia.gorro
        self.seccionNotaLabel.text = noticia.seccion
        self.imageProminent.sd_setImageWithURL(NSURL(string: noticia.linkimg), placeholderImage: UIImage(named: "placeholder_img"))
        
        switch noticia.tipo {
        case "video":
            iconTypeNota.image = UIImage(named: "ic_video")
        case "audio":
            iconTypeNota.image = UIImage(named: "ic_audio")
        case "galeria":
            iconTypeNota.image = UIImage(named: "ic_galeria")
        case "infografia":
            iconTypeNota.image = UIImage(named: "ic_infografia")
        default:
            iconTypeNota.image = nil
            break
        }
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
