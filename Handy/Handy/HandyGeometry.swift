//
//  HandyGeometry.swift
//  Handy
//
//  Created by Rich on 9/27/14.
//  Copyright (c) 2014 SwiftHack. All rights reserved.
//

import Foundation
import UIKit

enum HandPosition {
    case left
    case right
}

struct TouchArcGeometry {
    let start:CGPoint
    let middle:CGPoint
    let end:CGPoint
    
    init(start:CGPoint, middle:CGPoint, end:CGPoint) {
        self.start = start;
        self.middle = middle;
        self.end = end;
    }
    
    func distanceFromTouchArcHypotenuse() -> CGFloat {
        let xLength:CGFloat = self.start.x - self.end.x
        let yLength:CGFloat = self.start.y - self.end.y
        let hypotenuse:CGFloat = sqrt(xLength * xLength + yLength * yLength);
        
        // radians are degrees * 0.0174532925
        // tan(angle) = opposite / adjacent
        let angle = atan(xLength/yLength)
        
        let middleX = (self.middle.y - self.start.y) * tan(angle)
        
        return self.middle.x - (self.start.x + middleX)
    }
}