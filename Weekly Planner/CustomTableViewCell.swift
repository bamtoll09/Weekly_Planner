//
//  File.swift
//  Weekly Planner
//
//  Created by Sunrin on 2017. 1. 4..
//  Copyright © 2017년 Bamtoll. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
