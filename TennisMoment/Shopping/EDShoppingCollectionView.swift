//
//  TMClubContentView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/14.
//

import Foundation
import TMComponent
import UIKit

class TMShoppingCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    var coms: [Commodity] = []
    init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout, coms: [Commodity]) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.coms = coms
        backgroundColor = UIColor(named: "BackgroundGray")
        delegate = self
        dataSource = self
        register(TMCommodityCell.self, forCellWithReuseIdentifier: "commodityies")
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func applyFilter(coms: [Commodity]) {
        self.coms = coms
        reloadData()
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        coms.count
    }

    func collectionView(_: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "commodityies", for: indexPath) as! TMCommodityCell
        cell.setupUI()
        cell.setupEvent(icon: coms[indexPath.row].images[0], intro: coms[indexPath.row].name, price: coms[indexPath.row].price, turnOver: coms[indexPath.row].orders)
        return cell
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = TMComContentViewController()
        vc.com = coms[indexPath.row]
        if let parentVC = getParentViewController() {
            parentVC.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
