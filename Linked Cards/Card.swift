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
   
    
    var referencedId : NSManagedObjectID?
    var firstName: String?
    var lastName: String?
    var company: String?
    var email: String?
    var phone: String?
    
    

    func CardToDictionary() -> [String : Any] {
        let dictionary: [String: Any] = ["firstname":self.firstName, "lastname":self.lastName, "company":self.company, "email":self.email, "phone":self.phone]
        return dictionary
    }
    
    func jsonToCard(cardJson: String) -> Card{
        
        var jsonarray = JsonToDictionary(text: cardJson)
        print(jsonarray as? String)
        print(jsonarray!["name"])
        return Card(referencedId: nil, firstName: jsonarray!["firstname"] as! String, lastName: jsonarray!["lastname"] as! String, company: jsonarray!["company"] as! String, email: jsonarray!["email"] as! String, phone: jsonarray!["phone"] as? String)
    }
    
    func JsonToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    
    func cardToJson() -> String {
        var outPut : String?
        if let data = try? JSONSerialization.data(withJSONObject: self.CardToDictionary(), options: .prettyPrinted) {
            let jsonString = String(bytes: data, encoding: .utf8)
            outPut = jsonString
        }
        return outPut!
    }
    
    init(referencedId: NSManagedObjectID?, firstName:String?, lastName: String?, company: String?, email: String?, phone: String? ) {
        
        self.referencedId = referencedId
        self.firstName = firstName
        self.lastName = lastName
        self.company = company
        self.email = email
        self.phone = phone
    }
    
}
