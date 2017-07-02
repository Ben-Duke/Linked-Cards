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
    @IBOutlet weak var connectedLabel: UILabel!
    @IBOutlet weak var SendJsonButton: UIButton!
    
    
    
    @IBAction func sendCardJSONAction(_ sender: Any) {
        bleModel.send(cardJSON: (myCard?.cardToJson())!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bleModel.delegate = self
        cards = model.GetCardsFromCoreData()
        startUp()
        
    }
    
    func startUp() {
        SendJsonButton.layer.cornerRadius = 30
        SendJsonButton.isEnabled = false
        SendJsonButton.isHidden = true
        
    
        
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
        if myCard != nil {
            if connectedDevices.count > 0 {
                DispatchQueue.main.async {
                    self.labelUpdate(num: connectedDevices.count)
                    self.SendJsonButton.isHidden = false
                    self.SendJsonButton.isEnabled = true
                }
            }
            else{
                DispatchQueue.main.async {
                    self.SendJsonButton.isHidden = true
                }
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
    
    func labelUpdate(num:Int?) {
        if num != nil{
            connectedLabel.text = "Connected people: \(num!)"
        }
        else{
            connectedLabel.text = "No one is Connected"
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

