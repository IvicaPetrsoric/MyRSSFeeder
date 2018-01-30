//
//  AlertView.swift
//  MyFeed
//
//  Created by Ivica Petrsoric on 26/01/2018.
//  Copyright © 2018 Ivica Petrsoric. All rights reserved.
//

import UIKit

class AlertView: UIView{
    
//    let controller: AlertController?
    
    let background: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 75
        view.layer.masksToBounds = true
        return view
    }()
    
    let alertLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.red
        label.text = "Alert Text"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ok", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        button.addTarget(self, action: #selector(handleConfrimButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
//        button.isUserInteractionEnabled = true
        return button
    }()
    
    @objc private func handleConfrimButton(){
        print(123)
    }
    
    func setupViews(view: UIView){
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
//        view.isUserInteractionEnabled = true
        
        view.addSubview(background)
        background.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        background.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        background.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        background.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        background.addSubview(alertLabel)
        alertLabel.leftAnchor.constraint(equalTo: background.leftAnchor, constant: view.frame.width / 10).isActive = true
        alertLabel.topAnchor.constraint(equalTo: background.topAnchor, constant: 10).isActive = true
        alertLabel.rightAnchor.constraint(equalTo: background.rightAnchor, constant: -view.frame.width / 10).isActive = true
        alertLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        background.addSubview(confirmButton)
        confirmButton.leftAnchor.constraint(equalTo: background.leftAnchor, constant: view.frame.width / 7).isActive = true
        confirmButton.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -10).isActive = true
        confirmButton.rightAnchor.constraint(equalTo: background.rightAnchor, constant: -view.frame.width / 7).isActive = true
        confirmButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    
}
