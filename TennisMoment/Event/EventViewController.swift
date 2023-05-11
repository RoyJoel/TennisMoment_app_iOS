//
//  EventViewController.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2022/12/26.
//

import Alamofire
import Foundation
import MapKit
import SwiftyJSON
import TMComponent
import UIKit

class EventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var clubs: [Club] = [Club(), Club(), Club(), Club(), Club(), Club()]
    lazy var clubListView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    lazy var clubContentView: TMClubContentView = {
        let view = TMClubContentView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = ""
        navigationController?.navigationBar.tintColor = UIColor(named: "ContentBackground")

        view.backgroundColor = UIColor(named: "BackgroundGray")
        view.addSubview(clubListView)
        view.insertSubview(clubContentView, belowSubview: clubListView)

        clubListView.backgroundColor = UIColor(named: "BackgroundGray")
        clubListView.delegate = self
        clubListView.separatorStyle = .none
        clubListView.showsVerticalScrollIndicator = false
        clubListView.showsHorizontalScrollIndicator = false
        if #available(iOS 15.0, *) {
            clubListView.sectionHeaderTopPadding = 0
        }
        clubListView.register(TMClubTableViewCell.self, forCellReuseIdentifier: "TMClubTableViewCell")
        clubListView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(38)
            make.top.equalToSuperview().offset(32)
            make.width.equalTo(UIStandard.shared.screenWidth * 0.3)
            make.height.equalTo(UIStandard.shared.screenHeight * 0.85)
        }

        clubContentView.backgroundColor = UIColor(named: "ComponentBackground")
        clubContentView.frame = CGRect(x: 38, y: 32, width: UIStandard.shared.screenWidth * 0.3, height: UIStandard.shared.screenHeight * 0.85)
        clubContentView.setup(clubContentView.bounds, clubContentView.layer.position, CGRect(x: 0, y: 0, width: UIStandard.shared.screenWidth * 0.6, height: UIStandard.shared.screenHeight * 0.85), CGPoint(x: UIStandard.shared.screenWidth * 0.6 + 62, y: 32 + UIStandard.shared.screenHeight * 0.425), 0.3)
        clubListView.dataSource = self
        clubContentView.setupUI()
        clubListView.tab_startAnimation {
            TMClubRequest.getInfos(ids: TMUser.user.allClubs) { clubs in
                self.clubs = clubs
                self.clubListView.reloadData()
                self.clubListView.tab_endAnimationEaseOut()
            }
        }
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: Notification.Name(ToastNotification.DataFreshToast.rawValue), object: nil)
    }

    func showContent() {
        clubContentView.scaleTo(false)
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        clubs.count
    }

    func tableView(_: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        let label = UILabel()
        label.text = NSLocalizedString("My Club", comment: "")
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        132
    }

    func tableView(_: UITableView, heightForFooterInSection _: Int) -> CGFloat {
        0
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        clubContentView.setupEvent(club: clubs[indexPath.row])
        showContent()
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMClubTableViewCell()
        cell.setupUI()
        cell.selectionStyle = .none
        cell.setupEvent(clubIcon: clubs[indexPath.row].icon.toPng(), clubName: clubs[indexPath.row].name)
        return cell
    }

    @objc func refreshData() {
        clubListView.tab_startAnimation {
            TMClubRequest.getInfos(ids: TMUser.user.allClubs) { clubs in
                self.clubs = clubs
                self.clubListView.reloadData()
                self.clubListView.tab_endAnimationEaseOut()
            }
        }
    }
}
