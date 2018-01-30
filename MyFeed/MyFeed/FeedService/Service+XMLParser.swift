//
//  Service+XMLParser.swift
//  MyFeed
//
//  Created by Ivica Petrsoric on 29/01/2018.
//  Copyright © 2018 Ivica Petrsoric. All rights reserved.
//

import UIKit

extension Service: XMLParserDelegate{
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        currentDict = attributeDict
        
        if currentElement == "entry" || currentElement == "item"{
            currentTittle = ""
            currentVideoUrl = ""
            currentImageUrl = ""
            currentPublished = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
            
        case "name":
            if currentAuthor.isEmpty{
                currentAuthor += string
            }
            
        case "title":
            if currentAuthor.isEmpty{
                currentAuthor += string
            }
            
            if string != currentAuthor{
                currentTittle += string
            }
            
        case "url":
            if currentAuthorImg.isEmpty{
                currentAuthorImg += string
            }
            
        case "link":
            if currentDict["rel"] == "alternate", let url = currentDict["href"]{
                currentVideoUrl += url
            }
            
            if currentVideoUrl.isEmpty || currentVideoUrl == currentAuthor{
                currentVideoUrl += string
            }
            
        case "media:thumbnail", "media:content", "enclosure":
            if let url = currentDict["url"]{
                currentImageUrl = url
            }
            
        case "published", "pubDate":
            currentPublished += string
            
        case "atom:link":
            if let url = currentDict["href"]{
                currentVideoUrl += url
            }
            
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" || elementName == "entry"{
            let rssItem = RSSItem(author: currentAuthor, authorUrl: currentAuthorImg, title: currentTittle, urlImage: currentImageUrl, urlVideo: currentVideoUrl, published: currentPublished)
            
            self.rssItems.append(rssItem)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parseCompletionHandler?(rssItems, false)
        
        currentAuthor = ""
        currentAuthorImg = ""
        currentPublished = ""
        currentTittle = ""
        currentVideoUrl = ""
        currentImageUrl = ""
        rssItems = []
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("Parsing error: ", parseError.localizedDescription)
        parseCompletionHandler?(rssItems, true)
    }
}
