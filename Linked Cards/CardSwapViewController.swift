//
//  CardSwapViewController.swift
//  Linked Cards
//
//  Created by Ben Duke on 26/06/17.
//  Copyright © 2017 Ben Duke. All rights reserved.
//

import UIKit

class CardSwapViewController: UIViewController, CardSwapServiceManagerDelegate {
    
    
    
    let bleModel = CardSwapBLEModel()
    var myCard : Card?
    var cards : [Card] = []
    var model = MyCardModel()
    
    @IBOutlet weak var readyLabel: UILabel!
    
    @IBOutlet weak var SendJsonButton: UIButton!
    
    
    
    @IBAction func sendCardJSONAction(_ sender: Any) {
        bleModel.send(cardJSON: (myCard?.cardToJson())!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bleModel.delegate = self
        SendJsonButton.isEnabled = false
        cards = model.GetCardsFromCoreData()
        
        SendJsonButton.layer.cornerRadius = 30
        
        if cards.count > 0{
            myCard = cards[0]
            bleModel.myCard = self.myCard
        }
        else{
            SendJsonButton.isEnabled = false
            let alert = UIAlertController(title: "Alert", message: "You need to create your 'My Card' before you can swap cards. Press the Home button to return Home", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func connectedDevicesChanged(manager : CardSwapBLEModel, connectedDevices: [String]){
        print(connectedDevices.count)
        if (connectedDevices.count > 0 && myCard != nil){
            DispatchQueue.main.async {
                self.SendJsonButton.isEnabled = true
            }
        }
        
    }
    
    func CardSwapfunc(manager : CardSwapBLEModel, cardToSwap: String){
        return
    }
    
    func CardReceived(cardReceived: Card){
        DispatchQueue.main.async {
            self.readyLabel.text! = "\(cardReceived.firstName!)'s card received "
        }
        
    }
    
    func ConnectedDevice(connected: Bool) {
        print(connected)
        if (!connected){
            DispatchQueue.main.async {
                self.SendJsonButton.isEnabled = false
            }
        }
        
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

