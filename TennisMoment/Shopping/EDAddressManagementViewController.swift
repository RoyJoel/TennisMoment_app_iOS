//
//  TMAddressManagementViewController.swift
//  TMMS
//
//  Created by Jason Zhang on 2023/4/25.
//

import Foundation
import UIKit

class TMAddressManagementViewController: UITableViewController {
    var selectedCompletionHandler: ((Address) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor(named: "BackgroundGray")
        tableView.register(TMAddressCell.self, forCellReuseIdentifier: "AddressCell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        super.tableView(tableView, cellForRowAt: indexPath)
        let cell = TMAddressCell()
        cell.setupEvent(address: addresss[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        super.tableView(tableView, numberOfRowsInSection: section)
        return addresss.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        super.tableView(tableView, heightForRowAt: indexPath)
        return 143
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let address = (tableView.cellForRow(at: indexPath) as? TMAddressCell)?.address {
            addresss[indexPath.row] = address
            (selectedCompletionHandler ?? { _ in })(address)
        }
        navigationController?.popViewController(animated: true)
    }
}
