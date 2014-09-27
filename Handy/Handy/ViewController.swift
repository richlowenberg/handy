//
//  ViewController.swift
//  Handy
//
//  Created by Steven Vlaminck on 9/27/14.
//  Copyright (c) 2014 SwiftHack. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var resultLabel:UILabel?;
    
	override func viewDidLoad() {
		super.viewDidLoad()
		
        if let resultLabel = resultLabel? {
            resultLabel.text = "Swipe me!"
        }
	}
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        println(touches)

		if touches.count == 1 {
			if let touch = touches.anyObject() as? UITouch {
				addPoint(touch.locationInView(self.view))
			}
		}

    }

    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        println(touches)
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        println(touches)

		let touchGeometry = TouchArcGeometry(start: startPoint(), middle: middlePoint(), end: endPoint())
		// TODO: something here :)
        println(touchGeometry)
    }

}

