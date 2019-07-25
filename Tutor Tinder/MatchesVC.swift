//
//  MatchesVC.swift
//  Tutor Tinder
//
//  Created by Angela Lin on 4/14/19.
//  Copyright © 2019 Angela Lin. All rights reserved.
//

import UIKit
import Firebase

class MatchesVC: UITableViewController {
    
    private static let userRef = Database.database().reference(withPath: "users")
    var size: Int = 0
    var counter: Int = 0
    var pulledTutorMatches: [String:String]!
    var pulledTuteeMatches: [String:String]!
    var pulledTutorMatchesArr: [String]!
    var pulledTuteeMatchesArr: [String]!
    var pulledLikes: [String]!
    var pulledLikesUsers: [secondUser] = []
    
    //values that go into each cell
    var firstName: String = ""
    var lastName: String = ""
    var subject: String = ""
    
    override func viewDidLoad() {
        print(self.pulledLikes)
        super.viewDidLoad()

        //go through user's matches list and display matches
//        FirebaseDataManager.pullUsers{(user) in
//            let tutorMatches = user.tutorMatches
//            let tuteeMatches = user.tuteeMatches
//            self.pulledTutorMatches = tutorMatches
//
//        }
        //populating matches array with values from pulled dictionary so it's easier to iterate
//        for (key, value) in pulledTutorMatches {
//            self.pulledTutorMatchesArr.append(key)
//        }
//        for (key, value) in pulledTuteeMatches {
//            self.pulledTuteeMatchesArr.append(key)
//        }
        
//        for tutorID in pulledLikes{
//            MatchesVC.userRef.observeSingleEvent(of: .value, with: { (snapshot) in
//                //print(snapshot.value)
//                for case let userSnapshot as DataSnapshot in snapshot.children {
//                    let user = userSnapshot.value as! [String: Any]
//                    let uid = userSnapshot.key
//                    let uFirstName = user["firstName"] as! String
//                    let uLastName = user["lastName"] as! String
//                    let uAge = user["age"] as! String
//                    let uTutorFor = user["tutorFor"] as! String
//
//                    if tutorID == uid {
//                        let user = secondUser(firstName: uFirstName, lastName: uLastName, tutorSubject: uTutorFor, age: uAge)
//                        self.pulledLikesUsers.append(user)
//                    }
//                }
//            })
//        }
        
        print(self.pulledLikesUsers)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return self.pulledLikesUsers.count
    }
    
    //let arr = [User(user1, .....), User(onefo, ....)]
    
   
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //set all text attributes to be the value of that userOfInterest
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "matchesCell", for: indexPath) as! MatchesCell
        print(self.pulledLikesUsers)
        print(indexPath)
        print("---")
        print(indexPath.row)
        let userOfInterest = self.pulledLikesUsers[indexPath.row]
        print(userOfInterest)
        cell.firstName.text = userOfInterest.firstName
        cell.lastName.text = userOfInterest.lastName
        cell.subject.text = userOfInterest.tutorSubject
        cell.price.text = "Price: $" + userOfInterest.price
        cell.contactInfo.text = "#: " + userOfInterest.contactInfo
        StorageService.downloadPic(for: userOfInterest.uid, completion: { (image) in
            cell.matchesImage.image = image
                                  })
        print("ppp")
        
//            cell.firstName.text = uFirstName
//            cell.lastName.text = uLastName
//            StorageService.downloadPic(for: uid, completion: { (image) in
//                cell.matchesImage.image = image
//            })
//            cell.subject.text = uTutorFor
//            cell.tutorOrTutee.text = "tutor"
        
//            for tuteeID in pulledTuteeMatchesArr{
//                MatchesVC.userRef.observeSingleEvent(of: .value, with: { (snapshot) in
//                    //print(snapshot.value)
//                    for case let userSnapshot as DataSnapshot in snapshot.children {
//                        let user = userSnapshot.value as! [String: Any]
//                        let uid = userSnapshot.key
//                        let uFirstName = user["firstName"] as! String
//                        let uLastName = user["lastName"] as! String
//                        let uAge = user["age"] as! String
//                        let uTuteeFor = user["tuteeFor"] as! String
//
//                        //iterating through tuteeMatches and tutorMatches; going through the database to find corresponding userID's and then displaying the relevant user data
//                        if tuteeID == uid {
//                            cell.firstName.text = uFirstName
//                            cell.lastName.text = uLastName
//                            StorageService.downloadPic(for: uid, completion: { (image) in
//                                cell.matchesImage.image = image
//                            })
//                            cell.subject.text = uTuteeFor
//                            cell.tutorOrTutee.text = "tutee"
//                        }
//                    }
//                })
//            }
            return cell
        }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //present all the elements in the tutor and tutee matches branch of the user
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
