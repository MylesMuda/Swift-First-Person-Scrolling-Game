//
//  DraggedImageView.swift
//  16004388
//
//  Created by mm16aft on 08/11/2018.
//  Copyright © 2018 mm16aft. All rights reserved.
//

import UIKit

class DraggedImageView: UIImageView {

    var startLocation:  CGPoint?
    var myDelegate: subViewDelegate?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        startLocation = touches.first?.location(in: self)
        
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let currentLocation = touches.first?.location(in: self)
        
        let dx = currentLocation!.x - startLocation!.x
        let dy = currentLocation!.y - startLocation!.y
        
        var centerPoint = CGPoint(x: self.center.x+dx, y: self.center.y+dy)
        
        let halfx = self.bounds.midX
        centerPoint.x = max(halfx, centerPoint.x)
        centerPoint.x = min(self.superview!.bounds.size.width - halfx, centerPoint.x)
        
        
        let halfy = self.bounds.midY
        centerPoint.y = max(halfy, centerPoint.y)
        centerPoint.y = min(self.superview!.bounds.size.height - halfy, centerPoint.y)
        
        self.center = centerPoint
        
        self.myDelegate?.ChangeBoundaries()
    }
}
