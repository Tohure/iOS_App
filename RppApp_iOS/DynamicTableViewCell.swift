//
//  DynamicTableViewCell.swift
//  DynamicTableRows
//
//  Created by Tohure on 4/21/16.
//  Copyright © 2016 RPP All rights reserved.
//

import UIKit

class DynamicTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
