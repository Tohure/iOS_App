//
//  MenuItemCell.swift
//  Culture
//
//  Created by J on 3/23/16.
//  Copyright © 2016 LIMAAPP E.I.R.L. All rights reserved.
//

import UIKit

class MenuItemCell: UITableViewCell {

    @IBOutlet weak var menuIconImageView: UIImageView!
    @IBOutlet var menuIconNotification: UIImageView!
    
    @IBOutlet weak var menuItemTitle: UILabel!
    @IBOutlet var menuNotificationCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
