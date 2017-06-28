//
//  CardAddViewController.swift
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

class CardAddViewController: UIViewController {
    
    var reloadDel : triggerReloadDelegate? = nil
    
    // MARK: Properties
   
    @IBOutlet weak var firstNameTextLabel: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    
    @IBAction func savebuttonAction(_ sender: UIBarButtonItem) {
        
        UpdateCardDatabase().saveCard(firstname: firstNameTextLabel.text!, lastname: lastNameTextField.text!, company: companyTextField.text!, email: emailTextField.text!, phone: phoneTextField.text!)
        
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
    fileprivate func performSegueReturnBack(){
        
        if let nav = self.navigationController{
            nav.popViewController(animated: true)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
}
