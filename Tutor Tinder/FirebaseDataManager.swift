//
//  FirebaseDataManager.swift
//  Tutorial 7
//
//  Created by Angela Lin on 4/7/19.
//  Copyright © 2019 Angela Lin. All rights reserved.
//

import Foundation
import Firebase

struct FirebaseDataManager {
   
    //Database
   private static let ref = Database.database().reference(withPath: "users")
   private static let userRef = Database.database().reference()
    private static var userArrays = [User]()
    
    
    static func pullUsers(callback: @escaping (User) -> ()) {
        FirebaseDataManager.ref.observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value)
            for case let userSnapshot as DataSnapshot in snapshot.children {
                
                let user = userSnapshot.value as! [String: Any]
                let userID = userSnapshot.key
                let userPassword = user["password"] as! String
                let userContact = user["contact"] as! String
                let userEmailRegistered = user["emailRegistered"] as! String
                let userFirstName = user["firstName"] as! String
                let userLastName = user["lastName"] as! String
                let userNeedTutor = user["needTutor"] as! String
                let userTutorFor = user["tutorFor"] as! String
                let userPrice = user["tutorFor"] as! String
                let tuteeLikes = user["tuteeLikes"] as! [String: String]
                let tutorLikes = user["tutorLikes"] as! [String: String]
                let tuteeMatches = user["tuteeMatches"] as! [String: String]
                let tutorMatches = user["tutorMatches"] as! [String: String]
                let tutorPreferences = user["tutorPreferences"] as! [String: String]
                let tuteePreferences = user["tuteePreferences"] as! [String: String]
                let age = user["age"] as! String
                let profilePic = user["profilePic"] as! String
                
                var userReal = User(contact: userContact, emailRegistered: userEmailRegistered, firstName: userFirstName, lastName: userLastName, tutorLikes: tutorLikes, tuteeLikes: tuteeLikes, password: userPassword,  needTutor: userNeedTutor, tutorFor: userTutorFor, price: userPrice, tuteeMatches: tuteeMatches, tutorMatches: tutorMatches, tuteePreferences: tuteePreferences, tutorPreferences: tutorPreferences, age: age, profilePic: profilePic)
                
                self.userArrays.append(userReal)
                
                callback(userReal)
                
            }
            
        })
    }
    
    static func getUserArrays() -> [User] {
        
        return self.userArrays
    
        
    }
    
    static func writeUserData(userEmail: String, userPassword: String, userID: String){
        userRef.child("users/" + String(userID)).setValue(["emailRegistered": userEmail, "password": userPassword])
    }
    
    //when this method is called, userID data has to be pulled
    static func editUserProfile(userID: String, firstName: String, lastName: String, age: String, tutorSubject: String, tuteeSubject: String, tutorPrice: String, contactInfo: String){
        FirebaseDataManager.userRef.child("users").child(userID).updateChildValues(["firstName": firstName, "lastName": lastName, "age": age, "tutorFor": tutorSubject, "needTutor": tuteeSubject, "price": tutorPrice, "contact": contactInfo])
        //FirebaseDataManager.userRef.child("users/" + String(userID)).setValue(["firstName": firstName, "lastName": lastName, "age": age, "tutorFor": tutorSubject, "needTutor": tuteeSubject, "price": tutorPrice, "contact": contactInfo])
    }
    
    static func editUserProfilePic(userID: String, profilePic: String){
        FirebaseDataManager.userRef.child("users/" + String(userID)).updateChildValues(["profilePic": profilePic])
    }
    
    //when someone "likes" someone
    static func addToTutorLikes(userID: String, tutorToBeAdded: String){
        FirebaseDataManager.userRef.child("users/" + String(userID)).child("tutorLikes").updateChildValues([tutorToBeAdded:tutorToBeAdded])
        
    }
    
    static func addToTuteeLikes(userID: String, tuteeToBeAdded: String){
        FirebaseDataManager.userRef.child("users/" + String(userID)).child("tuteeLikes").updateChildValues([tuteeToBeAdded:tuteeToBeAdded])
        
    }
    
    //add to user's matches list
    static func addtoUserMatches(userID: String, userToBeAdded: String){
        FirebaseDataManager.userRef.child("users/" + String(userID)).child("tutorMatches").updateChildValues([userToBeAdded:userToBeAdded])
    }
    
    
    

}
