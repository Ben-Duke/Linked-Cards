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
    
    
    // MARK: Properties
    var card : Card?
    var editDel : editDetailDelegate? = nil
    var reloadDel : triggerReloadDelegate? = nil
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    // MARK: Actions
    @IBAction func savebuttonAction(_ sender: UIBarButtonItem) {
        
        UpdateCardDatabase().EditCard(card: card!, valuesToEdit: [firstNameTextField.text!, lastNameTextField.text!, companyTextField.text!, emailTextField.text!, phoneTextField.text!])
        if reloadDel != nil{
            reloadDel?.reloadTable(refresh: true)
        }
        else{
            print("reloadDel looks to be nil")
        }
        performSegueReturnBack()
    }
    
    @IBAction func cancelButtonAction(_ sender: UIBarButtonItem) {
        performSegueReturnBack()
    }
    
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        firstNameTextField.text =  self.fillBlanks(input: (card?.firstName)!, textfield: self.firstNameTextField)
        lastNameTextField.text = self.fillBlanks(input: (card?.lastName)!, textfield: self.lastNameTextField)
        companyTextField.text = self.fillBlanks(input: (card?.company)!, textfield: self.companyTextField)
        emailTextField.text = self.fillBlanks(input: (card?.email)!, textfield: self.emailTextField)
        phoneTextField.text = self.fillBlanks(input: (card?.phone)!, textfield: self.phoneTextField)
    }
    
    func passCardId(cardId: NSManagedObjectID) {
        card = LoadFromDataBase().loadSingleCard(with: cardId)
    }
    
    func fillBlanks(input: String, textfield: UITextField) -> String {
        if input == "" {
            return textfield.placeholder!
        }
        else{
            return input
        }
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
