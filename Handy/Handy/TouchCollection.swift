//
//  TouchCollection.swift
//  Handy
//
//  Created by Steven Vlaminck on 9/27/14.
//  Copyright (c) 2014 SwiftHack. All rights reserved.
//

import Foundation
import UIKit


// MARK: THIS WILL EVENTUALLY MOVE ELSEWHERE AND THE FILE WILL BE DELETED


class HandyGeometry {

	var points = [CGPoint]()
	var confidence = 0.0
	var side: HandPosition = .right


	func calculateConfidence() {

		let totalDistance:CGFloat = 0.0

		for point: CGPoint in points {
			let geoObject = TouchArcGeometry(start: startPoint(), middle: point, end: endPoint())
//			totalDistance += geoObject.distanceFromTouchArcHypoteneuse(geoObject)
		}

		if totalDistance > 0 {
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
