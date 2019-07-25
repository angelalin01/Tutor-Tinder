//
//  ViewController.swift
//  Tutorial 7
//
//  Created by Angela Lin on 3/13/19.
//  Copyright © 2019 Angela Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var login: UIButton!
    
    @IBOutlet weak var register: UIButton!
    
    let db = FirebaseDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "Login" {
//            let dest = segue.destination as? LoginVC
//
//        }
//    
//    }

        
//        performSegue(withIdentifier: "<#T##String#>", sender: <#T##Any?#>)
}

