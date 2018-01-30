//
//  StoriesCell.swift
//  MyFeed
//
//  Created by Ivica Petrsoric on 25/01/2018.
//  Copyright © 2018 Ivica Petrsoric. All rights reserved.
//

import UIKit

class StoriesCell: UITableViewCell {

    @IBOutlet weak var storiesImageView: UIImageView!
    @IBOutlet weak var storiesLabel: UILabel!
    @IBOutlet weak var storiesView: UIView!
    
    @IBOutlet weak var cellLeadingConstrains: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
