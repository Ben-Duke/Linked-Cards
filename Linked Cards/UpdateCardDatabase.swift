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
        // insert deletion from db
        //        print ("would have deleted")
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
                        entry.setValue(valuesToEdit[0], forKey: "name")
                        entry.setValue(valuesToEdit[1], forKey: "company")
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
    func saveCard(name: String, company: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newCard = NSEntityDescription.insertNewObject(forEntityName: "Card", into: context)
        
        newCard.setValue(name, forKey: "name")
        newCard.setValue(company, forKey: "company")
        
        do {
            try context.save()
        } catch let error {
            assertionFailure(error.localizedDescription)
        }
    }
}
