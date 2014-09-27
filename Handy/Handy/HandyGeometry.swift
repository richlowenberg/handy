//
//  HandyGeometry.swift
//  Handy
//
//  Created by Rich on 9/27/14.
//  Copyright (c) 2014 SwiftHack. All rights reserved.
//

import Foundation
import UIKit

enum handPosition {
    .left,
    .right
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
}

class HandyGeometry {
    
    func handPositionFromTouchArc(touchArc:TouchArcGeometry) -> handPosition {
        let xLength = touchArc.start.x - touchArc.end.x
        let yLength = touchArc.start.y - touchArc.end.y
        let hypotenuse = sqrt(xLength * xLength + yLength * yLength);
    }
    
}