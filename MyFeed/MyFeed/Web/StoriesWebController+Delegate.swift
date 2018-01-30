//
//  StoriesWebController+Delegate.swift
//  MyFeed
//
//  Created by Ivica Petrsoric on 29/01/2018.
//  Copyright © 2018 Ivica Petrsoric. All rights reserved.
//

import UIKit

extension StoriesWebController: UIWebViewDelegate{
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("Did start")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("Did finish")
        activityIndicator.stopAnimating()
        browser.delegate = nil
        
        UIView.animate(withDuration: 0.5) {
            self.browser.alpha = 1
        }
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("Fail with error")
        activityIndicator.stopAnimating()
        showAllert(message: alertMessage.errorWebConnection.rawValue)
        
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print("should start loading")
        return true
    }
}
