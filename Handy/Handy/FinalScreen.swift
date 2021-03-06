//
//  FinalScreen.swift
//  Handy
//
//  Created by Rich on 9/27/14.
//  Copyright (c) 2014 SwiftHack. All rights reserved.
//

import UIKit

class FinalScreen : UIViewController {
    
    var handPosition:HandPosition?
    var confidence:CGFloat?

    @IBOutlet var leftHandImage:UIImageView!
    @IBOutlet var rightHandImage:UIImageView!
    @IBOutlet var resultLabel:UILabel!
    
    func showResults(handPosition:HandPosition, confidence:CGFloat) {
        self.handPosition = handPosition;
        self.confidence = confidence
    }

	override func viewDidLoad() {
		self.navigationItem.hidesBackButton = true
	}
    
	override func viewWillAppear(animated: Bool) {

        self.title = "HANDY"
        
        if let handPos = self.handPosition {
            switch(handPos) {
            case .left:
                let image = UIImage(named: "menu")
                self.leftHandImage.hidden = true
                self.rightHandImage.hidden = false
                self.navigationItem.rightBarButtonItem = nil
                self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: "startAgain")
                self.navigationItem.backBarButtonItem = nil
                self.resultLabel.text = "YOU ARE LEFT-HANDED"
                
            case .right:
                let image = UIImage(named: "menu")
                self.leftHandImage.hidden = false
                self.rightHandImage.hidden = true
                self.navigationItem.leftBarButtonItem = nil
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: "startAgain")
                self.navigationItem.backBarButtonItem = nil
                self.resultLabel.text = "YOU ARE RIGHT-HANDED"
            }
        }
    }

    func startAgain() {
		self.navigationController?.popToRootViewControllerAnimated(true)
//        self.performSegueWithIdentifier("home", sender: self)
    }
}
