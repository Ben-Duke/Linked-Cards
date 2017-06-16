//
//  CardListViewController.swift
//  Linked Cards
//
//  Created by Ben Duke on 10/06/17.
//  Copyright © 2017 Ben Duke. All rights reserved.
//

import UIKit
import CoreData

class CardListViewController: UIViewController, triggerReloadDelegate {
    var cards = [Card]()
    
    
    
    @IBOutlet public weak var tableViewOutlet: UITableView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GetCardsFromCoreData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //addSampleCards()
        
    }
    
//    func addSampleCards() {
//        var demoCardData = [Card]()
//        
//        let card1 = Card(name:"Ben Duke", company: "IOS Dev", profile: #imageLiteral(resourceName: "Ben Profile"))
//        let card2 = Card(name:"Ben Duke", company: "IOS Dev", profile: #imageLiteral(resourceName: "Ben Profile"))
//        
//        demoCardData.append(card1)
//        demoCardData.append(card2)
//        cards = demoCardData
//        
//    }
}
extension CardListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell") as! CardCellTableViewCell
        cell.setUpCard(card: cards[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0;//Choose your custom row height
    }
    
    func reloadTable(refresh: Bool) {
        if(refresh){
        GetCardsFromCoreData()
        self.tableViewOutlet.reloadData()
        print("refreshed the data")
        }
        else{
            print("Was old not to refresh the data")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditCard" {
            let targetDel : CardEditViewController = segue.destination as! CardEditViewController
            targetDel.reloadDel = self
        }
    }
    
    func GetCardsFromCoreData() {
        ///Core data implementation
        cards = [Card]()
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Card")
        request.returnsObjectsAsFaults = false
        
        do{
            let result = try context.fetch(request)
            if result.count > 0 {
                for each in result as! [NSManagedObject] {
                    
                    let name = each.value(forKey: "name") as? String
                    
                    let company = each.value(forKey: "company") as? String
                    
                    let profileimage : UIImage = {
                        
                        if let image = each.value(forKey: "profileimage") as? NSData {
                            return UIImage(data: image as Data)!
                        }
                        print("couldnt convert it")
                        return UIImage()
                    }()
                    
                    let tempCard = Card(name: name, company: company, profileImage: profileimage)
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

    }
}
