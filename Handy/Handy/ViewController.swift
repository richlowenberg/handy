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

	let handy = HandyGeometry()
    
	override func viewDidLoad() {
		super.viewDidLoad()
		
        if let resultLabel = resultLabel? {
            resultLabel.text = "Swipe me!"
        }
	}
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//        println(touches)
	}

    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
		if touches.count == 1 {
			if let touch = touches.anyObject() as? UITouch {
				handy.addPoint(touch.locationInView(self.view))
			}
		}
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
//        println(touches)

		handy.calculateConfidence()

		println("User is \(handy.side.toRaw()) handed. Calculated with \(handy.confidence * 100)% confidence")
	}

}

