//
//  CardListDataModel.swift
//  Linked Cards
//
//  Created by Ben Duke on 10/06/17.
//  Copyright © 2017 Ben Duke. All rights reserved.
//

import Foundation

var Cards = [Card]()

class CardListDataModel {
    public func addDemoCard() {
        Cards.append(Card(name: "Ben", company: "DevMe", phoneNumber: "021344"))
        print("Has been added")
    }
    
    public func countCards(){
        print(Cards.count)
    }
}
