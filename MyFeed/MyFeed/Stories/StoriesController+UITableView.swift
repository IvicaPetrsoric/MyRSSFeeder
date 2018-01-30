//
//  StoriesController+UITableView.swift
//  MyFeed
//
//  Created by Ivica Petrsoric on 29/01/2018.
//  Copyright © 2018 Ivica Petrsoric. All rights reserved.
//

import UIKit

extension StoriesController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = myStories?.count{
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0

        UIView.animate(withDuration: 1) {
            cell.alpha = 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StoriesCell
        
        cell.cellLeadingConstrains.constant = 0
        cell.storiesImageView.alpha = 0
        
        if let name = myStories?[indexPath.row].title{
            cell.storiesLabel.text = name
        }
        
        if let imgUrl = myStories?[indexPath.row].urlImage, !imgUrl.isEmpty,
            let imageView = cell.storiesImageView as? CustomImageView{
            imageView.loadImageUsingUrlString(urlString: imgUrl){ (completion) in
                if completion{
                    UIWindow.animate(withDuration: 1, animations: {
                        imageView.alpha = 1
                        imageView.backgroundColor = .gray
                    })
                }else{
                    cell.cellLeadingConstrains.constant = -cell.storiesImageView.frame.width + 2
                    cell.layoutIfNeeded()
                }
            }
        } else {
            cell.cellLeadingConstrains.constant = -cell.storiesImageView.frame.width + 2
            cell.layoutIfNeeded()
        }
        
        cell.storiesImageView.layer.cornerRadius = cell.storiesImageView.frame.height / 2
        cell.storiesImageView.layer.borderWidth = 2
        cell.storiesImageView.layer.borderColor = UIColor.white.cgColor
        
        cell.storiesView.layer.cornerRadius = cell.storiesView.frame.height / 2
        cell.storiesView.backgroundColor = .tealColor
        
        cell.backgroundColor = .darkBlue
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webView = StoriesWebController()
        navigationController?.pushViewController(webView, animated: true)
        
        if let webUrl = myStories?[indexPath.row].urlVideo{
            webView.webUrl = webUrl
        }
    }
}
