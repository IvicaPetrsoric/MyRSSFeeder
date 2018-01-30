//
//  FeedsController+FeedData.swift
//  MyFeed
//
//  Created by Ivica Petrsoric on 29/01/2018.
//  Copyright © 2018 Ivica Petrsoric. All rights reserved.
//

import Foundation

extension FeedsController{
    
    func setupData(){
        feedData = CoreDataManager.shared.fetchFeedData()
        
        if !feedData.isEmpty{
            prepareFeeds = []
            
            feedData.forEach({ (data) in
                
                guard let url = data.url else { return }
                let feed = Feed(url: url, stories: nil)
                
                prepareFeeds.append(feed)
            })
        }
        
        fetchingData = true
        fetchFeeds(feed: prepareFeeds, total: prepareFeeds.count, index: 0)
    }
    
    func fetchFeeds(feed: [Feed], total: Int, index: Int){
        if total == 0 {
            fetchingData = false
            return
        }
        else if index == total{
            if feedData.isEmpty{
                self.feedData = CoreDataManager.shared.fetchFeedData()
            }
            self.showTable()
        }
        else if index < total{
            let url = feed[index].url
            
            service.fetchFeeds(rssUrl: url, completionHandler: { (data, error) in
                if error{
                    print("Error with feed: ", feed[index].url)
                    DispatchQueue.main.async {
                        self.fetchingData = false
                        self.tableView.reloadData()
                        self.showAllert(message: alertMessage.errorWebConnection.rawValue)
                    }
                    return
                }
                
                let minorFeed = Feed(url: url, stories: data)
                self.myFeeds.append(minorFeed)
                
                guard let lastStoresName = data.first?.title else { return }
                guard let lastStoresDate = data.first?.published else { return }
                
                if self.feedData.isEmpty{
                    CoreDataManager.shared.createFeedData(feedUrl: url, lastStoresName: lastStoresName, lastStoresDate: lastStoresDate)
                }else{
                    if self.feedData[index].url != url{
                        CoreDataManager.shared.createFeedData(feedUrl: url, lastStoresName: lastStoresName, lastStoresDate: lastStoresDate)
                    }
                }
                
                self.fetchFeeds(feed: feed, total: total, index: index + 1)
            })
        }
    }
    
}
