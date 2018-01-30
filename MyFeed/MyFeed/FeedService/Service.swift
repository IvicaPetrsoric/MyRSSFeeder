//
//  Service.swift
//  MyFeed
//
//  Created by Ivica Petrsoric on 23/01/2018.
//  Copyright © 2018 Ivica Petrsoric. All rights reserved.
//

import UIKit



class Service: NSObject{
    
    var currentDict: [String: String] = [:]
    var rssItems: [RSSItem] = []
    var currentElement = ""
    
    var currentAuthor: String = ""{
        didSet{
            currentAuthor = currentAuthor.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    var currentAuthorImg: String = ""{
        didSet{
            currentAuthorImg = currentAuthorImg.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    var currentTittle: String = ""{
        didSet{
            currentTittle = currentTittle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    var currentVideoUrl: String = ""{
        didSet{
            currentVideoUrl = currentVideoUrl.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    var currentImageUrl: String = ""{
        didSet{
            currentImageUrl = currentImageUrl.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    var currentPublished: String = ""{
        didSet{
            currentPublished = currentPublished.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    var parseCompletionHandler: (([RSSItem], Bool) -> Void)?
    
    func checkIfUrlIsValid(rssUrl: String, completion: @escaping(Bool) -> ()){
        guard let url = URL(string: rssUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            var errorStatus = true
            
            if let error = error{
                print("Validation error: ", error)
                errorStatus = false
            }
            
            if let httpResponse = response as? HTTPURLResponse,  httpResponse.statusCode != 200{
                print("error \(httpResponse.statusCode)")
                errorStatus = false
            }
            
            DispatchQueue.main.async {
                completion(errorStatus)
            }
        }.resume()
    }
    
    func fetchFeeds(rssUrl: String, completionHandler: (([RSSItem], Bool) -> Void)?){       
        guard let url = URL(string: rssUrl) else { return }
        
        self.parseCompletionHandler = completionHandler
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error{
                print("Error fetching data: ", error)
                self.parseCompletionHandler?(self.rssItems, true)
                return
            }
            
            guard let data = data else { return }
            
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
            
        }.resume()
    }
    
}
