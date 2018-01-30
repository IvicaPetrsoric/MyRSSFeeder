//
//  FeedsController+UITableView.swift
//  MyFeed
//
//  Created by Ivica Petrsoric on 29/01/2018.
//  Copyright © 2018 Ivica Petrsoric. All rights reserved.
//

import UIKit

extension FeedsController{
    
    func showTable(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
            let cells = self.tableView.visibleCells
            
            for cell in cells.reversed() {
                cell.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
            }
            
            var delayCounter = 0
            
            for cell in cells.reversed() {
                UIView.animate(withDuration: 2, delay: Double(delayCounter) * 0.075, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                    cell.transform = CGAffineTransform.identity
                }, completion: nil)
                
                delayCounter += 1
            }
        }
    }
    
    func removeCells(){
        fetchingData = true
        
        if myFeeds.count > 0{
            var indexPathsToRemove = [IndexPath]()
            
            for (index, _) in myFeeds.enumerated(){
                let indexPath = IndexPath(row: index, section: 0)
                indexPathsToRemove.append(indexPath)
            }
            
            myFeeds.removeAll()
            tableView.deleteRows(at: indexPathsToRemove, with: .automatic)
        }
        
        self.fetchFeeds(feed: self.prepareFeeds, total: self.prepareFeeds.count, index: 0)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (_, indexPath) in
//            let author = self.myFeeds[indexPath.row].stories?.first?.author
//            print("Attempting to delete feed: ", author as Any)
            
            self.prepareFeeds.remove(at: indexPath.row)
            self.myFeeds.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .left)
            
            CoreDataManager.shared.deleteFeedData(feedData: self.feedData[indexPath.row])
            self.feedData.remove(at: indexPath.row)
            
            if self.myFeeds.count == 0{
                self.fetchingData = false
                self.tableView.reloadData()
            }
        }
        
        deleteAction.backgroundColor = .lightRed
        
        return [deleteAction]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFeeds.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: feedCellId, for: indexPath) as! FeedCell
        
        cell.transform = CGAffineTransform.identity
        cell.feedImage.alpha = 0
        
        if let count = myFeeds[indexPath.row].stories?.count, count > 0{
            let feed = myFeeds[indexPath.row].stories?.first
            cell.myFeed = feed
            
            if let lastStoriesName = feedData[indexPath.row].lastStoresName, lastStoriesName != ""{
                if lastStoriesName != feed?.title{
                    cell.myFeedStoriesLastSeen = false
                }
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stories = myFeeds[indexPath.row].stories
        let feedData = self.feedData[indexPath.row]
        
        let storiestController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StoriesController") as! StoriesController
        storiestController.myStories = stories
        storiestController.delegate = self
        storiestController.feedData = feedData
        
        navigationController?.pushViewController(storiestController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = fetchingData ? "Collecting data!" : "No feeds availabe."
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return myFeeds.count == 0 ? 150 : 0
    }
}
