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
    @IBOutlet weak var iconNotice: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconTypeNotice: UIImageView!
    @IBOutlet weak var seccionLabel: UILabel!
    
    
    var event : Noticia! {
        
        didSet {
            
            self.titleLabel.text = event.titular
            self.descriptionLabel.text = event.gorro
            self.seccionLabel.text = event.seccion
            self.iconNotice.sd_setImageWithURL(NSURL(string: event.linkimg), placeholderImage: UIImage(named: "placeholder_img"))
            
            
            switch event.tipo {
            case "video":
                iconTypeNotice.image = UIImage(named: "ic_video")
            case "audio":
                iconTypeNotice.image = UIImage(named: "ic_audio")
            case "galeria":
                iconTypeNotice.image = UIImage(named: "ic_galeria")
            case "infografia":
                iconTypeNotice.image = UIImage(named: "ic_infografia")
            default: break
                //iconTypeNotice.image = UIImage(named: String)
            }
            
            //            self.titleLabel.text = event.name
            //            self.categoryLabel.textColor = getEventTitleColor()
            //            self.placeLabel.text = event.placeName
            //            self.categoryLabel.text = event.displayCategoryInformation()
            //            self.priceLabel.text = event.payments.first?.displayPayment()
            //            self.dateLabel.text = event.EventDate
            //            self.timeLabel.text = event.EventTime + " hrs."
            
        }
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(EventDetailsView.tapView(_:)))
        addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
    }
    
    func tapView(tapGesture:UITapGestureRecognizer) {
        delegate?.eventDetailsWasTap(self)
    }
    
    
}