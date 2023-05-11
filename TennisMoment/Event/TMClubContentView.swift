//
//  TMClubContentView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/14.
//

import Foundation
import TMComponent
import UIKit

class TMClubContentView: TMView, UITableViewDelegate, UITableViewDataSource {
    var events: [Event] = []
    var tourViewPosition = CGPoint(x: 0, y: 0)

    lazy var clubIconView: TMImageView = {
        let imageView = TMImageView()
        return imageView
    }()

    lazy var clubNameView: TMLabel = {
        let label = TMLabel()
        return label
    }()

    lazy var joinBtn: TMButton = {
        let btn = TMButton()
        return btn
    }()

    lazy var introView: TMLabel = {
        let view = TMLabel()
        return view
    }()

    lazy var addressView: TMLabel = {
        let view = TMLabel()
        return view
    }()

    lazy var tourView: UITableView = {
        let view = UITableView()
        return view
    }()

    func setupUI() {
        setCorner(radii: 15)

        addSubview(clubIconView)
        addSubview(clubNameView)
        addSubview(introView)
        addSubview(addressView)
        addSubview(tourView)

        clubIconView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(12)
            make.height.equalTo(90)
            make.width.equalTo(90)
        }
        clubNameView.snp.makeConstraints { make in
            make.top.equalTo(clubIconView.snp.top)
            make.left.equalTo(clubIconView.snp.right).offset(8)
            make.height.equalTo(30)
            make.width.equalTo(200)
        }

        introView.frame = CGRect(x: 110, y: 42, width: 200, height: 30)
        addressView.snp.makeConstraints { make in
            make.top.equalTo(introView.snp.bottom)
            make.left.equalTo(clubNameView.snp.left)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        tourView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(114)
            make.bottom.equalToSuperview().offset(-12)
            make.left.equalTo(clubIconView.snp.left)
            make.right.equalToSuperview().offset(-12)
        }

        clubIconView.setupUI()

        introView.isUserInteractionEnabled = true
        introView.numberOfLines = 20
        introView.setup(introView.bounds, introView.layer.position, CGRect(x: 0, y: 0, width: 300, height: 118), CGPoint(x: introView.layer.position.x + 50, y: introView.layer.position.y + 40), 0.3)

        tourView.setCorner(radii: 15)
        tourView.dataSource = self
        tourView.delegate = self
        tourView.register(TMTourView.self, forCellReuseIdentifier: "TMTourView")
        tourView.separatorStyle = .none
        tourView.showsVerticalScrollIndicator = false
        tourView.showsHorizontalScrollIndicator = false
        tourView.addPanGesture(self, #selector(panToLoadMore))
    }

    func setupEvent(club: Club) {
        events = club.events
        let iconConfig = TMImageViewConfig(image: club.icon.toPng(), contentMode: .scaleAspectFill)
        let nameConfig = TMLabelConfig(title: club.name, font: 20)
        let introConfig = TMLabelConfig(title: club.intro, font: 15)
        let addressConfig = TMLabelConfig(title: club.address, font: 17)
        clubIconView.setupEvent(config: iconConfig)
        clubNameView.setupEvent(config: nameConfig)
        introView.setupEvent(config: introConfig)
        addressView.setupEvent(config: addressConfig)
        tourView.reloadData()
        tourViewPosition = tourView.layer.position
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        events.count
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        242
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMTourView()
        cell.selectionStyle = .none
        cell.setCorner(radii: 15)
        cell.backgroundColor = UIColor(named: "BackgroundGray")
        cell.setupEvent(events[indexPath.row])
        return cell
    }

    @objc func panToLoadMore(sender: UIPanGestureRecognizer) {
        let trans = sender.translation(in: nil)
        // 向上滑动
        if trans.y < 0 {
            if tourView.contentOffset.y != tourView.contentSize.height - tourView.bounds.size.height {
                if tourView.layer.position.y == 900 {
                    tourView.addAnimation(tourView.layer.position.y, tourViewPosition.y, 0.3, "position.y")
                    tourView.layer.position.y = tourViewPosition.y
                } else if tourView.layer.position.y == tourViewPosition.y {
                    tourView.contentOffset.y += -trans.y
                    sender.setTranslation(.zero, in: nil)
                    if tourView.contentOffset.y + tourView.bounds.size.height > tourView.contentSize.height {
                        tourView.contentOffset.y = tourView.contentSize.height - tourView.bounds.size.height
                    }
                }
            }
        } else {
            if tourView.layer.position.y != 900 {
                if tourView.contentOffset.y > 0 {
                    tourView.contentOffset.y -= trans.y
                    sender.setTranslation(.zero, in: nil)
                } else if tourView.contentOffset.y <= 0 {
                    tourView.contentOffset.y = 0
                    tourView.layer.position.y += trans.y
                    if trans.y >= 200 {
                        tourView.addAnimation(tourView.layer.position.y, 900, 0.3, "position.y")
                        tourView.layer.position.y = 900
//                        introView.scaleTo(introView.toggle)
                    } else {
                        tourView.addAnimation(tourView.layer.position.y, tourViewPosition.y, 0.3, "position.y")
                        tourView.layer.position.y = tourViewPosition.y
                    }
                }
            }
        }
    }
}
