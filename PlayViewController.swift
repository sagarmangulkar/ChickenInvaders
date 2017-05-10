//
//  PlayViewController.swift
//  Chicken_Invaders
//
//  Created by Mac on 5/8/17.
//  Copyright © 2017 Sagar. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {
    
    @IBOutlet var imageChicken2: UIImageView!
    @IBOutlet var imageChicken1: UIImageView!
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
    var isAttacked = false
    private var timerMoveChicken1: Timer?
    private var timerMoveChicken2: Timer?
    private var timerBlinkHero: Timer?
    var i =  0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timers()
        //moveChicken()
        //moveChickenInCurveMotion()
        repeatTimers()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func repeatTimers(){
        var timerCheckCollision = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(timers), userInfo: nil, repeats: true)
    }
    
    func timers(){
        timerMoveChicken1 = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(moveChicken), userInfo: imageChicken1, repeats: true)
        var timerCheckCollision = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkCollisionBetweenHeroAndChicken), userInfo: nil, repeats: true)
        var timerStopMoveChicken1 = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(stopTimerMoveChicken1), userInfo: nil, repeats: false)
        var timerStopMoveChicken2 = Timer.scheduledTimer(timeInterval: 12, target: self, selector: #selector(stopTimerMoveChicken2), userInfo: nil, repeats: false)
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
    /*
     func stopTimerMoveChicken(timerTemp:Timer) {
     var timer1 = timerTemp.userInfo as! Timer
     //    guard timer1 != nil else { return }
     timer1.invalidate()
     //timer1 = nil
     }
     */
    func stopTimerMoveChicken1() {
        guard timerMoveChicken1 != nil else { return }
        timerMoveChicken1?.invalidate()
        timerMoveChicken1 = nil
        
        timerMoveChicken2 = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(moveChicken), userInfo: imageChicken2, repeats: true)
    }
    
    
    func stopTimerMoveChicken2() {
        guard timerMoveChicken2 != nil else { return }
        timerMoveChicken2?.invalidate()
        timerMoveChicken2 = nil
    }
    
    func stopTimerBlinkHero() {
        guard timerBlinkHero != nil else { return }
        timerBlinkHero?.invalidate()
        timerBlinkHero = nil
        isAttacked = false
        imageHero.isHidden = false
    }
    func moveChicken(timer:Timer){
        //up down motion of chicken
        let imageTemp = timer.userInfo as! UIImageView
        if (imageTemp.frame.origin.y < 450 && !(imageTemp.frame.origin.y > 450) && !isUpward) {
            yChickenMotion = 6
        }
        else if (imageTemp.frame.origin.y > 450){
            yChickenMotion = -6
            isUpward = true
        }
        else if (imageTemp.frame.origin.y < 50) {
            isUpward = false
        }
        
        //left right motion of chicken
        if (imageTemp.frame.origin.x > 20 && !(imageTemp.frame.origin.x < 20) && !isRightward) {
            xChickenMotion = -4
            // print("1)")
            //print(xChickenMotion)
        }
        else if (imageTemp.frame.origin.x < 20){
            xChickenMotion = 4
            isRightward = true
            // print("2)")
            //print(xChickenMotion)
        }
        else if (imageTemp.frame.origin.x > 275) {
            isRightward = false
        }
        
        UIView.animate(withDuration: 0.05, animations: {
            var frameTemp = imageTemp.frame
            frameTemp.origin.x = frameTemp.origin.x + CGFloat(self.xChickenMotion)
            frameTemp.origin.y = frameTemp.origin.y + CGFloat(self.yChickenMotion)
            imageTemp.frame = frameTemp
        })
        
    }
    
    /* func intersect(){
     //print(imageHero.layer.frame.origin.x)
     if(imageChicken1.layer.frame.intersects(imageHero.layer.frame)){
     print("Collide...!")
     }
     }
     */
    func checkCollisionBetweenHeroAndChicken(){
        if((imageHero.layer.frame.intersects(imageChicken1.layer.frame) && (!imageChicken1.isHidden)) || (imageHero.layer.frame.intersects(imageChicken2.layer.frame)) && (!imageChicken2.isHidden)){
            if(!imageHero.isHidden && !isAttacked){
                print("Collide...!")
                isAttacked = true
                lowerHealth()
            }
        }
    }
    
    func lowerHealth(){
        i = 0
         timerBlinkHero = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(blinkHero), userInfo: nil, repeats: true)
    }
    
    func blinkHero(){
        i += 1
        if(imageHero.isHidden){
            imageHero.isHidden = false
        }
        else if(!imageHero.isHidden){
            imageHero.isHidden = true
        }
        if(i == 7){
            stopTimerBlinkHero()
        }
    }
}
