//
//  UpdateCardDatabase.swift
//  Linked Cards
//
//  Created by Ben Duke on 17/06/17.
//  Copyright © 2017 Ben Duke. All rights reserved.
//

import UIKit
import CoreData

class UpdateCardDatabase {
    public func deleteCard(card:Card){
        // Deletion from db
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Card")
        request.returnsObjectsAsFaults = false
        
        do{
            let result = try context.fetch(request)
            if result.count > 0 {
                for each in result as! [NSManagedObject] {
                    let entry = each
                    print("checking")
                    if entry.objectID == card.referencedId! {
                        print("found it")
                        print("Attempting deletion")
                        
                        context.delete(entry)
                        print("Deletion done")
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
    ///////////////////////////
    
    public func EditCard(card:Card, valuesToEdit: [String]){
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Card")
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
        let newCard = NSEntityDescription.insertNewObject(forEntityName: "Card", into: context)
        
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
}
