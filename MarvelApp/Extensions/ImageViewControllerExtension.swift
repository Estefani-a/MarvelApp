//
//  ImageViewControllerExtension.swift
//  MarvelApp
//
//  Created by Estefania Sassone on 20/07/2022.
//

import Foundation
import UIKit

var cachedImages = [String: UIImage]()

class ImageViewCache: UIImageView {
    
    var previousUrlString: String?
    
    func loadImage(urlString: String) {
        
        previousUrlString = urlString
        
        self.image = nil
        
        if let cachedImage = cachedImages[urlString] {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            if let err = err {
                print("Could not fetch Url:", err)
            }
            
            if url.absoluteString != self.previousUrlString {
                return
            }
            
            if let imageData = data {
                let image = UIImage(data: imageData)
                cachedImages[url.absoluteString] = image
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}
