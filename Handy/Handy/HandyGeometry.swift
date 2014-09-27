//
//  HandyGeometry.swift
//  Handy
//
//  Created by Rich on 9/27/14.
//  Copyright (c) 2014 SwiftHack. All rights reserved.
//

import Foundation
import UIKit

enum HandPosition: String {
	case left = "left"
	case right = "right"
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

class HandyGeometry {

	var points = [CGPoint]()
    var confidence:CGFloat = 0.0
	var side: HandPosition = .right


	func calculateConfidence() {

		var totalDistance:CGFloat = 0.0

		for point: CGPoint in points {
			let geoObject = TouchArcGeometry(start: startPoint(), middle: point, end: endPoint())
			let distance = geoObject.distanceFromTouchArcHypotenuse()
			println(distance)
			totalDistance = totalDistance + distance
		}

		println("totalDistance: \(totalDistance)")

		let avg = CGFloat(totalDistance) / CGFloat(points.count)
        
        self.confidence = abs(avg / UIScreen.mainScreen().bounds.size.width);
		println("avg: \(avg)")

		if avg > 0 {
			side = .left
		} else {
			side = .right
		}

		// TODO: figure out confidence
	}

	func addPoint(point:CGPoint) {
		points.append(point)
	}

	func startPoint() -> CGPoint {
		if points.count == 0 {
			return CGPointZero
		}
		return points[0]
	}

	func endPoint() -> CGPoint {
		if points.count == 0 {
			return CGPointZero
		}
		return points[points.count - 1]
	}
	
}