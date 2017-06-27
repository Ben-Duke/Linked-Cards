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
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    
    
    @IBAction func savebuttonAction(_ sender: UIBarButtonItem) {
        
        UpdateCardDatabase().saveCard(firstname: nameTextfield.text!, lastname: "", company: companyTextField.text!, email: "", phone: "")
        print("starting")
        if reloadDel != nil{
            reloadDel?.reloadTable(refresh: true)
            print(1)
        }
        //print("Apears delegate is nil")
        performSegueReturnBack()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("In edit view")
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
