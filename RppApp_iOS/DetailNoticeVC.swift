//
//  DetailNoticeVC.swift
//  RppApp_iOS
//
//  Created by Luis on 25/08/16.
//  Copyright © 2016 Grupo RPP. All rights reserved.
//

import UIKit

class DetailNoticeVC: UITableViewController {

    var currentShownEvent : Noticia!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(currentShownEvent.desarrollo)
        
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.setNeedsLayout()
        self.tableView.layoutIfNeeded()
        
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0) // Status bar inset
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DynamicCell", forIndexPath: indexPath) as! DynamicTableViewCell
        
        cell.titleLabel.text = currentShownEvent.titular
        //cell.bodyLabel.text = currentShownEvent.desarrollo
        
        let attrStr = try! NSAttributedString(
            data: currentShownEvent.desarrollo.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        cell.bodyLabel.attributedText = attrStr
        
        return cell
    }

}
