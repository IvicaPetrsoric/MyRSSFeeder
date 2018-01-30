//
//  FeedsController+CreateFeed.swift
//  MyFeed
//
//  Created by Ivica Petrsoric on 29/01/2018.
//  Copyright © 2018 Ivica Petrsoric. All rights reserved.
//

import UIKit

extension FeedsController: CreateFeedControllerDelegate, StoriesControllerDelegate{
    
    func didCreateFeed(feed: Feed){
        service.fetchFeeds(rssUrl: feed.url, completionHandler: { (data, error) in
            if error{
                print("Failed with parsing")
                self.showAllert(message: alertMessage.errorWithParsing.rawValue)
                return
            }
            let minorFeed = Feed(url: feed.url, stories: data)
            self.myFeeds.append(minorFeed)
            self.prepareFeeds.append(minorFeed)
            
            guard let lastStoresName = data.first?.title else { return }
            guard let lastStoresDate = data.first?.published else { return }
            
            CoreDataManager.shared.createFeedData(feedUrl: feed.url, lastStoresName: lastStoresName, lastStoresDate: lastStoresDate)
            self.feedData = CoreDataManager.shared.fetchFeedData()
            DispatchQueue.main.async {
                let newIndexPath = IndexPath(row: self.myFeeds.count - 1, section: 0)
                self.tableView.insertRows(at: [newIndexPath], with: .middle)
            }
        })
    }
    
    func didSeenLastFeedStories(url: String){
        feedData = CoreDataManager.shared.fetchFeedData()
        var index = 0
        
        myFeeds.forEach { (data) in
            if data.url == url{
                let indexPath = IndexPath(row: index, section: 0)
                tableView.reloadRows(at: [indexPath], with: .middle)
            }
            
            index += 1
        }
    }
}
