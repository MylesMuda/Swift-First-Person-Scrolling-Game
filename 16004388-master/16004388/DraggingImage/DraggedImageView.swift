//
//  DraggedImageView.swift
//  Myles_Test
//
//  Created by mm16aft on 08/12/2018.
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
        
        self.center = CGPoint(x: self.center.x+dx, y: self.center.y+dy)
        self.myDelegate?.ChangeBoundaries()
    }
    
    
    
}
