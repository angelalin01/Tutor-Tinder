//
//  AddProfileVC.swift
//  Tutorial 7
//
//  Created by Angela Lin on 4/11/19.
//  Copyright © 2019 Angela Lin. All rights reserved.
//

import UIKit
import Firebase

class AddProfileVC: UIViewController {
    
    //passed in data
    var registeredEmail: String!
    var password: String!
    var loggedInEmail: String!
    var loggedInPassword: String!
    
    var userID: String = ""
    private static let userRef = Database.database().reference()
    private let ref = Database.database().reference(withPath: "users")
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var tutorSubject: UITextField!
    @IBOutlet weak var tuteeSubject: UITextField!
    @IBOutlet weak var contactInfo: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var saveInfo: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    
    // call editProfile here to update database whenever user enters new info in the Profile page
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.userID)
        
        if(firstName.text != "" && lastName.text != "" && age.text != "" && tutorSubject.text != "" && tuteeSubject.text != "" && contactInfo.text != "" && contactInfo.text != "" && price.text != ""){
            FirebaseDataManager.pullUsers{(user) in
                self.firstName.text = user.firstName
                self.lastName.text = user.lastName
                self.age.text = user.age
                self.tutorSubject.text = user.tutorFor
                self.tuteeSubject.text = user.needTutor
                self.contactInfo.text = user.contact
                self.price.text = user.price
            }
        } else{
            if(firstName.text == nil){
                firstName.text = "no current value assigned "
            }
            if(lastName.text == nil){
                lastName.text = "no current value assigned "
            }
            if(age.text == nil){
                age.text = "no current value assigned "
            }
            if(tutorSubject.text == nil){
                tutorSubject.text = "no current value assigned "
            }
            if(tuteeSubject.text == nil){
                tuteeSubject.text = "no current value assigned "
            }
            if(contactInfo.text == nil){
                contactInfo.text = "no current value assigned "
            }
            if(price.text == nil){
               price.text = "no current value assigned "
            }
        }
        
        
    }
    
    
    @IBAction func saveInfo(_ sender: Any) {
        
        print(self.userID)
        FirebaseDataManager.editUserProfile(userID: self.userID, firstName: firstName.text!, lastName: lastName.text!, age: age.text!, tutorSubject: tutorSubject.text!, tuteeSubject: tuteeSubject.text!, tutorPrice: price.text!, contactInfo: contactInfo.text!)
        
        print(ref)
        print(self.userID)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            //print(snapshot.value)
            for case let userSnapshot as DataSnapshot in snapshot.children {
                print(userSnapshot)
                let user = userSnapshot.value as! [String: Any]
                let uid = userSnapshot.key
                let userTutorFor = user["tutorFor"] as! String
                let userTuteeFor = user["needTutor"] as! String
                 //iterating through database, if a user's tutoringFor subject matches user's needTutoring subject, add it to the user's tutorPreferences
                if userTutorFor == self.tuteeSubject.text! {
                    AddProfileVC.userRef.child("users/" + String(self.userID)).child("tutorPreferences").updateChildValues([uid:uid])
                    
                    AddProfileVC.userRef.child("users/" + String(uid)).child("tuteePreferences").updateChildValues([self.userID:self.userID])
                    
                }
                if userTuteeFor == self.tutorSubject.text! {
                    AddProfileVC.userRef.child("users/" +  String(self.userID)).child("tuteePreferences").updateChildValues([uid:uid])
                    
                    AddProfileVC.userRef.child("users/" +  String(uid)).child("tutorPreferences").updateChildValues([self.userID:self.userID])
                }
            }
            
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "uploadProfilePic"{
            if let nextViewController = segue.destination as? AddProfilePicVC{
                nextViewController.userID = self.userID
                //print(nextViewController.userID)
            }
        }
        else if segue.identifier == "startSwiping" {
            if case let nextViewController = segue.destination as? SwipeTutorViewController{
                if(self.registeredEmail != nil){
                    nextViewController?.registeredEmail = self.registeredEmail
                    nextViewController?.registeredPassword = self.password
                    nextViewController?.userID = self.userID
                }
                if(self.loggedInEmail != nil){
                    nextViewController?.email = self.loggedInEmail
                    nextViewController?.password = self.loggedInPassword
                    nextViewController?.userID = self.userID
                }
            }
        }
    }
    
    @IBAction func save(_ sender: Any) {
        
    
        
    }
    
}
