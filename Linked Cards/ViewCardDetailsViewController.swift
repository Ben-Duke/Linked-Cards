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
            reloadDel?.reloadTable(refresh: true)
            print(1)
        }
        performSegueReturnBack()
    }
        
    
    override func viewDidLoad() {
            super.viewDidLoad()
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
            print(viewCard?.name)
            if nameLabel != nil{
                updateUI()
            }
        }
    
    func updateUI() {
        if viewCard?.name != nil {
            nameLabel!.text = viewCard!.name
            companyLabel!.text = viewCard!.company
        }else{
            print(404)
        }
    }
}
extension ViewCardDetailsViewController{
    
    
    fileprivate func performSegueReturnBack(){
        
        if let nav = self.navigationController{
          //  CardEditViewController.reloadViewCard = self
            nav.popViewController(animated: true)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
}
