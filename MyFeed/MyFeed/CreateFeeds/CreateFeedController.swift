//
//  CreateFeedController.swift
//  MyFeed
//
//  Created by Ivica Petrsoric on 24/01/2018.
//  Copyright © 2018 Ivica Petrsoric. All rights reserved.
//

import UIKit

protocol CreateFeedControllerDelegate: class {
    func didCreateFeed(feed: Feed)
}

class CreateFeedController: UIViewController{
    
    var feedData: [FeedData]?
    weak var delegate: CreateFeedControllerDelegate?
    private var service = Service()
    
    let urlTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter URL link"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.lightBlue
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        textField.layer.cornerRadius = 25
        textField.layer.masksToBounds = true
        return textField
    }()
    
    let saveFeedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleSaveFeed), for: .touchUpInside)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        return button
    }()
        
    @objc private func handleTextInputChange(){
        let isFormValid =  urlTextField.text?.count ?? 0 > 0
        
        if isFormValid{
            saveFeedButton.isEnabled = true
            saveFeedButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        } else {
            saveFeedButton.isEnabled = false
            saveFeedButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        }
    }
    
    @objc private func handleSaveFeed(){
        self.view.endEditing(true)
        guard let rssUrl = urlTextField.text else { return }
        
        let feed = Feed(url: rssUrl, stories: nil)
        
        service.checkIfUrlIsValid(rssUrl: rssUrl) { (isValid: Bool) in
            if isValid{
                if self.checkIfFeedExists(url: rssUrl){
                    self.showAllert(message: alertMessage.errorFeedExsist.rawValue)
                }else{
                    self.navigationController?.dismiss(animated: true, completion: {
                        self.delegate?.didCreateFeed(feed: feed)
                    })
                }
            }else{
                self.showAllert(message: alertMessage.errorWebAndURL.rawValue)
            }
        }
    }
    
    private func checkIfFeedExists(url: String) -> Bool{
        var urlExist = false
        feedData?.forEach({ (feed) in
            if feed.url == url{
                urlExist = true
            }
        })
        
        return urlExist
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Create News Feed"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.leftBarButtonItem?.tintColor = .white

        view.backgroundColor = .darkBlue
        
        setupViews()
    }
    
    @objc private func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    private func setupViews(){
        view.addSubview(urlTextField)
        urlTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        urlTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        urlTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        urlTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true

        view.addSubview(saveFeedButton)
        saveFeedButton.topAnchor.constraint(equalTo: urlTextField.bottomAnchor, constant: 8).isActive = true
        saveFeedButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        saveFeedButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        saveFeedButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
}



