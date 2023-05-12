//
//  ShoppingViewController.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/5/11.
//

import Foundation
import UIKit

class ShoppingViewController: TMViewController {
    let layout = TMFlowLayout(itemCount: com.count)

    lazy var titleView: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var filter: TMFilterView = {
        let view = TMFilterView()
        return view
    }()

    lazy var shoppingCollectionView: TMShoppingCollectionView = {
        let view = TMShoppingCollectionView(frame: .zero, collectionViewLayout: layout, coms: com)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view = TMEventView()
        view.addSubview(titleView)
        view.addSubview(filter)
        view.addSubview(shoppingCollectionView)
        view.bringSubviewToFront(filter)

        titleView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(32)
            make.width.equalTo(208)
            make.height.equalTo(50)
        }

        titleView.font = UIFont.systemFont(ofSize: 36)

        filter.frame = CGRect(x: UIStandard.shared.screenWidth - 136, y: 32, width: 112, height: 44)

        filter.setup(filter.bounds, filter.layer.position, CGRect(x: 0, y: 0, width: 300, height: filter.bounds.height), CGPoint(x: filter.layer.position.x - 94, y: filter.layer.position.y), 0.3)

        shoppingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(12)
            make.left.equalTo(titleView.snp.left)
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-98)
        }

        filter.setupUI()
        filter.clipsToBounds = false

        titleView.text = "积分商城"
        filter.completionHandler = { coms in
            self.shoppingCollectionView.applyFilter(coms: coms)
        }
    }
}
