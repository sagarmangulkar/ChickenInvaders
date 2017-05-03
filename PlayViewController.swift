//
//  PlayViewController.swift
//  Chicken_Invaders
//
//  Created by Mac on 5/8/17.
//  Copyright © 2017 Sagar. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {
    
    @IBOutlet var buttonLeft: UIButton!
    @IBOutlet var buttonUp: UIButton!
    @IBOutlet var buttonDown: UIButton!
    @IBOutlet var buttonRight: UIButton!
    @IBOutlet var imageHero: UIImageView!
    let motionDistance = 50         //motion distance when push navigation panel button
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
