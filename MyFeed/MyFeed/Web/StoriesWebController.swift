//
//  WebView.swift
//  MyFeed
//
//  Created by Ivica Petrsoric on 25/01/2018.
//  Copyright © 2018 Ivica Petrsoric. All rights reserved.
//

import UIKit
import WebKit

class StoriesWebController: UIViewController{
    
    var webUrl: String?{
        didSet{
            if let stringUrl = webUrl{
                
                guard let url = URL(string: stringUrl) else { return }

                let request = URLRequest(url: url)
                browser.loadRequest(request)
            }
        }
    }
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    let browser: UIWebView = {
        let brows = UIWebView()
        brows.allowsInlineMediaPlayback = true
        brows.mediaPlaybackRequiresUserAction = false
        brows.translatesAutoresizingMaskIntoConstraints = false
        brows.backgroundColor = UIColor.darkBlue
        return brows
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        view.backgroundColor = .darkBlue
        
        browser.delegate = self
        browser.alpha = 0
        activityIndicator.startAnimating()

    }
    
    private func setupUI(){
        view.backgroundColor = .darkBlue
        
        view.addSubview(browser)
        browser.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        browser.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        browser.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        browser.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        view.addSubview(activityIndicator)
        activityIndicator.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        activityIndicator.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        activityIndicator.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }    
    
}

