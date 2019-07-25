//
//  AddProfilePicVC.swift
//  Tutorial 7
//
//  Created by Angela Lin on 4/10/19.
//  Copyright © 2019 Angela Lin. All rights reserved.
//

import UIKit
import Firebase

class AddProfilePicVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var image: UIImageView!
    var controller = UIImagePickerController()
    
    var name: String = ""
    var imageURL: String = ""
    var userID: String = ""
    @IBOutlet weak var profilePage: UIButton!
    @IBOutlet weak var matches: UIButton!
    @IBOutlet weak var home: UIButton!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        controller.delegate = self
        image.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddProfilePicVC.imgTap))
        image.addGestureRecognizer(tap)
        image.isUserInteractionEnabled = true
        //storageRef = storage.reference()
        
//        profilePage.isHidden = false
//        matches.isHidden = false
//        home.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        image.layer.cornerRadius = 75
        image.clipsToBounds = true
    }
    
    
    func imagePickerController(_ _picker: UIImagePickerController, didFinishPickingMediaWithInfo info:  [UIImagePickerController.InfoKey : Any]){
        
        guard let selectedImage = info[.originalImage] as? UIImage else{
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        image.image = selectedImage
        
        
        //image URL
        let iURL = info[UIImagePickerController.InfoKey.referenceURL] as! NSURL
        imageURL = iURL.absoluteString!
        
        
        //image UIImage
        let imageName = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        //let uid = Auth.auth().currentUser?.uid
        
        //push image data to database
        //FirebaseDataManager.editUserProfilePic(userID: self.userID, profilePic: imageURL)
        
        //pass in image data to storage service functions
        StorageService.create(for: imageName, reference: self.userID)
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func imgTap(){
        let alertController = UIAlertController(title: "Change Profile Photo", message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in
            self.controller.sourceType = .photoLibrary
            self.present(self.controller, animated: true, completion: nil)
        }))
        
        alertController.addAction(UIAlertAction(title: "Saved Photos Album", style: .default, handler: { (action) in
            self.controller.sourceType = .savedPhotosAlbum
            self.present(self.controller, animated: true, completion: nil)
        }))
        
        
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            alertController.addAction(UIAlertAction(title: "Camera", style: .default, handler: {_ in self.controller.sourceType = .camera
                self.present(self.controller, animated: true, completion: nil)
                
            }))
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{_ in} ))
        self.present(alertController, animated: true, completion: nil)
    }
}

