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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
