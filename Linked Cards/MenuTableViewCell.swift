//
//  MenuTableViewCell.swift
//  Linked Cards
//
//  Created by Ben Duke on 16/06/17.
//  Copyright © 2017 Ben Duke. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var menuLabel: UILabel!
    
    
    func setUpMenu(labelText: String) {
        menuLabel.text = labelText 
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 30
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
