//
//  CardEditViewController.swift
//  Linked Cards
//
//  Created by Ben Duke on 14/06/17.
//  Copyright © 2017 Ben Duke. All rights reserved.
//

import UIKit
import CoreData

//protocol triggerReloadDelegate {
//    func reloadTable(refresh: Bool)
//}

protocol editDetailDelegate {
    func passCardId(cardId : NSManagedObjectID)
}

class CardEditViewController: UIViewController , editDetailDelegate {
    
    var card : Card?
    func passCardId(cardId: NSManagedObjectID) {
        card = LoadFromDataBase().loadSingleCard(with: cardId)
    }
    
    
    var editDel : editDetailDelegate? = nil
    var reloadViewCardDel : viewDetailDelegate? = nil
    
    // MARK: Properties
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    
    
    @IBAction func savebuttonAction(_ sender: UIBarButtonItem) {
        
        //UpdateCardDatabase().saveCard(name: nameTextfield.text!, company: companyTextField.text!)
        UpdateCardDatabase().EditCard(card: card!, valuesToEdit: [nameTextfield.text!, companyTextField.text!])
                if reloadViewCardDel != nil{
                    print("not nil just not working")
                     reloadViewCardDel?.passCardId(cardId: (card?.referencedId)!)
                }
                else{
                    print("looks to be nil")
        }
       
        performSegueReturnBack()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("In edit view")
        nameTextfield.text = card?.name
        companyTextField.text = card?.company
    }
    
    @IBAction func cancelButtonAction(_ sender: UIBarButtonItem) {
        performSegueReturnBack()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    func performSegueReturnBack(){
        
        
        if let nav = self.navigationController{
            nav.popViewController(animated: true)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
        
    }
}
