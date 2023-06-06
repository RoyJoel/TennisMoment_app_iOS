//
//  AccountViewController.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2022/12/26.
//

import Foundation
import SwiftyJSON
import TMComponent
import UIKit

class AccountViewController: TMViewController {
    lazy var settingView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "gearshape")
        return imageView
    }()

    lazy var iconView: TMIconView = {
        let iconView = TMIconView()
        return iconView
    }()

    lazy var pointLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var userOrderView: TMButton = {
        let view = TMButton()
        return view
    }()

    lazy var allHistoryGamesNavBtn: TMButton = {
        let view = TMButton()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(settingView)
        view.addSubview(iconView)
        view.addSubview(pointLabel)
        view.addSubview(userOrderView)
        view.addSubview(allHistoryGamesNavBtn)

        iconView.setupUI()
        let iconConfig = TMIconViewConfig(icon: TMUser.user.icon.toPng(), name: TMUser.user.name)
        iconView.setupEvent(config: iconConfig)
        settingView.tintColor = UIColor(named: "ContentBackground")
        settingView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(58)
            make.left.equalToSuperview().offset(44)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }

        pointLabel.snp.makeConstraints { make in
            make.top.equalTo(iconView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }

        userOrderView.snp.makeConstraints { make in
            make.top.equalTo(pointLabel.snp.bottom).offset(24)
            make.height.equalTo(68)
            make.centerX.equalToSuperview()
            make.width.equalTo(138)
        }
        allHistoryGamesNavBtn.snp.makeConstraints { make in
            make.top.equalTo(userOrderView.snp.bottom).offset(24)
            make.height.equalTo(68)
            make.centerX.equalToSuperview()
            make.width.equalTo(138)
        }
        iconView.snp.makeConstraints { make in
            make.top.equalTo(settingView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.width.equalTo(164)
            make.height.equalTo(240)
        }
        settingView.isUserInteractionEnabled = true
        settingView.addTapGesture(self, #selector(settingViewUp))
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: Notification.Name(ToastNotification.DataFreshToast.rawValue), object: nil)
        let userOrderConfig = TMButtonConfig(title: "历史比赛", action: #selector(viewAllGames), actionTarget: self)
        userOrderView.setUp(with: userOrderConfig)

        let userEOrderConfig = TMButtonConfig(title: "积分商城订单", action: #selector(viewAllOrders), actionTarget: self)
        allHistoryGamesNavBtn.setUp(with: userEOrderConfig)

        pointLabel.text = "当前积分：\(TMUser.user.points)"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pointLabel.text = "当前积分：\(TMUser.user.points)"
    }

    @objc func settingViewUp() {
        let vc = TMSettingViewController()
        let navVC = UINavigationController(rootViewController: vc)
        navigationController?.present(navVC, animated: true)
    }

    @objc func refreshData() {
        let iconConfig = TMIconViewConfig(icon: TMUser.user.icon.toPng(), name: TMUser.user.name)
        iconView.setupEvent(config: iconConfig)
    }

    @objc func viewAllGames() {
        let vc = TMUserAllHistoryGamesViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func viewAllOrders() {
        let vc = TMUserOrdersViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
