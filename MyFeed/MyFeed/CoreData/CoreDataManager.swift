//
//  CoreDataManager.swift
//  MyFeed
//
//  Created by Ivica Petrsoric on 26/01/2018.
//  Copyright © 2018 Ivica Petrsoric. All rights reserved.
//

import CoreData

class CoreDataManager{
    
    static let shared = CoreDataManager()
    
    let persistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FeedsModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, err) in
            if let err = err{
                fatalError("Loading of store failed: \(err)")
            }
        })
        return container
    }()
    
    func createFeedData(feedUrl: String, lastStoresName: String, lastStoresDate: String){
        let context = persistantContainer.viewContext
        
        let feedData = NSEntityDescription.insertNewObject(forEntityName: "FeedData", into: context)
        
        feedData.setValue(feedUrl, forKey: "url")
        feedData.setValue(lastStoresName, forKey: "lastStoresName")
        feedData.setValue(lastStoresDate, forKey: "lastStoriesDate")
        
        do{
            try context.save()
        } catch let saveErr {
            print("failed to save Feed:", saveErr)
        }
    }
    
    func fetchFeedData() -> [FeedData]{
        let context = persistantContainer.viewContext
        
        let fetchRequest = NSFetchRequest<FeedData>(entityName: "FeedData")
        
        do{
            let feedData = try context.fetch(fetchRequest)

            return feedData
            
        } catch let fetchErr{
            print("Failed to fetch Feeds:", fetchErr)
            return []
        }
    }
    
    func updateFeedData(feedData: FeedData, lastStoresName: String, lastStoresDate: String){
        let context = persistantContainer.viewContext

        feedData.lastStoresName = lastStoresName
        feedData.lastStoriesDate = lastStoresDate
        
        do{
            try  context.save()
            print("Updated db")
        } catch let saveErr {
            print("Failed tosave company changes:", saveErr)
        }
    }
    
    func deleteFeedData(feedData: FeedData){
        let context = persistantContainer.viewContext
        context.delete(feedData)
        
        do {
            try context.save()
            
        } catch let delErr{
            print("Failed to delete object from CoreData:", delErr)
        }
    }
    
    func deleteAllFeedsData(){
        let context = persistantContainer.viewContext
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: FeedData.fetchRequest())

        do{
            try context.execute(batchDeleteRequest)
        }catch let delErr {
            print("failed to delete objects from Core Data:", delErr)
        }
    }
    
}
