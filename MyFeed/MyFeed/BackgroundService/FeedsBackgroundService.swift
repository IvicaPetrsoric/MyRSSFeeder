import UIKit


class FeedsBackgroundService{
    
    private var service = Service()
    private var notification = NotificationService()
    private var feedData = [FeedData]()
    private var myFeeds = [Feed]()
    private var newStorieAvailable = Bool()
    private var completionHandler: ((Bool) -> Void)?

    func checkIfNewStroeistFromFeedsAvailable(completion: @escaping(Bool) -> ()){
        feedData = CoreDataManager.shared.fetchFeedData()
        newStorieAvailable = false
        completionHandler = completion
        
        if !feedData.isEmpty{
            feedData.forEach({ (feed) in
                guard let url = feed.url else { return }
                
                let minorFeed = Feed(url: url, stories: nil)
                myFeeds.append(minorFeed)
            })
            
            fetchFeeds(feed: myFeeds, total: myFeeds.count, index: 0)
            
        } else {
            DispatchQueue.main.async {
                completion(false)
            }
        }
    }
    
    private func fetchFeeds(feed: [Feed], total: Int, index: Int){
        if total == 0 || index == total || newStorieAvailable{
            completionHandler?(newStorieAvailable)
            return
        }
        else if index < total{
            let url = feed[index].url
            
            service.fetchFeeds(rssUrl: url, completionHandler: { (data, error) in
                if error{
                    print("Error with feed")
                    return
                }

                if self.feedData[index].lastStoresName != data.first?.title{
                    self.newStorieAvailable = true
                    self.notification.setupNotification()
                }
                
                self.fetchFeeds(feed: feed, total: total, index: index + 1)
            })
        }
    }

}


