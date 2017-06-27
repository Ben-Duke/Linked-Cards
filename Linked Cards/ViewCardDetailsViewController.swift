//
//  ViewCardDetailsViewController.swift
//  Linked Cards
//
//  Created by Ben Duke on 18/06/17.
//  Copyright © 2017 Ben Duke. All rights reserved.
//

import UIKit
import CoreData

protocol viewDetailDelegate {
    func passCardId(cardId : NSManagedObjectID)
}

class ViewCardDetailsViewController: UIViewController, viewDetailDelegate{
    
    
    //var viewDetailDel : viewDetailDelegate? = nil
    
    var reloadDel : triggerReloadDelegate? = nil
    
    
    var viewCard : Card?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    @IBAction func cancelButtonAction(_ sender: UIBarButtonItem) {
        
        if reloadDel != nil{
            reloadDel!.reloadTable(refresh: true)
            
            print("404")

        }
        
        performSegueReturnBack()
        
    }
        
    
    override func viewDidLoad() {
            super.viewDidLoad()
        if reloadDel != nil {
            print("not nil")
        }
            updateUI()
            
        }
        
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let editDel : CardEditViewController = (segue.destination as? CardEditViewController)!
            editDel.editDel = self as? editDetailDelegate
            //print(idToPass)
            editDel.passCardId(cardId: (viewCard?.referencedId)!)
            editDel.reloadViewCardDel = self
        
    }
        
        func passCardId(cardId: NSManagedObjectID) {
            viewCard = LoadFromDataBase().loadSingleCard(with: cardId)

            if nameLabel != nil{
                updateUI()
            }
            reloadDel?.reloadTable(refresh: true)
        }
    
    func updateUI() {
        if viewCard?.firstName != nil {
            nameLabel!.text = viewCard!.firstName
            companyLabel!.text = viewCard!.company
        }else{
            print(404)
        }
    }
}
extension ViewCardDetailsViewController{
    
    
    fileprivate func performSegueReturnBack(){
        if let nav = self.navigationController{
            nav.popViewController(animated: true)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
}
