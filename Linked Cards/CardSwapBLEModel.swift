//
//  CardSwapBLEModel.swift
//  Linked Cards
//
//  Created by Ben Duke on 23/06/17.
//  Copyright © 2017 Ben Duke. All rights reserved.
//

import Foundation
import MultipeerConnectivity

protocol CardSwapBLEModelDelegate{
    func connectedDevicesChanged(managed : CardSwapBLEModel, conectedDevices: [String] )
    func SwapCard(manager : CardSwapBLEModel, cardToSwap: Card)
}

class CardSwapBLEModel: NSObject {
    // Service type must be a unique string, at most 15 characters long
    // and can contain only ASCII lowercase letters, numbers and hyphens.
    private let ColorServiceType = "example-colour"
    
    public let myPeerId = MCPeerID(displayName: UIDevice.current.name)
    private let serviceAdvertiser : MCNearbyServiceAdvertiser
    private let serviceBrowser : MCNearbyServiceBrowser
    
    var delegate : CardSwapBLEModelDelegate?
    
    lazy var session : MCSession = {
        let session =  MCSession(peer: self.myPeerId , securityIdentity: nil, encryptionPreference: .required)
        session.delegate = self as? MCSessionDelegate
        return session
    }()
    
    override init() {
        self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: nil, serviceType: ColorServiceType)
        self.serviceBrowser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: ColorServiceType)
        
        super.init()
        
        self.serviceAdvertiser.delegate = self as? MCNearbyServiceAdvertiserDelegate
        self.serviceAdvertiser.startAdvertisingPeer()
        
        self.serviceBrowser.delegate = self as? MCNearbyServiceBrowserDelegate
        self.serviceBrowser.startBrowsingForPeers()
    }
    
    deinit {
        self.serviceAdvertiser.stopAdvertisingPeer()
        self.serviceBrowser.stopBrowsingForPeers()
    }
    
    func sendCard(card : Card) {
        NSLog("%@", "sendCard \(card.name)) to \(session.connectedPeers.count) peers")
        
        if session.connectedPeers.count > 0 {
            do {
                try self.session.send(, toPeers: session.connectedPeers, with: .reliable)
            } catch let error {
                NSLog("%@", "Error for sending: \(error)")
            }
        }
    }
    
}
