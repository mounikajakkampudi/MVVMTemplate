//
//  ImageViewExtension.swift
//  CodeChallenge
//
//  Created by Mounika Jakkampudi on 10/10/20.
//  Copyright © 2020 MVVM. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {

    // Update imageview from cache or network
    func setImageFromServerURL(_ URLString: String, placeHolder: UIImage, completion: @escaping (UIImage) -> Void) {
        // Set to default image. So that no duplicates
        self.image = placeHolder
        //If imageurl's imagename has space then this line going to work for this
        let imageServerUrl = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        // Check for image if exists in cache
        if let cachedImage = imageCache.object(forKey: NSString(string: imageServerUrl)) {
            self.image = cachedImage
            completion(cachedImage)
            return
        }

        // If not cached before, download image from server
            DispatchQueue.global().async {
                NetworkManager.shared.get(urlString: imageServerUrl) { (result) in
                    switch result {
                    case .failure(let error):
                        #if DEBUG
                        print("ERROR LOADING IMAGES FROM URL: \(String(describing: error.localizedDescription))")
                        #endif
                        DispatchQueue.main.async {
                            self.image = placeHolder
                            completion(placeHolder)
                        }
                    case .success(let data):
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: imageServerUrl))
                            DispatchQueue.main.async {
                            self.image = downloadedImage
                            }
                            completion(downloadedImage)
                        }
                    }

                }
            }
    }
}
