//
//  ImageService.swift
//  WeatherApp
//
//  Created by Alberto Huerdo on 6/1/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()


class ImageService {
    
    enum Kind: String {
        case icon = "https://api.openweathermap.org/img/w/{customValue}.png"
    }
    
    var imageUrl: URL?
    
    func findImage(kind: Kind, value: String, completion: @escaping (UIImage?) -> Void) {        
        guard let url = URL(string: kind.rawValue.replacingOccurrences(of: "{customValue}", with: value)) else {
            completion(nil)
            return
        }
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(imageFromCache)
            return
        }
        
        let session = URLSession(configuration: .default)
        let downloadPicTask = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completion(nil)
                return
            }
            
            if response is HTTPURLResponse,
                let imageData = data,
                let imageToCache = UIImage(data: imageData) {
                imageCache.setObject(imageToCache, forKey: url.absoluteString as NSString)
                completion(imageToCache)
            } else {
                print("Couldn't get response code for some reason")
            }
        }
        
        downloadPicTask.resume()
    }
}
