//
//  ViewController.swift
//  MyFeed
//
//  Created by Ivica Petrsoric on 23/01/2018.
//  Copyright © 2018 Ivica Petrsoric. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class FeedsController: UITableViewController {

    var feedCellId = "cellId"
    var feedData = [FeedData]()
    var myFeeds = [Feed]()
    var prepareFeeds = [
        Feed(url: "http://rss.nytimes.com/services/xml/rss/nyt/Business.xml", stories: nil),
        Feed(url: "https://www.youtube.com/feeds/videos.xml?channel_id=UCuP2vJ6kRutQBfRmdcI92mA", stories: nil)
    ]
    
    let service = Service()
    var fetchingData = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
            if didAllow{
                print("Notifications: allowed")
            }
            else{
                print("Notifications: denied")
            }
        })
        
        navigationItem.title = "News"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: #selector(handleAddFeed))
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        tableView.backgroundColor = .darkBlue
        tableView.tableFooterView = UIView()
        tableView.register(FeedCell.self, forCellReuseIdentifier: feedCellId)
        tableView.separatorStyle = .none
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        refreshControl.tintColor = .white
        self.refreshControl = refreshControl
        
        setupData()
    }
    
    @objc private func handleRefresh(){
        refreshControl?.endRefreshing()
        removeCells()
    }

    @objc private func handleAddFeed(){
        let createFeedController = CreateFeedController()
        let navController = CustomNavigationController(rootViewController: createFeedController)
        createFeedController.delegate = self
        createFeedController.feedData = feedData
        present(navController, animated: true, completion: nil)
    }

}

