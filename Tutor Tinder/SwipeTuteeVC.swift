//
//  SwipeTuteeVC.swift
//  Tutor Tinder
//
//  Created by Angela Lin on 4/17/19.
//  Copyright © 2019 Angela Lin. All rights reserved.
//

import UIKit
import Firebase

class SwipeTuteeVC: UINavigationController {

    private static let ref = Database.database().reference(withPath: "users")
    
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var profilepic: UIImageView!
    @IBOutlet weak var liked: UIButton!
    
    @IBOutlet weak var swipedLeft: UIButton!
    @IBOutlet weak var swipedRight: UIButton!
    
    var userID: String = ""
    var counter: Int!
    var pulledPreferences: [String: String]!
    var pulledPreferencesArr: [String]!
    var likedUsers: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        FirebaseDataManager.pullUsers{(user) in
            let matches = user.tuteeMatches
            let preferences = user.tuteePreferences
            self.pulledPreferences = preferences
            
        }
        //populating matches array with values from pulled dictionary so it's easier to iterate
        for (key, value) in pulledPreferences {
            self.pulledPreferencesArr.append(key)
        }
    }
    
    @IBAction func swipedLeft(_ sender: Any) {
     
        
        counter = counter - 1
        
        while(counter >= 0){
            let userID = self.pulledPreferencesArr[counter]
            SwipeTuteeVC.ref.observeSingleEvent(of: .value, with: { (snapshot) in
                print(snapshot.value)
                for case let userSnapshot as DataSnapshot in snapshot.children {
                    let user = userSnapshot.value as! [String: Any]
                    let uid = userSnapshot.key
                    let uFirstName = user["firstName"] as! String
                    let uLastName = user["lastName"] as! String
                    let uAge = user["age"] as! String
                    let uTutorFor = user["tutorFor"] as! String
                    //iterating through database, if a user's tutoringFor subject matches user's needTutoring subject, add it to the user's tutorPreferences
                    if uid == userID {
                        self.firstName.text = uFirstName
                        self.lastName.text = uLastName
                        self.age.text = uAge
                        self.subject.text = uTutorFor
                        StorageService.downloadPic(for: uid, completion: { (image) in
                            self.profilepic.image = image
                        })
                    }
                }
            })
        }
        
    }
    
    @IBAction func swipedRight(_ sender: Any) {
        
        counter = counter + 1
        //display this the values corresponding to object of arr[counter]
        
        while(counter < pulledPreferencesArr.count){
            let userID = self.pulledPreferencesArr[counter]
            
            SwipeTuteeVC.ref.observeSingleEvent(of: .value, with: { (snapshot) in
                print(snapshot.value)
                for case let userSnapshot as DataSnapshot in snapshot.children {
                    let user = userSnapshot.value as! [String: Any]
                    let uid = userSnapshot.key
                    let uFirstName = user["firstName"] as! String
                    let uLastName = user["lastName"] as! String
                    let uAge = user["age"] as! String
                    let uTutorFor = user["tutorFor"] as! String
                    
                    if uid == userID {
                        self.firstName.text = uFirstName
                        self.lastName.text = uLastName
                        self.age.text = uAge
                        self.subject.text = uTutorFor
                        StorageService.downloadPic(for: uid, completion: { (image) in
                            self.profilepic.image = image
                        })
                    }
                }
                
            })
        }
    }
    
    @IBAction func liked(_ sender: Any) {
        
        let fName = self.firstName.text
        let lName = self.lastName.text
        let age = self.age.text
        let subject = self.subject.text
        let likedUID = self.pulledPreferencesArr[counter]
        FirebaseDataManager.addToTuteeLikes(userID: (Auth.auth().currentUser?.uid)!, tuteeToBeAdded: likedUID
        )
        
        //want to access likedUser's liked dataset to see if match exists
        let likesRef = Database.database().reference().child("users").child(likedUID).child("tutorLikes")
        
        likesRef.observeSingleEvent(of: .value, with: {(snapshot) in
            for case let userSnapshot as DataSnapshot in snapshot.children {
                if (userSnapshot.key == Auth.auth().currentUser?.uid) {
                    FirebaseDataManager.addtoUserMatches(userID: (Auth.auth().currentUser?.uid)!, userToBeAdded: likedUID)
                    FirebaseDataManager.addtoUserMatches(userID: likedUID, userToBeAdded: (Auth.auth().currentUser?.uid)!)
                }
            }
            
        })
        
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
