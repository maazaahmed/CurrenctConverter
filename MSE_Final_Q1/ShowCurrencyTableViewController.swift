//
//  ShowCurrencyTableViewController.swift
//  MSE_Final_Q1
//
//  Created by Macbook Pro on 11/02/2021.
//

import Foundation
import UIKit

class ShowCurrencyTableViewController: UITableViewController{
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath)
        let label1 = cell.viewWithTag(1000) as! UILabel
        let label2 = cell.viewWithTag(2000) as! UILabel
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}
