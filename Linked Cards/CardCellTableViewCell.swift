//
//  CardCellTableViewCell.swift
//  Linked Cards
//
//  Created by Ben Duke on 10/06/17.
//  Copyright © 2017 Ben Duke. All rights reserved.
//

import UIKit


class CardCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    
    
    func setUpCard(card: Card){
        firstNameLabel.text = card.firstName
        lastNameLabel.text = card.lastName
        companyLabel.text = card.company
        emailLabel.text = card.email
        phoneLabel.text = card.phone
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
