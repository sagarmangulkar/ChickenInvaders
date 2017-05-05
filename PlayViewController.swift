//
//  PlayViewController.swift
//  Chicken_Invaders
//
//  Created by Mac on 5/8/17.
//  Copyright © 2017 Sagar. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {
    
    @IBOutlet var imageChiecken1: UIImageView!
    @IBOutlet var buttonLeft: UIButton!
    @IBOutlet var buttonUp: UIButton!
    @IBOutlet var buttonDown: UIButton!
    @IBOutlet var buttonRight: UIButton!
    @IBOutlet var imageHero: UIImageView!
    let motionDistance = 50         //motion distance when push navigation panel button
    var xChickenMotion = 0
    var yChickenMotion = 0
    var isUpward = false
    var isRightward = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timers()
        //moveChicken()
        //moveChickenInCurveMotion()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func timers(){
        var timerMoveChicken = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(moveChicken), userInfo: 55, repeats: true)
        var timerCheckCollision = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(intersect), userInfo: nil, repeats: true)
        var timerStopMoveChicken = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(stopTimerMoveChiken), userInfo: timerMoveChicken, repeats: false)
    }
    
    @IBAction func pushButtonUp(_ sender: Any) {
        //move hero up
        if (imageHero.frame.origin.y > 30) {
            UIView.animate(withDuration: 0.5, animations: {
                var frameTemp = self.imageHero.frame
                frameTemp.origin.y = frameTemp.origin.y - CGFloat(self.motionDistance)
                self.imageHero.frame = frameTemp
            })
        }
    }
    @IBAction func pushButtonDown(_ sender: Any) {
        //move hero down
        if (imageHero.frame.origin.y < 450) {
            UIView.animate(withDuration: 0.5, animations: {
                var frameTemp = self.imageHero.frame
                frameTemp.origin.y = frameTemp.origin.y + CGFloat(self.motionDistance)
                self.imageHero.frame = frameTemp
            })
        }
    }
    @IBAction func pushButtonRight(_ sender: Any) {
        //move hero right
        if (imageHero.frame.origin.x < 280) {
            UIView.animate(withDuration: 0.5, animations: {
                var frameTemp = self.imageHero.frame
                frameTemp.origin.x = frameTemp.origin.x + CGFloat(self.motionDistance)
                self.imageHero.frame = frameTemp
            })
        }
    }
    @IBAction func pushButtonLeft(_ sender: Any) {
        //move hero left
        if (imageHero.frame.origin.x > 30) {
            UIView.animate(withDuration: 0.5, animations: {
                var frameTemp = self.imageHero.frame
                frameTemp.origin.x = frameTemp.origin.x - CGFloat(self.motionDistance)
                self.imageHero.frame = frameTemp
            })
        }
    }
    
    func stopTimerMoveChiken(timerTemp:Timer) {
        let timer1 = timerTemp.userInfo as! Timer
        guard timer1 != nil else { return }
        timer1.invalidate()
        //timer1 = nil
    }
    
    func moveChicken(timer:Timer){
        print(timer.userInfo as! Int)
        //up down motion of chicken
        if (imageChiecken1.frame.origin.y < 450 && !(imageChiecken1.frame.origin.y > 450) && !isUpward) {
            yChickenMotion = 6
        }
        else if (imageChiecken1.frame.origin.y > 450){
            yChickenMotion = -6
            isUpward = true
        }
        else if (imageChiecken1.frame.origin.y < 50) {
            isUpward = false
        }
 
        //left right motion of chicken
        if (imageChiecken1.frame.origin.x > 20 && !(imageChiecken1.frame.origin.x < 20) && !isRightward) {
            xChickenMotion = -4
           // print("1)")
            //print(xChickenMotion)
        }
        else if (imageChiecken1.frame.origin.x < 20){
            xChickenMotion = 4
            isRightward = true
           // print("2)")
            //print(xChickenMotion)
        }
        else if (imageChiecken1.frame.origin.x > 275) {
            isRightward = false
        }
 
        UIView.animate(withDuration: 0.05, animations: {
            var frameTemp = self.imageChiecken1.frame
            frameTemp.origin.x = frameTemp.origin.x + CGFloat(self.xChickenMotion)
            frameTemp.origin.y = frameTemp.origin.y + CGFloat(self.yChickenMotion)
            self.imageChiecken1.frame = frameTemp
        })
        
    }
    
    func intersect(){
        //print(imageHero.layer.frame.origin.x)
        if(imageChiecken1.layer.frame.intersects(imageHero.layer.frame)){
            print("Collide...!")
        }
    }
}
