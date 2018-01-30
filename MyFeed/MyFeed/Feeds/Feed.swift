//
//  Feeds.swift
//  MyFeed
//
//  Created by Ivica Petrsoric on 24/01/2018.
//  Copyright © 2018 Ivica Petrsoric. All rights reserved.
//

import Foundation

struct Feed {
    var url: String
    var stories: [RSSItem]?
    
}

struct RSSItem{
    var author: String?
    var authorUrl: String?
    var title: String?
    var urlImage: String?
    var urlVideo: String?
    var published: String?
    
}
