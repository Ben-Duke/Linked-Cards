//
//  MenuViewController.swift
//  Linked Cards
//
//  Created by Ben Duke on 16/06/17.
//  Copyright © 2017 Ben Duke. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    let menuLabelArray = ["My Cards", "My Contact Card"]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}
extension MenuViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell") as! MenuTableViewCell
        cell.setUpMenu(labelText: menuLabelArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuLabelArray.count
    }
}
