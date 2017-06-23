//
//  CardEditViewController.swift
//  Linked Cards
//
//  Created by Ben Duke on 14/06/17.
//  Copyright © 2017 Ben Duke. All rights reserved.
//

import UIKit
import CoreData

protocol triggerReloadDelegate {
    func reloadTable(refresh: Bool)
}
/*
 Still Todo:
 have it so that when selecting a card on the list view
 load the fields from the card
 
 Send the card then keep the id then save? an Idea
*/

class CardEditViewController: UIViewController {
    
    var reloadDel : triggerReloadDelegate? = nil
    
    // MARK: Properties
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    
    
    @IBAction func savebuttonAction(_ sender: UIBarButtonItem) {

        UpdateCardDatabase().saveCard(name: nameTextfield.text!, company: companyTextField.text!)
        if reloadDel != nil{
            reloadDel?.reloadTable(refresh: true)
        }
        performSegueReturnBack()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelButtonAction(_ sender: UIBarButtonItem) {
        performSegueReturnBack()
    }
}
extension UIViewController {
    func performSegueReturnBack(){
        
        if let nav = self.navigationController{
            nav.popViewController(animated: true)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
}
