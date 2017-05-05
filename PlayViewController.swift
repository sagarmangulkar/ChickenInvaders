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
        var timerMoveChicken = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(moveChicken), userInfo: nil, repeats: true)
        var timerCheckCollision = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(intersect), userInfo: nil, repeats: true)
        
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
        moveChicken()
    }
    
    func moveChicken(){
        if (imageChiecken1.frame.origin.y < 450 && !(imageChiecken1.frame.origin.y > 450) && !isUpward) {
            yChickenMotion = 40
        }
        else if (imageChiecken1.frame.origin.y > 450){
            yChickenMotion = -40
            isUpward = true
        }
        else if (imageChiecken1.frame.origin.y < 50) {
            isUpward = false
        }
        
 /*       if (imageChiecken1.frame.origin.x < 200 && !(imageChiecken1.frame.origin.y > 200) && !isUpward) {
            xChickenMotion = 40
        }
        else if (imageChiecken1.frame.origin.y > 450){
            yChickenMotion = -40
            isUpward = true
        }
        else if (imageChiecken1.frame.origin.y < 50) {
            isUpward = false
        }
   */     
        UIView.animate(withDuration: 0.5, animations: {
            var frameTemp = self.imageChiecken1.frame
            frameTemp.origin.x = frameTemp.origin.x + CGFloat(self.xChickenMotion)
            frameTemp.origin.y = frameTemp.origin.y + CGFloat(self.yChickenMotion)
            print(self.yChickenMotion)
            self.imageChiecken1.frame = frameTemp
        })
        
    }
    
    func intersect(){
        //print(imageHero.layer.frame.origin.x)
        if(imageChiecken1.layer.frame.intersects(imageHero.layer.frame)){
            print("Collide...!")
        }
    }
    
    func moveChickenInCurveMotion() {
        /*let path = UIBezierPath()
         //path.addArc(withCenter: CGPoint(x: 100, y:100), radius: 30, startAngle: 30, endAngle: 140, clockwise: true)
         path.move(to: CGPoint(x: 16,y: 239))
         path.addCurve(to: CGPoint(x: 301, y: 239), controlPoint1: CGPoint(x: 136, y: 373), controlPoint2: CGPoint(x: 178, y: 110))
         
         let animate = CAKeyframeAnimation(keyPath: "position")
         animate.path = path.cgPath
         animate.rotationMode = kCAAnimationRotateAuto
         animate.repeatCount = Float.infinity
         animate.duration = 5.0
         imageChiecken1.layer.add(animate, forKey: "Moving")
         
         */
        
        
        //let circlePath = UIBezierPath(arcCenter: CGPoint(view.frame.midX, view.frame.midY), radius: 20, startAngle: 0, endAngle:CGFloat(M_PI)*2, clockwise: true)
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x:150, y:300), radius: 30, startAngle: 0, endAngle: 130, clockwise: true)
        
        let animation = CAKeyframeAnimation(keyPath: "position");
        animation.duration = 1
        animation.repeatCount = MAXFLOAT
        animation.path = circlePath.cgPath
        
        let squareView = UIView()
        //whatever the value of origin for squareView will not affect the animation
        squareView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        squareView.backgroundColor = UIColor.lightGray
        view.addSubview(squareView)
        // You can also pass any unique string value for key
        squareView.layer.add(animation, forKey: nil)
        
        // circleLayer is only used to locate the circle animation path
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.strokeColor = UIColor.black.cgColor
        circleLayer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(circleLayer)
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
