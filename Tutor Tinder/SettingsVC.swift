//
//  SettingsVC.swift
//  Tutor Tinder
//
//  Created by Angela Lin on 4/14/19.
//  Copyright © 2019 Angela Lin. All rights reserved.
//

import UIKit
import Firebase

class SettingsVC: UINavigationController {
    
    @IBOutlet weak var tutorSubject: UITextField!
    
    @IBOutlet weak var tuteeSubject: UITextField!
    
    @IBOutlet weak var priceStartRange: UITextField!
    
    @IBOutlet weak var priceEndRange: UITextField!
    
    @IBOutlet weak var Done: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
