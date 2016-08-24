//
//  EventDetailsCell.swift
//  Culture
//
//  Created by Franti Saúl Huamán Mera on 4/21/16.
//  Copyright © 2016 LIMAAPP E.I.R.L. All rights reserved.
//

import UIKit

class EventDetailsCell: UITableViewCell {

    var eventDetailView = EventDetailsView()
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        eventDetailView =  NSBundle.mainBundle().loadNibNamed("EventDetailsView", owner: self, options: nil)[0] as! EventDetailsView
        eventDetailView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(eventDetailView)
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(0)-[view]-(0)-|", options: [], metrics: nil, views: ["view": eventDetailView]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(0)-[view]-(0)-|", options: [], metrics: nil, views: ["view": eventDetailView]))  
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}