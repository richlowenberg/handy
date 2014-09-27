//
//  TouchCollection.swift
//  Handy
//
//  Created by Steven Vlaminck on 9/27/14.
//  Copyright (c) 2014 SwiftHack. All rights reserved.
//

import Foundation
import UIKit

private var points = [CGPoint]()

func addPoint(point:CGPoint) {
	points.append(point)
}

func startPoint() -> CGPoint {
	if points.count == 0 {
		return CGPointZero
	}
	return points[0]
}

func middlePoint() -> CGPoint {
	if points.count == 0 {
		return CGPointZero
	}
	return points[Int(points.count / 2)]
}

func endPoint() -> CGPoint {
	if points.count == 0 {
		return CGPointZero
	}
	return points[points.count - 1]
}

