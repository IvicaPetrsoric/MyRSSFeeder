//
//  Notifications.swift
//  MyFeed
//
//  Created by Ivica Petrsoric on 27/01/2018.
//  Copyright © 2018 Ivica Petrsoric. All rights reserved.
//
import UIKit
import UserNotifications

class NotificationService{
    
    func setupNotification(){
        let content = UNMutableNotificationContent()
        content.body = "New stories available!"
        content.badge = 1
        content.sound = UNNotificationSound.default()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let requeust = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(requeust, withCompletionHandler: nil)
    }
}
