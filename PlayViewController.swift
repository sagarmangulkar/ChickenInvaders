//
//  PlayViewController.swift
//  Chicken_Invaders
//
//  Created by Mac on 5/8/17.
//  Copyright © 2017 Sagar. All rights reserved.
//

import UIKit
import AVFoundation

class PlayViewController: UIViewController {
    
    @IBOutlet var buttonPlayAgain: UIButton!
    @IBOutlet var imageGameOver: UIImageView!
    @IBOutlet var imageNextLevel: UIImageView!
    @IBOutlet var imageChicken3: UIImageView!
    @IBOutlet var imageEgg1: UIImageView!
    @IBOutlet var buttonAttackSingleGunShot: UIButton!
    @IBOutlet var imageAttackSingleGunShot: UIImageView!
    @IBOutlet var imageHealthHero: UIImageView!
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
    var isChicken1 = true
    private var timerMoveChicken1: Timer?
    private var timerMoveChicken2: Timer?
    private var timerMoveChicken3: Timer?
    private var timerBlinkHero: Timer?
    private var timerAttack: Timer?
    private var timerHideBlast: Timer?
    private var timerReleaseEgg: Timer?
    var levelCount = 0
    var isGameOver = false
    
    var i =  0
    var healthHero = 100
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timers()
        //moveChicken()
        //moveChickenInCurveMotion()
        repeatTimers()
        startingState()
        releaseEggs()
        player?.stop()
        playSound(tempSoundFileName: "Futuristic_music")
    }
    
    func releaseEggs(){
        startTimerReleaseEgg(timeTemp: 0.05, imageTemp: imageEgg1)
        
    }
    
    func startingState(){
        imageHealthHero.image = UIImage(named:"healthbar_100.png")
        imageAttackSingleGunShot.isHidden = true
        imageChicken1.frame.origin.y = -600
        imageChicken2.frame.origin.y = -600
        imageChicken3.frame.origin.y = -600
        imageChicken1.isHidden = false
        imageChicken2.isHidden = true
        imageChicken3.isHidden = true
        imageNextLevel.isHidden = true
        imageGameOver.isHidden = true
        buttonPlayAgain.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var player: AVAudioPlayer?
    
    func playSound(tempSoundFileName: String) {
        let url = Bundle.main.url(forResource: tempSoundFileName, withExtension: "mp3")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }

    func repeatTimers(){
        var timerCheckCollision = Timer.scheduledTimer(timeInterval: 19, target: self, selector: #selector(timers), userInfo: nil, repeats: true)
    }
    
    func timers(){
        timerMoveChicken1 = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(moveChicken), userInfo: imageChicken1, repeats: true)
        var timerCheckCollision = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkCollisionBetweenHeroAndChicken), userInfo: nil, repeats: true)
        var timerStopMoveChicken1 = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(stopTimerMoveChicken1), userInfo: nil, repeats: false)
        var timerStopMoveChicken2 = Timer.scheduledTimer(timeInterval: 12, target: self, selector: #selector(stopTimerMoveChicken2), userInfo: nil, repeats: false)
         var timerStopMoveChicken3 = Timer.scheduledTimer(timeInterval: 18, target: self, selector: #selector(stopTimerMoveChicken3), userInfo: nil, repeats: false)
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
    
    
    @IBAction func pushButtonAttackSingleGunShot(_ sender: Any) {
        startTimerAttack(timeTemp: 0.05)
    }
    

    func stopTimerMoveChicken1() {
        guard timerMoveChicken1 != nil else { return }
        timerMoveChicken1?.invalidate()
        timerMoveChicken1 = nil
        
        timerMoveChicken2 = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(moveChicken), userInfo: imageChicken2, repeats: true)
        releaseEggs()

        imageNextLevel.isHidden = true
        buttonAttackSingleGunShot.isHidden = false
    }
    
    
    func stopTimerMoveChicken2() {
        guard timerMoveChicken2 != nil else { return }
        timerMoveChicken2?.invalidate()
        timerMoveChicken2 = nil
        releaseEggs()
        timerMoveChicken3 = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(moveChicken), userInfo: imageChicken3, repeats: true)
        releaseEggs()

    }
    
    
    func stopTimerMoveChicken3() {
        guard timerMoveChicken3 != nil else { return }
        timerMoveChicken3?.invalidate()
        timerMoveChicken3 = nil
        releaseEggs()
        
    }
    
    func stopTimerBlinkHero() {
        guard timerBlinkHero != nil else { return }
        timerBlinkHero?.invalidate()
        timerBlinkHero = nil
        isAttacked = false
        imageHero.isHidden = false
    }
    
    func startTimerAttack(timeTemp: Double)-> Void {
        guard timerAttack == nil else { return }
        imageAttackSingleGunShot.isHidden = false
        imageAttackSingleGunShot.frame.origin.x = imageHero.frame.origin.x + 20
        imageAttackSingleGunShot.frame.origin.y = imageHero.frame.origin.y
        timerAttack = Timer.scheduledTimer(timeInterval: timeTemp, target: self, selector: #selector(attack), userInfo: nil, repeats: true)
    }
    
    func stopTimerAttack() {
        guard timerAttack != nil else { return }
        timerAttack?.invalidate()
        timerAttack = nil
        imageAttackSingleGunShot.isHidden = true
    }
    
    func startTimerReleaseEgg(timeTemp: Double, imageTemp: UIImageView)-> Void {
        guard timerReleaseEgg == nil else { return }
        imageTemp.isHidden = false
        
        if(isChicken1){
            isChicken1 = false
            if(!imageChicken1.isHidden){
                imageTemp.frame.origin.x = imageChicken1.frame.origin.x + 20
                imageTemp.frame.origin.y = imageChicken1.frame.origin.y + 40
            }
            else{
                imageTemp.frame.origin.x = imageChicken2.frame.origin.x + 20
                imageTemp.frame.origin.y = imageChicken2.frame.origin.y + 40
            }
        }
        else if(!isChicken1){
            isChicken1 = true
            if(!imageChicken2.isHidden){
                imageTemp.frame.origin.x = imageChicken2.frame.origin.x + 20
                imageTemp.frame.origin.y = imageChicken2.frame.origin.y + 40
            }
            else{
                imageTemp.frame.origin.x = imageChicken1.frame.origin.x + 20
                imageTemp.frame.origin.y = imageChicken1.frame.origin.y + 40
            }
        }
        else{
            if(!imageChicken3.isHidden){
                imageTemp.frame.origin.x = imageChicken3.frame.origin.x + 20
                imageTemp.frame.origin.y = imageChicken3.frame.origin.y + 40
            }
            if(!imageChicken1.isHidden){
                imageTemp.frame.origin.x = imageChicken1.frame.origin.x + 20
                imageTemp.frame.origin.y = imageChicken1.frame.origin.y + 40
            }
            if(!imageChicken2.isHidden){
                imageTemp.frame.origin.x = imageChicken2.frame.origin.x + 20
                imageTemp.frame.origin.y = imageChicken2.frame.origin.y + 40
            }
        }
        
        if(!imageChicken1.isHidden && !imageChicken2.isHidden){
            imageEgg1.isHidden = false
        }
        else if(imageChicken1.isHidden && imageChicken2.isHidden){
            imageEgg1.isHidden = true
        }
        timerReleaseEgg = Timer.scheduledTimer(timeInterval: timeTemp, target: self, selector: #selector(releaseEgg), userInfo: imageTemp, repeats: true)
    }
    
    func stopTimerReleaseEgg(imageTemp:UIImageView) {
        guard timerReleaseEgg != nil else { return }
        timerReleaseEgg?.invalidate()
        timerReleaseEgg = nil
        imageTemp.isHidden = true
    }
    
    func startTimerHideBlast(timeTemp: Double, imageTemp: UIImageView)-> Void {
        print("Inside Timer...1")
        timerHideBlast = Timer.scheduledTimer(timeInterval: timeTemp, target: self, selector: #selector(hideBlast), userInfo: imageTemp, repeats: false)
    }
    
    func hideBlast(timer:Timer?){
        print("Hiding....!")
        let imageTemp = timer?.userInfo as! UIImageView
        imageTemp.isHidden = true
        imageTemp.image = UIImage(named:"Chicken1.png")
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
    
    func attack(){
        UIView.animate(withDuration: 0.05, animations: {
            var frameTemp = self.imageAttackSingleGunShot.frame
            frameTemp.origin.y = frameTemp.origin.y - 20
            self.imageAttackSingleGunShot.frame = frameTemp
        },completion:{
            (finished: Bool) in
            if(self.imageAttackSingleGunShot.frame.origin.y < -100){
                UIView.animate(withDuration: 0, animations: {
                    var frameTemp = self.imageAttackSingleGunShot.frame
                    frameTemp.origin.y = 400
                    self.imageAttackSingleGunShot.frame = frameTemp
                    self.stopTimerAttack()
                })
            }
        })
    }
    
    func releaseEgg(timer:Timer?){
        let imageTemp = timer?.userInfo as! UIImageView
        UIView.animate(withDuration: 0.05, animations: {
            var frameTemp = imageTemp.frame
            frameTemp.origin.y = frameTemp.origin.y + 10
            imageTemp.frame = frameTemp
        },completion:{
            (finished: Bool) in
            if(imageTemp.frame.origin.y > 600){
                UIView.animate(withDuration: 0, animations: {
                    var frameTemp = imageTemp.frame
                    frameTemp.origin.y = 100
                    imageTemp.frame = frameTemp
                    self.stopTimerReleaseEgg(imageTemp: imageTemp)
                })
            }
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
        if((imageHero.layer.frame.intersects(imageChicken1.layer.frame) && (!imageChicken1.isHidden)) || (imageHero.layer.frame.intersects(imageChicken2.layer.frame)) && (!imageChicken2.isHidden) || (imageHero.layer.frame.intersects(imageChicken3.layer.frame)) && (!imageChicken3.isHidden)){
            if(!imageHero.isHidden && !isAttacked){
                print("Collide...!")
                isAttacked = true
                lowerHealth()
            }
        }
        
        if(imageHero.layer.frame.intersects(imageEgg1.layer.frame)) && (!imageEgg1.isHidden){
            if(!imageHero.isHidden && !isAttacked){
                print("Hero Collide with Egg...!")
                isAttacked = true
                lowerHealth()
                imageEgg1.isHidden = true
            }
        }

        checkCollisionBetweenAttackShootAndChicken()
    }
    
    
    func checkCollisionBetweenAttackShootAndChicken(){
        if((imageAttackSingleGunShot.layer.frame.intersects(imageChicken1.layer.frame) && (!imageChicken1.isHidden))){
            if(!imageAttackSingleGunShot.isHidden){
                print("Collide with shoot...!")
                killChicken(imageTemp: imageChicken1)
            }
        }
        
        if((imageAttackSingleGunShot.layer.frame.intersects(imageChicken2.layer.frame)) && (!imageChicken2.isHidden)){
            if(!imageAttackSingleGunShot.isHidden){
                print("Collide with shoot...!")
                killChicken(imageTemp: imageChicken2)
            }
        }
        
        if((imageAttackSingleGunShot.layer.frame.intersects(imageChicken3.layer.frame)) && (!imageChicken3.isHidden)){
            if(!imageAttackSingleGunShot.isHidden){
                print("Collide with shoot...!")
                killChicken(imageTemp: imageChicken3)
            }
        }
        if(isGoToNextLevel()){
            levelCount += 1
            imageNextLevel.isHidden = false
            buttonAttackSingleGunShot.isHidden = true
            print("Next level")
            print(levelCount)
            imageChicken1.frame.origin.y = -600
            imageChicken2.frame.origin.y = -600
            imageChicken3.frame.origin.y = -600
            if(levelCount == 1){
                imageChicken1.isHidden = false
                imageChicken2.isHidden = false
                imageChicken3.isHidden = true
            }
            else if(levelCount == 2){
                imageChicken1.isHidden = false
                imageChicken2.isHidden = false
                imageChicken3.isHidden = false
            }
            
        }
    }
    
    func isGoToNextLevel() -> Bool{
        print(imageChicken1.isHidden)
        print(imageChicken2.isHidden)
        print(imageChicken3.isHidden)
        print("----------")
        if(imageChicken1.isHidden && imageChicken2.isHidden && imageChicken3.isHidden){
            return true
        }
        return false
    }
    
    func killChicken(imageTemp: UIImageView){
        //imageTemp.isHidden = true
        
        imageTemp.loadGif(name:"blast")
        startTimerHideBlast(timeTemp: 1.2, imageTemp: imageTemp)
        imageAttackSingleGunShot.isHidden = true
        print("Chicken killed...!")
        
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
    
    func lowerHealth(){
        i = 0
        timerBlinkHero = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(blinkHero), userInfo: nil, repeats: true)
        print("Attack on Hero...!")
        healthHero -= 25
        if(healthHero == 100){
            imageHealthHero.image = UIImage(named:"healthbar_100.png")
        }
        else if(healthHero == 75){
            imageHealthHero.image = UIImage(named:"healthbar_75.png")
        }
        else if(healthHero == 50){
            imageHealthHero.image = UIImage(named:"healthbar_50.png")
        }
        else if(healthHero == 25){
            imageHealthHero.image = UIImage(named:"healthbar_25.png")
        }
        else if(healthHero == 0){
            imageHealthHero.image = UIImage(named:"healthbar_00.png")
            gameOver()
        }
    }
    
    func gameOver(){
        isGameOver = true
        player?.stop()
        imageHero.loadGif(name:"blast")
        startTimerHideBlast(timeTemp: 1.2, imageTemp: imageHero)
        
        stopTimerBlinkHero()
        stopTimerAttack()
        stopTimerMoveChicken1()
        stopTimerMoveChicken2()
        stopTimerMoveChicken3()
        
        timerAttack?.invalidate()
        //timerMoveChicken1?.invalidate()
        timerReleaseEgg?.invalidate()
        timerBlinkHero?.invalidate()
        
        imageNextLevel.isHidden = true
        imageChicken1.isHidden = true
        imageChicken2.isHidden = true
        imageChicken3.isHidden = true
        buttonAttackSingleGunShot.isHidden = true
        imageEgg1.isHidden = true
        imageGameOver.isHidden = false
        buttonPlayAgain.isHidden = false
    }
    
    
}
