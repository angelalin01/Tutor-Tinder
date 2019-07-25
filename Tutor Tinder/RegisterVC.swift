//
//  RegisterVC.swift
//  Tutorial 7
//
//  Created by Angela Lin on 4/10/19.
//  Copyright © 2019 Angela Lin. All rights reserved.
//


import UIKit
import Firebase

class RegisterVC: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var register: UIButton!
    
    let userRef = Database.database().reference(withPath: "users")
    let ref = Database.database().reference()
    
    
    var userID : String = ""
    
     func getUserID() -> String {
        return userID
    }
    
    override func viewDidLoad() {
       super.viewDidLoad()
    }
    
    
    @IBAction func register(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (authResult, error) in
            if error != nil {
                print(error!)
                return
            }
            
            if let currentUser = Auth.auth().currentUser {
                self.userID = currentUser.uid
            }
            print(self.userID)
            
//            self.ref.observe(.value, with: { (snapshot: DataSnapshot!) in
//                print(snapshot.children)
//                print(snapshot.childrenCount)
//                self.userID = String(snapshot.childrenCount + 1)
//            })
            
            FirebaseDataManager.writeUserData(userEmail: self.email.text!, userPassword: self.password.text!, userID: self.userID)
            
            self.performSegue(withIdentifier: "registerUserNext", sender: nil)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "registerUserNext"{
            if let nextViewController = segue.destination as? AddProfileVC{
                nextViewController.userID = self.userID
                nextViewController.registeredEmail = self.email.text
                nextViewController.password = self.password.text
                //print(nextViewController.userID)
            }
        }
    }
    
    
}
