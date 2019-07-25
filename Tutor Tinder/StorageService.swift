//
//  StorageService.swift
//  Tutor Tinder
//
//  Created by Angela Lin on 4/19/19.
//  Copyright © 2019 Angela Lin. All rights reserved.
//

import UIKit
import Firebase


struct StorageService {

    //private static let iRef = Storage.storage().reference()


    static func uploadImage(_ image: UIImage, at reference: StorageReference, completion: @escaping (URL?) -> Void) {
        // 1
        guard let imageData = image.jpegData(compressionQuality: 0.1) else {
            return completion(nil)
        }
        
        // 2
        reference.putData(imageData, metadata: nil, completion: { (metadata, error) in
            // 3
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }

            // 4
            reference.downloadURL(completion: { (url, error) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    return completion(nil)
                }
                completion(url)
            })
        })
    }

    //uploads image at reference
    static func create(for image: UIImage, reference: String) {
        let imageRef = Storage.storage().reference().child(reference)
        StorageService.uploadImage(image, at: imageRef) { (downloadURL) in
            guard let downloadURL = downloadURL else {
                return
            }

            let urlString = downloadURL.absoluteString
            print("image url: \(urlString)")
        }
    }

    static func downloadPic(for reference: String, completion: @escaping (UIImage) -> Void) {
        let imageRef = Storage.storage().reference().child(reference)
        var image: UIImage?
        imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                image = nil
            } else {
                // Data for "images/island.jpg" is returned
                image = UIImage(data: data!)!
                completion(image!)
            }
        }
    }

}
