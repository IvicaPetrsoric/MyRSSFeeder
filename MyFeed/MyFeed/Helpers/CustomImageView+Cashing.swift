//
//  CustomImageView.swift
//  MyFeed
//
//  Created by Ivica Petrsoric on 25/01/2018.
//  Copyright © 2018 Ivica Petrsoric. All rights reserved.
//

import UIKit

//image cash
let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView{
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String, completion: @escaping(Bool) -> ()){
        
        imageUrlString = urlString
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString){
            completion(true)
            self.image = imageFromCache
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data,response,error) in
            
            if error != nil{
                print("Fetching img error: ",error?.localizedDescription as Any)
                DispatchQueue.main.async {
                    completion(false)
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200{
                print("error \(httpResponse.statusCode)")
                DispatchQueue.main.async {
                    completion(false)
                }
                return
            }
            
            DispatchQueue.main.async{
                guard let imageToCache = UIImage(data: data!) else {
                    completion(false)
                    return
                }
                
                if self.imageUrlString == urlString{
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache, forKey: urlString as NSString)
                completion(true)
            }
            
        }).resume()
        
    }
}
