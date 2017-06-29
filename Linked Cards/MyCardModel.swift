//
//  MyCardModel.swift
//  Linked Cards
//
//  Created by Ben Duke on 28/06/17.
//  Copyright © 2017 Ben Duke. All rights reserved.
//

import UIKit
import CoreData

class MyCardModel {
    
    public func EditCard(card:Card, valuesToEdit: [String]){
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MyCard")
        request.returnsObjectsAsFaults = false
        
        do{
            let result = try context.fetch(request)
            if result.count > 0 {
                for each in result as! [NSManagedObject] {
                    let entry = each
                    print("checking")
                    if entry.objectID == card.referencedId! {
                        print("found it")
                        entry.setValue(valuesToEdit[0], forKey: "firstname")
                        entry.setValue(valuesToEdit[1], forKey: "lastname")
                        entry.setValue(valuesToEdit[2], forKey: "company")
                        entry.setValue(valuesToEdit[3], forKey: "email")
                        entry.setValue(valuesToEdit[4], forKey: "phone")
                        do{
                            try context.save()
                            
                        }
                        catch
                        {
                            print(error)
                        }
                    }
                }
            }else{
                print("Am connecting but no records")
            }
        } catch let error{
            assertionFailure(error.localizedDescription)
        }
        
    }
    
    ///////////////////////
    func saveCard(firstname: String, lastname: String, company: String, email: String, phone: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newCard = NSEntityDescription.insertNewObject(forEntityName: "MyCard", into: context)
        
        newCard.setValue(firstname, forKey: "firstname")
        newCard.setValue(lastname, forKey: "lastname")
        newCard.setValue(company, forKey: "company")
        newCard.setValue(email, forKey: "email")
        newCard.setValue(phone, forKey: "phone")
        
        do {
            try context.save()
        } catch let error {
            assertionFailure(error.localizedDescription)
        }
    }
    
    public func GetCardsFromCoreData() -> [Card]{
        ///Core data implementation
        var cards = [Card]()
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MyCard")
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
    
///////////
    public func loadSingleCard(with objectId: NSManagedObjectID) -> Card {
        //Pulls out a single card from the database
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MyCard")
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
