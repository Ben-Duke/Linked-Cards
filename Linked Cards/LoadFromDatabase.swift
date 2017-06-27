//
//  LoadFromDatabase.swift
//  Linked Cards
//
//  Created by Ben Duke on 17/06/17.
//  Copyright © 2017 Ben Duke. All rights reserved.
//

import UIKit
import CoreData

class LoadFromDataBase {
    
    public func GetCardsFromCoreData() -> [Card]{
        ///Core data implementation
        var cards = [Card]()
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Card")
        request.returnsObjectsAsFaults = false
        
        do{
            let result = try context.fetch(request)
            if result.count > 0 {
                for each in result as! [NSManagedObject] {
                    
                    let id = each.objectID
                    let firstname = each.value(forKey: "firstname") as? String
                    let lastname = each.value(forKey: "lastname") as? String
                    let company = each.value(forKey: "company") as? String
                    let email = each.value(forKey: "email") as? String
                    let phone = each.value(forKey: "phone") as? String
                    
                    
                    
                    let tempCard = Card(referencedId: id, firstName: firstname, lastName: lastname, company: company, email: email, phone: phone)
                    cards.append(tempCard)
                    
                }
            }else{
                print("Am connecting but no records")
            }
        } catch let error{
            assertionFailure(error.localizedDescription)
        }
        ///End///
        return cards
    }
    public func loadSingleCard(with objectId: NSManagedObjectID) -> Card {
        //Pulls out a single card from the database
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Card")
        request.returnsObjectsAsFaults = false
        var cardToReturn : Card?
        do{
            let result = try context.fetch(request)
            if result.count > 0 {
                for each in result as! [NSManagedObject] {
                    
                    if each.objectID == objectId{
                        
                        let id = each.objectID
                        let firstname = each.value(forKey: "firstname") as? String
                        let lastname = each.value(forKey: "lastname") as? String
                        let company = each.value(forKey: "company") as? String
                        let email = each.value(forKey: "email") as? String
                        let phone = each.value(forKey: "phone") as? String
                        
                        let tempCard = Card(referencedId: id, firstName: firstname, lastName: lastname, company: company, email: email, phone: phone)
                        cardToReturn = tempCard
                    }
                }
                
            }else{
                print("Am connecting but no records")
            }
        } catch let error{
            assertionFailure(error.localizedDescription)
        }
        
        return cardToReturn!
        
        
    }
}
