//
//  FeedCell.swift
//  MyFeed
//
//  Created by Ivica Petrsoric on 23/01/2018.
//  Copyright © 2018 Ivica Petrsoric. All rights reserved.
//

import UIKit

class FeedCell: BaseCell{
    
    var myFeed: RSSItem?{
        didSet{
            if let name = myFeed?.author{
                feedName.text = name
            }
            
            if let imageUrl = myFeed?.authorUrl{
                feedImage.loadImageUsingUrlString(urlString: imageUrl){ (completion: Bool) in
                    let showFeedImage = completion ? true : false
                    
                    UIWindow.animate(withDuration: 1, animations: {
                        if showFeedImage{
                            self.feedImage.alpha = 1
                        }
                        
                        self.alpha = 1
                    })
                }
            }
        }
    }
    
    var myFeedStoriesLastSeen: Bool?{
        didSet{
            UIView.animate(withDuration: 0.75) {
                self.newFeedStorieUp.alpha = 1
            }
        }
    }
    
    let feedImage: CustomImageView = {
        let image = CustomImageView(image: #imageLiteral(resourceName: "feedImage"))
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = UIColor.gray
        image.layer.cornerRadius = 40
        image.layer.masksToBounds = true
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.borderWidth = 2
        image.alpha = 0
        return image
    }()
    
    let feedName: UILabel = {
        let name = UILabel()
        name.text = "Feed"
        name.numberOfLines = 2
        name.textColor = .white
        name.font = UIFont.boldSystemFont(ofSize: 15)
        name.textAlignment = .center
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.tealColor
        view.layer.cornerRadius = 50
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let newFeedStorieUp: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "newFeed").withRenderingMode(.alwaysOriginal))
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.alpha = 0
        return iv
    }()
    
    override func setupViews(){
        backgroundColor = .darkBlue
        selectionStyle = .none
        
        addSubview(backView)
        
        backView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        backView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        backView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        backView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        
        backView.addSubview(feedImage)
        feedImage.leftAnchor.constraint(equalTo: backView.leftAnchor).isActive = true
        feedImage.centerYAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
        feedImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        feedImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        backView.addSubview(newFeedStorieUp)
        newFeedStorieUp.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -10).isActive = true
        newFeedStorieUp.centerYAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
        newFeedStorieUp.heightAnchor.constraint(equalToConstant: 50).isActive = true
        newFeedStorieUp.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        backView.addSubview(feedName)
        feedName.leftAnchor.constraint(equalTo: feedImage.rightAnchor).isActive = true
        feedName.rightAnchor.constraint(equalTo: newFeedStorieUp.leftAnchor, constant: -20).isActive = true
        feedName.topAnchor.constraint(equalTo: backView.topAnchor).isActive = true
        feedName.bottomAnchor.constraint(equalTo: backView.bottomAnchor).isActive = true
    }
    
}
