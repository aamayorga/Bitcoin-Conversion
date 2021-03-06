//
//  CurrencySelectionTableViewController.swift
//  BitcoinConversion
//
//  Created by Antonio Mayorga on 5/3/19.
//  Copyright © 2019 Rays Industrial Computers. All rights reserved.
//

import UIKit

let CELL_ID = "CurrencySelectionTableViewCell"

protocol CurrencySelectionDelegate {
    func didSelectCurrency(currencySymbol: String)
}

class CurrencySelectionTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var currencyTableView: UITableView!
    
    let currencySymbols = ["USD", "MXN", "CAD", "EUR", "JPY"]
    let currencyNames = ["United States Dollar (USD)", "Mexican Peso (MXN)", "Canadian Dollar (CAD)", "Euro (EUR)", "Japanese Yen (JPY)"]
    
    var currencySelectionDelegate: CurrencySelectionDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyTableView.delegate = self
        currencyTableView.dataSource = self
        currencyTableView.separatorColor = .white
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath)
        cell.textLabel?.text = "\(currencyNames[indexPath.row])"
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCurrency = currencySymbols[indexPath.row]
        currencySelectionDelegate.didSelectCurrency(currencySymbol: selectedCurrency)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
