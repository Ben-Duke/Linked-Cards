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
    var testCard = Card(referencedId: nil, firstName: "Decode", lastName: "Talker", company: "Vrains", email: "@Duke", phone: "02146789")
    @IBOutlet weak var SendJsonButton: UIButton!
    
    @IBOutlet weak var readyLabel: UILabel!
    
    @IBAction func sendCardJSONAction(_ sender: Any) {
    bleModel.send(cardJSON: testCard.cardToJson())
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        CardSwapBLEModel().delegate = self
    }
    
    func connectedDevicesChanged(manager : CardSwapBLEModel, connectedDevices: [String]){
        print(connectedDevices.count)
    }
    func CardSwapfunc(manager : CardSwapBLEModel, cardToSwap: String){
        print(cardToSwap + "WingChungChunk I am hung")
        readyLabel.text = cardToSwap
    }
}
