//
//  CardDataCell.swift
//  Linked Cards
//
//  Created by Ben Duke on 10/06/17.
//  Copyright © 2017 Ben Duke. All rights reserved.
//

import UIKit

class CardDataCell : UITableViewCell{
   
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Brain Voong"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        //First Call Super
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        //Add TextField to SubView
        self.addSubview(nameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

