//
//  Card.swift
//  Linked Cards
//
//  Created by Ben Duke on 10/06/17.
//  Copyright © 2017 Ben Duke. All rights reserved.
//

import UIKit
import CoreData

class Card : NSObject {
    let name: String?
    let company: String?
    let profileImage : UIImage?
    
    init(name:String?, company: String?, profileImage: UIImage?) {
        self.name = name
        self.company = company
        self.profileImage = profileImage
    }
    
}
