//
//  EventDetailsViewProminent.swift
//  RppApp_iOS
//
//  Created by Huamán Torres, Carlo Renzo on 25/08/16.
//  Copyright © 2016 Grupo RPP. All rights reserved.
//

import UIKit

protocol EventDetailsViewProminentDelegate {
    func eventDetailsWasTap(eventDetailViewProminent:EventDetailsViewProminent)
}

class EventDetailsViewProminent: UIView {
    
    var delegate: EventDetailsViewProminentDelegate?
    
    @IBOutlet weak var imageProminent: UIImageView!
    @IBOutlet weak var iconTypeNota: UIImageView!
    @IBOutlet weak var titleNota: UILabel!
    @IBOutlet weak var gorroNota: UILabel!
    @IBOutlet weak var seccionNotaLabel: UILabel!
    
    
    var event : Noticia! {
        
        didSet {
            
            self.titleNota.text = event.titular
            self.gorroNota.text = event.gorro
            self.seccionNotaLabel.text = event.seccion
            self.imageProminent.sd_setImageWithURL(NSURL(string: event.linkimg), placeholderImage: UIImage(named: "placeholder_img"))
            
            
            switch event.tipo {
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
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(EventDetailsViewProminent.tapView(_:)))
        addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
    }
    
    func tapView(tapGesture:UITapGestureRecognizer) {
        delegate?.eventDetailsWasTap(self)
    }
    
    
}