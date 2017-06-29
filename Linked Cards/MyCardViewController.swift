//
//  MyCardViewController.swift
//  Linked Cards
//
//  Created by Ben Duke on 19/06/17.
//  Copyright © 2017 Ben Duke. All rights reserved.
//

import UIKit

class MyCardViewController: UIViewController {

    //MARK: Properties
    var myCard : Card?
    var myCards = [Card]()
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    //MARK: Actions
    
    @IBAction func saveButtonAction(_ sender: UIBarButtonItem) {
        //Save functionality
        
        if myCard != nil {
            MyCardModel().EditCard(card: myCard!, valuesToEdit: [firstNameTextField.text!, lastNameTextField.text!, companyTextField.text!, emailTextField.text!, phoneTextField.text!])
        }else {
            MyCardModel().saveCard(firstname: firstNameTextField.text!, lastname: lastNameTextField.text!, company: companyTextField.text!, email: emailTextField.text!, phone: phoneTextField.text!)
        }
        
        performSegueReturnBack()
    }
    
    @IBAction func cancelButtonAction(_ sender: UIBarButtonItem) {
        performSegueReturnBack()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        let myCards = MyCardModel().GetCardsFromCoreData()
        
        if myCards.count > 0 {
            myCard = myCards[0]
        }
        
        if myCard != nil{
            setUpView()
        }
        else{
            print("was nil")
        }
        
    }
    
    func setUpView() {
        firstNameTextField.text = myCard?.firstName
        lastNameTextField.text = myCard?.lastName
        companyTextField.text = myCard?.company
        emailTextField.text = myCard?.email
        phoneTextField.text = myCard?.phone
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
