//
//  LoginVC.swift
//  Tutorial 7
//
//  Created by Angela Lin on 4/10/19.
//  Copyright © 2019 Angela Lin. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseAuth

class LoginVC: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UIButton!
    
    //var userID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { [weak self] user, error in
            guard let strongSelf = self else { return }
            
            if (error != nil) {
                print(error)
                //   self.showToast(message: error!.localizedDescription)
            }
            
            //self!.checkUser()
            self!.performSegue(withIdentifier: "toHomePage", sender: nil)
        }
        
    }
    
//    func checkUser() {
//        if let currentUser = Auth.auth().currentUser {
//            self.userID = currentUser.uid
//            print("USER LOGGED IN IS: " + (self.userID))
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHomePage"{
            if let nextViewController = segue.destination as? SwipeTutorViewController {
                nextViewController.email = self.email.text
                nextViewController.password = self.password.text
                //nextViewController.userID = "0"
                //print(nextViewController.userID)
            }
        }
    }
    
    
}
