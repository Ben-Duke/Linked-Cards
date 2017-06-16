//
//  CardCellTableViewCell.swift
//  Linked Cards
//
//  Created by Ben Duke on 10/06/17.
//  Copyright © 2017 Ben Duke. All rights reserved.
//

import UIKit


class CardCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    func setUpCard(card: Card){
        profileImage.image = card.profileImage
        nameLabel.text = card.name
        companyLabel.text = card.company
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
