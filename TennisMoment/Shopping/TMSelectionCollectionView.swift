//
//  TMSelectionCollectionView.swift
//  TMMS
//
//  Created by Jason Zhang on 2023/4/22.
//

import Foundation
import UIKit

class TMSelectionCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    var com: Commodity = Commodity()
    var selectedRow: Int = 0
    var selectedCompletionHandler: ((Option) -> Void)?
    init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout, com: Commodity) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.com = com
        backgroundColor = UIColor(named: "BackgroundGray")
        delegate = self
        dataSource = self
        register(TMCagSelectionCell.self, forCellWithReuseIdentifier: "cagSelections")
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func applyFilter(com: Commodity) {
        self.com = com
        reloadData()
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        com.options.count
    }

    func collectionView(_: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "cagSelections", for: indexPath) as! TMCagSelectionCell
        cell.setupUI()
        cell.setupEvent(icon: com.options[indexPath.row].image)
        cell.addObserver(cell, forKeyPath: "isBeenSelected", options: [.new, .old], context: nil)
        if indexPath.row == selectedRow {
            cell.isBeenSelected = true
        }
        return cell
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        select(at: indexPath)
    }

    func select(at indexPath: IndexPath) {
        let cell = cellForItem(at: IndexPath(row: selectedRow, section: 0)) as? TMCagSelectionCell
        cell?.isBeenSelected = false
        selectedRow = indexPath.row
        (selectedCompletionHandler ?? { _ in })(com.options[indexPath.row])

        let newSelectedCell = cellForItem(at: indexPath) as? TMCagSelectionCell
        newSelectedCell?.isBeenSelected = true
    }
}
