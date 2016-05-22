//
//  ViewController.swift
//  Hack MHS II
//
//  Created by alden lamp on 5/21/16.
//  Copyright © 2016 alden lamp. All rights reserved.
//

//
//  ViewController.swift
//  background animation
//
//  Created by alden lamp on 5/18/16.
//  Copyright © 2016 alden lamp. All rights reserved.
//

import UIKit


//background color fading
enum BackgroundDirection {
    case Up
    case Down
    case Stop
}
enum BackgroundNum{
    case First
    case Second
}


class ViewController: UIViewController {
    
    
    
    
    var animationFlag: BackgroundDirection = .Up
    
    var bgNumFlag: BackgroundNum = .First
    
    var lastState:BackgroundDirection?
    
    var bgScroll:UIImageView?
    var bgScroll2:UIImageView?
    
    
    
    
    
    
    override func viewDidLoad() {
        
        
        
        
        
        
        
        super.viewDidLoad()
        
        
        
        self.view.backgroundColor = UIColor.whiteColor()
        let height = self.view.frame.height
        let width = self.view.frame.width
        
        let viewSubviews = view.subviews
        //Two backgrounds
        bgScroll = UIImageView(frame: CGRectMake(0, 0, width, height * 3))
        bgScroll?.alpha = 0
        bgScroll?.contentMode = UIViewContentMode.ScaleAspectFill
        bgScroll?.image = UIImage(named: "bg")
        bgScroll?.userInteractionEnabled = false
//        self.view.superview?.insertSubview(bgScroll!, belowSubview: self.view)
        self.view.addSubview(bgScroll!)
        
        
        bgScroll2 = UIImageView(frame: CGRectMake(0, 0, width, height * 3))
        bgScroll2?.alpha = 0
        bgScroll2?.contentMode = UIViewContentMode.ScaleAspectFill
        bgScroll2?.userInteractionEnabled = false
//        self.view.superview?.insertSubview(bgScroll2!, belowSubview: self.view)
        self.view.addSubview(bgScroll2!)
        
        viewSubviews.forEach{  self.view.bringSubviewToFront($0)}
        
        //Initial fade in
        UIView.animateWithDuration(0, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.bgScroll?.alpha = 1.0
            }, completion: nil)
        delay(5.0) { () -> () in
            self.startAnimation()
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if animationFlag == .Stop && lastState != nil{
            animationFlag = lastState!
            startAnimation()
        }
    }
    
    //Animation for background color flow
    func startAnimation () {
        UIView.animateWithDuration(4.0, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
            if self.animationFlag == .Down {
                self.bgScroll!.frame.origin.y = -self.bgScroll!.frame.height + UIScreen.mainScreen().bounds.height
                self.bgScroll2!.frame.origin.y = -self.bgScroll2!.frame.height + UIScreen.mainScreen().bounds.height
                self.animationFlag = .Up
            } else if self.animationFlag == .Up {
                self.bgScroll!.frame.origin.y = 0
                self.bgScroll2!.frame.origin.y = 0
                self.animationFlag = .Down
            }
            self.lastState = self.animationFlag
            }, completion: { (finished: Bool) in
                if self.animationFlag != .Stop{
                    UIView.animateWithDuration(3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                        if self.animationFlag == .Up{
                            if self.bgNumFlag == .First{
                                self.bgScroll!.alpha = 0.0
                                self.bgScroll2!.image = self.randomizedBGColor()
                                self.bgScroll2!.alpha = 1.0
                                self.bgNumFlag = .Second
                            }else{
                                self.bgScroll!.image = self.randomizedBGColor()
                                self.bgScroll!.alpha = 1.0
                                self.bgScroll2!.alpha = 0.0
                                self.bgNumFlag = .First
                            }
                        }
                        
                        }, completion: { [weak self] finished in
                            self?.startAnimation()
                        })
                }
        })
    }
    
    //Background colors to pick from
    let bgColors = [UIColor(hex6: 0xfdb86b),UIColor(hex6: 0xe6a14b),UIColor(hex6: 0xfc5e6f),UIColor(hex6: 0xf3b93e),UIColor(hex6: 0x62cbfa),UIColor(hex6: 0xd08ab4),UIColor(hex6: 0xb8fbb4),UIColor(hex6: 0x2ffbfc)]
    
    //Random Color Set Picker
    func randomizedColorSet() -> Array<CGColor>{
        var arr = Array<CGColor>()
        let rand = arc4random() >> 1
        let randNum = Int(rand) % bgColors.count
        let firstColor = bgColors[randNum]
        arr.append(firstColor.CGColor)
        var rand2 = arc4random() >> 1
        var randNum2 = Int(rand2) % bgColors.count
        while randNum2 == randNum {
            rand2 = arc4random() >> 1
            randNum2 = Int(rand2) % bgColors.count
        }
        let secondColor = bgColors[randNum2]
        arr.append(secondColor.CGColor)
        return arr
    }
    //Single gradient from random colors
    func randomizedBGColor()->UIImage{
        let gradient = CAGradientLayer()
        gradient.backgroundColor = UIColor.greenColor().CGColor
        gradient.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height * 2)
        gradient.colors = randomizedColorSet()
        let image = imageFromLayer(gradient)
        return image
    }
    
    //Gradient layer to image
    func imageFromLayer(layer:CALayer) -> UIImage{
        UIGraphicsBeginImageContext(layer.frame.size)
        layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    //MARK: - Table View Delegate
    
}

