//
//  BaseCell.swift
//  MyFeed
//
//  Created by Ivica Petrsoric on 23/01/2018.
//  Copyright © 2018 Ivica Petrsoric. All rights reserved.
//

import UIKit

class BaseCell: UITableViewCell{
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
    }
}
