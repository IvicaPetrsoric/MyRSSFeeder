//
//  StoriesController.swift
//  MyFeed
//
//  Created by Ivica Petrsoric on 25/01/2018.
//  Copyright © 2018 Ivica Petrsoric. All rights reserved.
//

import UIKit

protocol StoriesControllerDelegate: class{
    func didSeenLastFeedStories(url: String)
}

class StoriesController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: FeedsController?
    
    var myStories: [RSSItem]?{
        didSet{
            if let title = myStories?.first?.author{
                self.title = title
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var feedData: FeedData?{
        didSet{
            guard  let feedData = feedData, let title = myStories?.first?.title, let published = myStories?.first?.published, let url = feedData.url else { return }

            if feedData.lastStoresName != title{
                CoreDataManager.shared.updateFeedData(feedData: feedData, lastStoresName: title, lastStoresDate: published)
                delegate?.didSeenLastFeedStories(url: url)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkBlue
        navigationController?.navigationBar.tintColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .darkBlue
    }
    
}



