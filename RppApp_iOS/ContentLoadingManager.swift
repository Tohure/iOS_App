//
//  ContentLoadingManager.swift
//  
//
//  Created by Huamán Torres, Carlo Renzo on 20/08/16.
//  Copyright © 2016 Grupo RPP. All rights reserved.
//

import UIKit

protocol ContentLoadingManagerDelegate {

    func loadContent(contentLoading: ContentLoadingManager)
}

class ContentLoadingManager: NSObject {

    var contentAvailable = false
    var loadingContent = false
    var contentError : NSError?
    var delegate : ContentLoadingManagerDelegate?
    
    func setNeedsLoadContent() {
        
        NSObject.cancelPreviousPerformRequestsWithTarget(self, selector: #selector(ContentLoadingManager.loadContent), object: nil)
        self.performSelector(#selector(ContentLoadingManager.loadContent), withObject: nil, afterDelay: 0.1)
    }
    
    func loadContentIfNeeded() {
        
        if !self.loadingContent {
            self.loadContent()
        }
    }

    func loadContent() {
        contentError = nil
        self.delegate?.loadContent(self)
        self.loadingContent = true
    }
}
