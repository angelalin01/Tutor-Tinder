//
//  NavigationController.swift
//  Tutor Tinder
//
//  Created by Angela Lin on 4/11/19.
//  Copyright © 2019 Angela Lin. All rights reserved.
//

import UIKit
import Firebase

class NavigationController: UINavigationController{
    var handle: AuthStateDidChangeListenerHandle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handle =  Auth.auth().addStateDidChangeListener({ (auth, user) in
            //code when state changes
        })

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
}
