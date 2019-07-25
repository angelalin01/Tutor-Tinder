//
//  SwipeTuteeVC.swift
//  Tutor Tinder
//
//  Created by Angela Lin on 4/14/19.
//  Copyright © 2019 Angela Lin. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseAuth

class SwipeTutorViewController: UIViewController {
    
    //user data to be pulled
    @IBOutlet weak var firstName: UILabel!
    
    @IBOutlet weak var lastName: UILabel!
    
    @IBOutlet weak var age: UILabel!
    
    @IBOutlet weak var subject: UILabel!
    
    @IBOutlet weak var profilePic: UIImageView!
    
    //user actions
    @IBOutlet weak var swipeLeft: UIButton!
    @IBOutlet weak var swipeRight: UIButton!
    @IBOutlet weak var tuteesSwipe: UIButton!
    @IBOutlet weak var liked: UIButton!
    @IBOutlet weak var dislike: UIButton!
    @IBOutlet weak var editProfile: UIButton!
    @IBOutlet weak var seeMatches: UIButton!
    @IBOutlet weak var price: UILabel!
    
    
    var handle: AuthStateDidChangeListenerHandle!
    
    //userID
    var userID: String! = ""
    
    //determine which user data to present
    var email: String!
    var password: String!
    var registeredEmail: String!
    var registeredPassword: String! 
    
    var counter: Int = 0
    var pulledPreferences: NSDictionary?
    var pulledPreferencesArr : [String]?
    var tutorMatches: [String]!
    var likes: [String]! = []
    var pulledLikesUsers: [secondUser] = []
    var im: UIImage?
    
    private let ref = Database.database().reference(withPath: "users")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print(self.registeredPassword)
        print(self.registeredEmail)
        if(self.registeredEmail == nil && self.registeredPassword == nil){
            
            if let currentUser = Auth.auth().currentUser {
                self.userID = currentUser.uid
                print("USER LOGGED IN IS: " + (self.userID))
            }
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                print(snapshot.value)
                for case let userSnapshot as DataSnapshot in snapshot.children {
                    
                    let user = userSnapshot.value as? NSDictionary
                    print(user)
                    let uid = userSnapshot.key
                    //print(uid)
                    let pass = user!["password"] as! String
                    print("password: " + pass)
                    let emailReg = user!["emailRegistered"] as! String
                    print("emailReg: " + emailReg)
                  
                    let preferences = userSnapshot.childSnapshot(forPath: "tutorPreferences")
                    let prefDict = user?["tutorPreferences"] as? [String: String]
                    print(prefDict?.values)
                    
                    if (emailReg == self.email) {
                        if let prefs = prefDict {
                            self.pulledPreferencesArr = Array(prefs.keys)
                        }
                        print(self.pulledPreferences)
                        print("preferences")
                        print(preferences)
                        print("there was nothing")
                    }
                }
                
            })
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                //print(snapshot.value)
                for case let userSnapshot as DataSnapshot in snapshot.children {
                    let user = userSnapshot.value as! [String: Any]
                    let uid = userSnapshot.key
                    print(uid)
                    let uFirstName = user["firstName"] as! String
                    print("first name" + uFirstName)
                    let uLastName = user["lastName"] as! String
                    print("first name" + uLastName)
                    let uAge = user["age"] as! String
                    let uTutorFor = user["tutorFor"] as! String
                    let uPrice = user["price"] as! String
                    
                    if uid == self.pulledPreferencesArr![0] {
                        self.firstName.text = uFirstName
                        self.lastName.text = uLastName
                        self.age.text = uAge
                        self.subject.text = uTutorFor
                        self.price.text = uPrice
                        StorageService.downloadPic(for: uid, completion: { (image) in
                            self.profilePic.image = image
                        })
                    }
                }
                
            })
        }else{
            print(ref)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                 print("333")
                print(snapshot.value)
                for case let userSnapshot as DataSnapshot in snapshot.children {
                    
                    let user = userSnapshot.value as? NSDictionary
                    print(user)
                    let uid = userSnapshot.key
                    //print(uid)
                    let pass = user!["password"] as! String
                    print("password: " + pass)
                    let emailReg = user!["emailRegistered"] as! String
                    print("emailReg: " + emailReg)
                    //let preferences = user["tutorPreferences"] as? [Int:Any]
                    //let preferences = self.ref.child(uid).child("tutorPreferences")
                    let preferences = userSnapshot.childSnapshot(forPath: "tutorPreferences")
                    //let pref = preferences.value as! [Int]
//                    self.ref.child(uid).child("tutorPreferences").observeSingleEvent(of: .value, with: { (snapshot) in
//                        for case let tutorSnapshot as DataSnapshot  in snapshot.children{
//                            let tut = tutorSnapshot.value as? NSDictionary
//                            self.pulledPreferences = tut
//                        }
//
//                        })
                    let prefDict = user?["tutorPreferences"] as? [String: String]
                    print(prefDict?.values)
                    
                    //self.pulledPreferences = prefDict!
                   //let pref = preferences.value as! String
                   // print("HERE " + prefDict!)
                    //print(type(of: preferences.value))
                    
                    if (emailReg == self.registeredEmail) {
                        if let prefs = prefDict {
                            self.pulledPreferencesArr = Array(prefs.keys)
                        }
                        print(self.pulledPreferences)
                        print("preferences")
                        print(preferences)
                        print("there was nothing")
                    }
                }
                
            })
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                //print(snapshot.value)
                for case let userSnapshot as DataSnapshot in snapshot.children {
                    let user = userSnapshot.value as! [String: Any]
                    let uid = userSnapshot.key
                    print(uid)
                    let uFirstName = user["firstName"] as! String
                    print("first name" + uFirstName)
                    let uLastName = user["lastName"] as! String
                    print("first name" + uLastName)
                    let uAge = user["age"] as! String
                    let uTutorFor = user["tutorFor"] as! String
                    let uPrice = user["price"] as! String
                    
                    if uid == self.pulledPreferencesArr![0] {
                        self.firstName.text = uFirstName
                        self.lastName.text = uLastName
                        self.age.text = uAge
                        self.subject.text = uTutorFor
                        self.price.text = uPrice
                        StorageService.downloadPic(for: uid, completion: { (image) in
                            self.profilePic.image = image
                        })
                    }
                }
                
            })
        }
        
        //populating matches array with values from pulled dictionary so it's easier to iterate
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(self.registeredPassword)
        print(self.registeredEmail)
        if(self.registeredEmail == nil && self.registeredPassword == nil){
            
            if let currentUser = Auth.auth().currentUser {
                self.userID = currentUser.uid
                print("USER LOGGED IN IS: " + (self.userID))
            }
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                print(snapshot.value)
                for case let userSnapshot as DataSnapshot in snapshot.children {
                    
                    let user = userSnapshot.value as? NSDictionary
                    print(user)
                    let uid = userSnapshot.key
                    //print(uid)
                    let pass = user!["password"] as! String
                    print("password: " + pass)
                    let emailReg = user!["emailRegistered"] as! String
                    print("emailReg: " + emailReg)
                    
                    let preferences = userSnapshot.childSnapshot(forPath: "tutorPreferences")
                    let prefDict = user?["tutorPreferences"] as? [String: String]
                    print(prefDict?.values)
                    
                    if (emailReg == self.email) {
                        if let prefs = prefDict {
                            self.pulledPreferencesArr = Array(prefs.keys)
                        }
                        print(self.pulledPreferences)
                        print("preferences")
                        print(preferences)
                        print("there was nothing")
                    }
                }
                
            })
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                //print(snapshot.value)
                for case let userSnapshot as DataSnapshot in snapshot.children {
                    let user = userSnapshot.value as! [String: Any]
                    let uid = userSnapshot.key
                    print(uid)
                    let uFirstName = user["firstName"] as! String
                    print("first name" + uFirstName)
                    let uLastName = user["lastName"] as! String
                    print("first name" + uLastName)
                    let uAge = user["age"] as! String
                    let uTutorFor = user["tutorFor"] as! String
                    let uPrice = user["price"] as! String
                    
                    if uid == self.pulledPreferencesArr![0] {
                        self.firstName.text = uFirstName
                        self.lastName.text = uLastName
                        self.age.text = uAge
                        self.subject.text = uTutorFor
                        self.price.text = uPrice
                        StorageService.downloadPic(for: uid, completion: { (image) in
                            self.profilePic.image = image
                        })
                    }
                }
                
            })
        }else{
            print(ref)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                print("333")
                print(snapshot.value)
                for case let userSnapshot as DataSnapshot in snapshot.children {
                    
                    let user = userSnapshot.value as? NSDictionary
                    print(user)
                    let uid = userSnapshot.key
                    //print(uid)
                    let pass = user!["password"] as! String
                    print("password: " + pass)
                    let emailReg = user!["emailRegistered"] as! String
                    print("emailReg: " + emailReg)
                    //let preferences = user["tutorPreferences"] as? [Int:Any]
                    //let preferences = self.ref.child(uid).child("tutorPreferences")
                    let preferences = userSnapshot.childSnapshot(forPath: "tutorPreferences")
                    //let pref = preferences.value as! [Int]
                    //                    self.ref.child(uid).child("tutorPreferences").observeSingleEvent(of: .value, with: { (snapshot) in
                    //                        for case let tutorSnapshot as DataSnapshot  in snapshot.children{
                    //                            let tut = tutorSnapshot.value as? NSDictionary
                    //                            self.pulledPreferences = tut
                    //                        }
                    //
                    //                        })
                    let prefDict = user?["tutorPreferences"] as? [String: String]
                    print(prefDict?.values)
                    
                    //self.pulledPreferences = prefDict!
                    //let pref = preferences.value as! String
                    // print("HERE " + prefDict!)
                    //print(type(of: preferences.value))
                    
                    if (emailReg == self.registeredEmail) {
                        if let prefs = prefDict {
                            self.pulledPreferencesArr = Array(prefs.keys)
                        }
                        print(self.pulledPreferences)
                        print("preferences")
                        print(preferences)
                        print("there was nothing")
                    }
                }
                
            })
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                //print(snapshot.value)
                for case let userSnapshot as DataSnapshot in snapshot.children {
                    let user = userSnapshot.value as! [String: Any]
                    let uid = userSnapshot.key
                    print(uid)
                    let uFirstName = user["firstName"] as! String
                    print("first name" + uFirstName)
                    let uLastName = user["lastName"] as! String
                    print("first name" + uLastName)
                    let uAge = user["age"] as! String
                    let uTutorFor = user["tutorFor"] as! String
                    let uPrice = user["price"] as! String
                    
                    if uid == self.pulledPreferencesArr![0] {
                        self.firstName.text = uFirstName
                        self.lastName.text = uLastName
                        self.age.text = uAge
                        self.subject.text = uTutorFor
                        self.price.text = uPrice
                        StorageService.downloadPic(for: uid, completion: { (image) in
                            self.profilePic.image = image
                        })
                    }
                }
                
            })
        }
        
        //populating matches array with values from pulled dictionary so it's easier to iterate
        
        
    }
    
    private func observeAuthorisedState() {
        self.setupRootViewController(
            viewController: SwipeTuteeVC())
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil {
                self.setupRootViewController(
                    viewController: LoginVC())
            } else {
                self.setupRootViewController(
                    viewController: SwipeTutorViewController())
            }
        }
    }
    private func setupRootViewController(
        viewController: UIViewController) {
        
        //self.window!.rootViewController = SwipeTutorVC
        //self.window!.makeKeyAndVisible()
    }
    
    @IBAction func tappedRight(_ sender: Any) {
    
        counter = counter + 1
       //display this the values corresponding to object of arr[counter]
        
        print(self.pulledPreferencesArr?.count)
        if let pulledP = self.pulledPreferencesArr {
        if (counter < pulledP.count) {
            let userID = pulledP[counter]
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value)
            for case let userSnapshot as DataSnapshot in snapshot.children {
                let user = userSnapshot.value as! [String: Any]
                let uid = userSnapshot.key
                let uFirstName = user["firstName"] as! String
                let uLastName = user["lastName"] as! String
                let uAge = user["age"] as! String
                let uTutorFor = user["tutorFor"] as! String
                let uPrice = user["price"] as! String
                
                if uid == userID {
                   self.firstName.text = uFirstName
                    self.lastName.text = uLastName
                    self.age.text = uAge
                    self.subject.text = uTutorFor
                    self.price.text = uPrice
                    //print(StorageService.downloadPic(for: uid).pngData() as Any)
                    StorageService.downloadPic(for: uid, completion: { (image) in
                        self.profilePic.image = image
                    })
                }
            }
            
        })
            //counter = counter + 1
        }
        }
        
    }
    

    
    @IBAction func liked(_ sender: Any) {
        
        let fName = self.firstName.text
        let lName = self.lastName.text
        let age = self.age.text
        let subject = self.subject.text
        
        if let pulledP = self.pulledPreferencesArr{
        let likedUID = pulledP[counter]
        FirebaseDataManager.addToTutorLikes(userID: self.userID, tutorToBeAdded: likedUID
        )
        self.likes.append(likedUID)
        
        self.pulledLikesUsers.removeAll()
        for tutorID in self.likes{
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                //print(snapshot.value)
                for case let userSnapshot as DataSnapshot in snapshot.children {
                    let user = userSnapshot.value as! [String: Any]
                    print(user)
                    let uid = userSnapshot.key
                    let uFirstName = user["firstName"] as! String
                    let uLastName = user["lastName"] as! String
                    let uPrice = user["price"] as! String
                    let uTutorFor = user["tutorFor"] as! String
                    let contactInfo = user["contact"] as! String
                    
                    if tutorID == uid {
//                        StorageService.downloadPic(for: uid, completion: { (image) in
//                          self.im = image
//                                                  })
                        let user = secondUser(firstName: uFirstName, lastName: uLastName, tutorSubject: uTutorFor, price: uPrice, uid: uid, contactInfo: contactInfo)
                        
                        self.pulledLikesUsers.append(user)
                    }
                }
            })
        }
        
        
        print("---")
        print(self.likes)
        //want to access likedUser's liked dataset to see if match exists
        let likesRef = Database.database().reference().child("users").child(likedUID).child("tuteeLikes")
        
        likesRef.observeSingleEvent(of: .value, with: {(snapshot) in
            for case let userSnapshot as DataSnapshot in snapshot.children {
                if (userSnapshot.key == Auth.auth().currentUser?.uid) {
                    FirebaseDataManager.addtoUserMatches(userID: self.userID, userToBeAdded: likedUID)
                     FirebaseDataManager.addtoUserMatches(userID: likedUID, userToBeAdded: self.userID)
                    self.tutorMatches.append(likedUID)
                }
            }
            
        })
        }
    }
    
    
    @IBAction func disliked(_ sender: Any) {
        
        do{
            try Auth.auth().signOut()
        }
        catch let signOutError as NSError{
            print ("Error signing out: %@", signOutError)
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = initial

        self.userID = nil 
        self.registeredPassword  = nil
        self.registeredEmail = nil
        self.email = nil
        self.password = nil

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "getMatches"{
            if let nextViewController = segue.destination as? MatchesVC{
                nextViewController.pulledTutorMatchesArr = self.tutorMatches
                nextViewController.pulledLikes = self.likes
                nextViewController.pulledLikesUsers = self.pulledLikesUsers
                //print(nextViewController.userID)
            }
        }
        if segue.identifier == "editProfile"{
            if let nextViewController = segue.destination as? AddProfileVC{
                if(self.registeredEmail != nil){
                    nextViewController.userID = self.userID
                    nextViewController.registeredEmail = self.registeredEmail
                    nextViewController.password = self.registeredPassword
                }
                if(self.email != nil){
                    nextViewController.userID = self.userID
                    nextViewController.loggedInEmail = self.email
                    nextViewController.loggedInPassword = self.password
                }
                
            }
        }
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
