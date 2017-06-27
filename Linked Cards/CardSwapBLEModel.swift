//
//  CardSwapBLEModel.swift
//  Linked Cards
//
//  Created by Ben Duke on 23/06/17.
//  Copyright © 2017 Ben Duke. All rights reserved.
//

import Foundation
import MultipeerConnectivity


protocol CardSwapServiceManagerDelegate {
    
    func connectedDevicesChanged(manager : CardSwapBLEModel, connectedDevices: [String])
    func CardSwapfunc(manager : CardSwapBLEModel, cardToSwap: String)
    
}

class CardSwapBLEModel : NSObject {
    
    private let CardSwapServiceType = "CardSwap"
    
    private let myPeerId = MCPeerID(displayName: UIDevice.current.name)
    
    private let serviceAdvertiser : MCNearbyServiceAdvertiser
    private let serviceBrowser : MCNearbyServiceBrowser
    
    var delegate : CardSwapServiceManagerDelegate?
    
    lazy var session : MCSession = {
        let session = MCSession(peer: self.myPeerId, securityIdentity: nil, encryptionPreference: .none)
        session.delegate = self as MCSessionDelegate
        return session
    }()
    
    func stopBrowsingForConnections() {
        self.serviceBrowser.stopBrowsingForPeers()
    }
    
    override init() {
        self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: nil, serviceType: CardSwapServiceType)
        self.serviceBrowser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: CardSwapServiceType)
        
        super.init()
        
        self.serviceAdvertiser.delegate = self as MCNearbyServiceAdvertiserDelegate
        self.serviceAdvertiser.startAdvertisingPeer()
        
        self.serviceBrowser.delegate = self as MCNearbyServiceBrowserDelegate
        self.serviceBrowser.startBrowsingForPeers()
    }
    
    func send(cardJSON : String) {
        NSLog("%@", "sendCard: \(cardJSON) to \(session.connectedPeers.count) peers")
        
        if session.connectedPeers.count > 0 {
            do {
                
                try self.session.send(cardJSON.data(using: .utf8)!, toPeers: session.connectedPeers, with: .reliable)
            }
            catch let error {
                NSLog("%@", "Error for sending: \(error)")
            }
        }
        
    }
    
    deinit {
        self.serviceAdvertiser.stopAdvertisingPeer()
        self.serviceBrowser.stopBrowsingForPeers()
    }
    
}

extension CardSwapBLEModel : MCNearbyServiceAdvertiserDelegate {
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        NSLog("%@", "didNotStartAdvertisingPeer: \(error)")
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        NSLog("%@", "didReceiveInvitationFromPeer \(peerID)")
        invitationHandler(true, self.session)
    }
    
}

extension CardSwapBLEModel : MCNearbyServiceBrowserDelegate {
    
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        NSLog("%@", "didNotStartBrowsingForPeers: \(error)")
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        NSLog("%@", "foundPeer: \(peerID)")
        NSLog("%@", "invitePeer: \(peerID)")
        browser.invitePeer(peerID, to: self.session, withContext: nil, timeout: 10)
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        NSLog("%@", "lostPeer: \(peerID)")
    }
    
}

extension CardSwapBLEModel : MCSessionDelegate {
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case MCSessionState.connected:
            print("Connected: \(peerID.displayName)")
            self.delegate?.connectedDevicesChanged(manager: self, connectedDevices: session.connectedPeers.map{$0.displayName})
            
        case MCSessionState.connecting:
            print("Connecting: \(peerID.displayName)")
            
        case MCSessionState.notConnected:
            print("Not Connected: \(peerID.displayName)")
        }
 
        self.delegate?.connectedDevicesChanged(manager: self, connectedDevices:
            session.connectedPeers.map{$0.displayName})
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        NSLog("%@", "didReceiveData: \(data)")

        let cardJson = String(data: data, encoding: .utf8)!
        print(1)
        self.delegate?.CardSwapfunc(manager: self, cardToSwap: cardJson )
        
        var saveCard = Card(referencedId: nil, firstName: nil, lastName: nil,company: nil, email: nil, phone: nil)
           saveCard = saveCard.jsonToCard(cardJson: cardJson)
        
        UpdateCardDatabase().saveCard(firstname: saveCard.firstName!, lastname: saveCard.lastName!, company: saveCard.company!, email: saveCard.email!, phone: saveCard.phone!)
        print("would send to core data")
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        NSLog("%@", "didReceiveStream")
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        NSLog("%@", "didStartReceivingResourceWithName")
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL, withError error: Error?) {
        NSLog("%@", "didFinishReceivingResourceWithName")
    }
    
}
