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
                    
                    let name = each.value(forKey: "name") as? String
                    
                    let company = each.value(forKey: "company") as? String
                    
                    let profileimage : UIImage = {
                        
                        if let image = each.value(forKey: "profileimage") as? NSData {
                            return UIImage(data: image as Data)!
                        }
                        print("couldnt convert it")
                        return UIImage()
                    }()
                    
                    let tempCard = Card(referencedId: id, name: name, company: company, profileImage: profileimage)
                    cards.append(tempCard)
                    print(cards.count)
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
}
