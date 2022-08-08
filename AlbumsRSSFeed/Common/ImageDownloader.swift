//
//  ImageDownloader.swift
//  AlbumsRSSFeed
//
//  Created by Sheikh Ali on 08/08/2022.
//

import Foundation
import UIKit

class ImageDownloader {

    static let shared = ImageDownloader()
    
    var session: URLSession
    var cache: NSCache<NSString, UIImage>
    
    private init() {
        session = URLSession.shared
        self.cache = NSCache()
    }
    
    func getImage(imagePath: String, completionHandler: @escaping (UIImage?) -> ()) {
        if let image = self.cache.object(forKey: imagePath as NSString) {
            DispatchQueue.main.async {
                completionHandler(image)
            }
        } else {
            
            guard
                let url = URL(string: imagePath)
            else { return completionHandler(nil) }
            
            session.downloadTask(with: url, completionHandler: { (location, response, error) in
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    self.cache.setObject(image, forKey: imagePath as NSString)
                    DispatchQueue.main.async {
                        completionHandler(image)
                    }
                } else {
                    completionHandler(nil)
                }
            }).resume()
        }
    }
}
