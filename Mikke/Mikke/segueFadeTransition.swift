//
//  segueFadeTransition.swift
//  Mikke
//
//  Created by Yuko Katsuda on 2016/07/26.
//  Copyright © 2016年 Yuko Katsuda. All rights reserved.
//

import UIKit

class segueFadeTransition: UIStoryboardSegue {
    override func perform() {
        // Assign the source and destination views to local variables.
        let firstVCView = self.sourceViewController.view as UIView!
        let secondVCView = self.destinationViewController.view as UIView!
        
        // Get the screen width and height.
        //let screenWidth = UIScreen.mainScreen().bounds.size.width
        //let screenHeight = UIScreen.mainScreen().bounds.size.height
        
        // Specify the initial position of the destination view.
        //secondVCView.frame = CGRectMake(0.0, screenHeight, screenWidth, screenHeight)
        //firstVCView.layer.opacity = 1
        secondVCView.layer.opacity = 0
        
        // Access the app's key window and insert the destination view above the current (source) one.
        let window = UIApplication.sharedApplication().keyWindow
        window?.insertSubview(secondVCView, aboveSubview: firstVCView)
        
        // Animate the transition.
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            //firstVCView.layer.opacity = 0
            secondVCView.layer.opacity = 1
            
            }) { (Finished) -> Void in
                self.sourceViewController.presentViewController(self.destinationViewController as UIViewController,
                    animated: false,
                    completion: nil)
        }
        
    }
}
