//
//  MenuViewController.swift
//  Linked Cards
//
//  Created by Ben Duke on 16/06/17.
//  Copyright © 2017 Ben Duke. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    let menuArray = ["MyCards", "MyCard", "CardSwap"]
    let arrayMenuLabels = ["My Cards", "My Card", "Card Swap"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MyCards" {
            let _ : CardListViewController = segue.destination as! CardListViewController
        }
        else if segue.identifier == "CardSwap" {
            let _ : CardSwapViewController = segue.destination as! CardSwapViewController
        }
    }

}
extension MenuViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell") as! MenuTableViewCell
        
        cell.setUpMenu(labelText: arrayMenuLabels[indexPath.row])
        
        
        cell.layer.cornerRadius = 10
        let shadowPath2 = UIBezierPath(rect: cell.bounds)
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: CGFloat(1.0), height: CGFloat(3.0))
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowPath = shadowPath2.cgPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: menuArray[indexPath.row], sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }
}
