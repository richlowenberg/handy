//
//  ViewController.swift
//  Handy
//
//  Created by Steven Vlaminck on 9/27/14.
//  Copyright (c) 2014 SwiftHack. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var resultLabel:UILabel!

	var handy: HandyGeometry?
    
	override func viewDidLoad() {
		super.viewDidLoad()
		
        if let resultLabel = resultLabel? {
            resultLabel.text = "Swipe me!"
        }
	}
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//        println(touches)

		handy = HandyGeometry()
	}

    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
		if touches.count == 1 {
			if let touch = touches.anyObject() as? UITouch {
				if let handy = handy {
					handy.addPoint(touch.locationInView(self.view))
				}
			}
		}
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
//        println(touches)

		if let handy = handy {
			handy.calculateConfidence()
			resultLabel.text = "\(handy.side.toRaw().uppercaseString) handed. S: \(handy.startPoint()), E: \(handy.endPoint())"
		}

//		println(resultLabel.text)
	}

}

