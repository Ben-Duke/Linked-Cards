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

class CardEditViewController: UIViewController {
    
    var reloadDel : triggerReloadDelegate? = nil
    
    // MARK: Properties
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    
    
    @IBAction func savebuttonAction(_ sender: UIBarButtonItem) {
//   Saves to core
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newCard = NSEntityDescription.insertNewObject(forEntityName: "Card", into: context)
        
        newCard.setValue(nameTextfield.text, forKey: "name")
        newCard.setValue(companyTextField.text, forKey: "company")
        
        do {
            try context.save()
        } catch let error {
            assertionFailure(error.localizedDescription)
        }
        
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
