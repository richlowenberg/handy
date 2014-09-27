//
//  FinalScreen.swift
//  Handy
//
//  Created by Rich on 9/27/14.
//  Copyright (c) 2014 SwiftHack. All rights reserved.
//

import UIKit

class FinalScreen : UIViewController {
    
    @IBOutlet var leftHandImage:UIImageView!
    @IBOutlet var rightHandImage:UIImageView!
    
    func showResults(handPosition:HandPosition, confidence:CGFloat) {
        self.title = "HANDY"
        
        switch(handPosition) {
        case .left:
            let image = UIImage(named: "rightHand")
            self.leftHandImage.hidden = false
            self.rightHandImage.hidden = true
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: "startAgain")
            self.navigationItem.leftBarButtonItem = nil
            
        case .right:
            let image = UIImage(named: "leftHand")
            self.leftHandImage.hidden = true
            self.rightHandImage.hidden = false
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: "startAgain")
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    
    func startAgain() {
        self.performSegueWithIdentifier("home", sender: self)
    }
}