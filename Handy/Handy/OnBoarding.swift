//
//  OnBoarding.swift
//  Handy
//
//  Created by Rich on 9/27/14.
//  Copyright (c) 2014 SwiftHack. All rights reserved.
//

import UIKit

class OnBoarding : UIViewController, UIGestureRecognizerDelegate {
    
    var currentPage:Int = -1
    
    @IBOutlet var text1:UILabel!
    @IBOutlet var text2:UILabel!
    @IBOutlet var text3:UILabel!
    @IBOutlet var text4:UILabel!
    @IBOutlet var button:UIButton!
    @IBOutlet var scrollDown:UIView!
    @IBOutlet var yConstraint:NSLayoutConstraint!
    @IBOutlet var baseConstraint:NSLayoutConstraint!
    
    var handy: HandyGeometry?
    var confidenceMetrics:[CGFloat] = []

	override func viewWillAppear(animated: Bool) {
        self.title = "HANDY"
        self.showPage(0)
        
		let upSwipe = UISwipeGestureRecognizer(target: self, action: "swipe:")
		upSwipe.direction = UISwipeGestureRecognizerDirection.Up
		upSwipe.cancelsTouchesInView = false
		self.view.addGestureRecognizer(upSwipe)

		let downSwipe = UISwipeGestureRecognizer(target: self, action: "swipe:")
		downSwipe.direction = UISwipeGestureRecognizerDirection.Down
		downSwipe.cancelsTouchesInView = false
		self.view.addGestureRecognizer(downSwipe)

        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.Repeat | UIViewAnimationOptions.Autoreverse, animations: { () -> Void in
            self.baseConstraint.constant = 35
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

	override func viewWillDisappear(animated: Bool) {
		self.title = ""
	}
    
    func swipe(recognizer:UISwipeGestureRecognizer) {

		println(recognizer.direction.toRaw())

        switch (recognizer.direction) {
		case UISwipeGestureRecognizerDirection.Down:
			showPage(currentPage-1)
		case UISwipeGestureRecognizerDirection.Up:
			showPage(currentPage+1)
        default:
			println("uh oh")
        }
    }
    
    func showPage(pageNumber:Int) {
        if (pageNumber != currentPage && pageNumber >= 0 && pageNumber < 4) {
            println("Page \(pageNumber)")
            
            currentPage = pageNumber
            
            switch pageNumber {
            case 0:
                self.fadeView(text1, opacity: 1)
                self.fadeView(text2, opacity: 0)
                self.fadeView(text3, opacity: 0)
                self.fadeView(text4, opacity: 0)
                self.fadeView(button, opacity: 0)
                
                UIView.animateWithDuration(0.5, delay: 2.0, options: nil, animations: { () -> Void in
                    self.scrollDown.alpha = 1
                }, completion: nil)
                
            case 1:
                self.fadeView(text1, opacity: 1)
                self.fadeView(text2, opacity: 1)
                self.fadeView(text3, opacity: 0)
                self.fadeView(text4, opacity: 0)
                self.fadeView(button, opacity: 0)
                
                UIView.animateWithDuration(0.5, delay: 2.0, options: nil, animations: { () -> Void in
                    self.scrollDown.alpha = 0
                    }, completion: nil)
                
            case 2:
                self.fadeView(text1, opacity: 1)
                self.fadeView(text2, opacity: 1)
                self.fadeView(text3, opacity: 1)
                self.fadeView(text4, opacity: 0)
                self.fadeView(button, opacity: 0)
                
            default:
                self.fadeView(text1, opacity: 1)
                self.fadeView(text2, opacity: 1)
                self.fadeView(text3, opacity: 1)
                self.fadeView(text4, opacity: 1)
                self.fadeView(button, opacity: 1)
            }
            self.validateLabelsPosition()
        }
    }
    
    func fadeView(view:UIView, opacity:CGFloat) {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            view.alpha = opacity
        })
    }
    
    func validateLabelsPosition() {
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: nil, animations: ({
            let multiplier:CGFloat = CGFloat(self.currentPage)
            self.yConstraint.constant = 220.0 - (multiplier * 35)
            self.view.layoutIfNeeded()
        }), completion: nil)
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
            
            confidenceMetrics.append(handy.confidence)
        }
        
        println("Average: \(self.averageConfidence())")
    }
    
    func averageConfidence() -> CGFloat {
        return confidenceMetrics.reduce(0.0, combine: { (total, next) -> CGFloat in
            return total + next
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "finalScreen") {
            var finalScreen:FinalScreen = segue.destinationViewController as FinalScreen
            
            if let handy = handy {
                finalScreen.showResults(handy.side, confidence: handy.confidence)
            }
        }
    }
    
}