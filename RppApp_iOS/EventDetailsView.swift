//
//  EventDetailsView.swift
//  
//
//  Created by Tohure on 4/21/16.
//  Copyright © 2016 RPP All rights reserved.
//

import UIKit

protocol EventDetailsViewDelegate {
    func eventDetailsWasTap(eventDetailView:EventDetailsView)
}

class EventDetailsView: UIView {

    var delegate: EventDetailsViewDelegate?
    @IBOutlet weak var iconNotice: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconTypeNotice: UIImageView!
    
    
    var event : Noticia! {
        
        didSet {
        
            self.titleLabel.text = event.titular
            self.descriptionLabel.text = event.gorro
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
            default:
                iconTypeNotice.image = nil
                break
                
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
