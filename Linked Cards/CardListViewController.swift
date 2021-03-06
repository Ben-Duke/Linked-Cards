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
    
    // MARK: Properties
    var cards = [Card]()
    
    var cardIdToPass : NSManagedObjectID?
    
    @IBOutlet public weak var tableViewOutlet: UITableView!
    @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
        if let nav = self.navigationController{
            nav.popViewController(animated: true)
        }
        else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cards = LoadFromDataBase().GetCardsFromCoreData()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddCard" {
            let addCardDel : CardAddViewController = segue.destination as! CardAddViewController
            addCardDel.reloadDel = self
        }
        else if segue.identifier == "EditCard" {
            let editDel : CardEditViewController = segue.destination as! CardEditViewController
            
            editDel.reloadDel = self
            editDel.editDel = self as? editDetailDelegate
            editDel.passCardId(cardId: cardIdToPass!)
        }
    }
}
extension CardListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            
            let cardToDelete = cards[indexPath.row]
            UpdateCardDatabase().deleteCard(card: cardToDelete)
            self.cards.remove(at: indexPath.row)
            self.tableViewOutlet.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell") as! CardCellTableViewCell
        cell.setUpCard(card: cards[indexPath.row])
        
        cell.layer.cornerRadius = 10
        let shadowPath2 = UIBezierPath(rect: cell.bounds)
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: CGFloat(1.0), height: CGFloat(3.0))
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowPath = shadowPath2.cgPath
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0; //Choose custom row height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Selection of a cell
        // idToPass = nil
        
        cardIdToPass = cards[indexPath.row].referencedId
        performSegue(withIdentifier: "EditCard", sender: self)
    }
    
    func reloadTable(refresh: Bool) {
        // Purpose is to load the cards and refresh the table with any new updates from Core Data
        if(refresh){
            cards = LoadFromDataBase().GetCardsFromCoreData()
            self.tableViewOutlet.reloadData()
        }
        else{
            print("Was old not to refresh the data")
        }
    }
    
}
