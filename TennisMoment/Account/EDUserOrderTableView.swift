//
//  TMUserOrderTableView.swift
//  TMMS
//
//  Created by Jason Zhang on 2023/4/29.
//

import Foundation
import JXSegmentedView
import UIKit

class TMUserOrderTableView: UITableView {}

extension TMUserOrderTableView: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return self
    }
}
