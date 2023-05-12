//
//  TMBillTableViewController.swift
//  TMMS
//
//  Created by Jason Zhang on 2023/4/24.
//

import Foundation
import UIKit

class TMBillTableViewController: UITableViewController {
    var bills: [Bill] = []

    override func viewDidLoad() {
        tableView.register(TMComBillingCell.self, forCellReuseIdentifier: "billing")
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        super.tableView(tableView, numberOfRowsInSection: section)
        return bills.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        super.tableView(tableView, heightForRowAt: indexPath)
        return 168
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        super.tableView(tableView, cellForRowAt: indexPath)
        let cell = TMComBillingCell()
        cell.setupEvent(bill: bills[indexPath.row])
        return cell
    }
}
