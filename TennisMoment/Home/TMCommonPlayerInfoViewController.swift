//
//  TMCommonPlayerInfoViewController.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/4/11.
//

import Foundation
import TMComponent
import UIKit

class TMCommonPlayerInfoViewController: UIViewController, UITableViewDelegate {
    let infoTableViewDelegate = InfoTableViewDelegate()
    let commonStatsTableViewDelegate = CommonStatsTableViewDelegate()
    let serveStatsDataSource = ServeStatsTableViewDataSource()
    let commonStatsDataSource = CommonStatsTableViewDataSource()
    let infoDataSource = InfoTableViewDataSource()

    var player: Player = Player()
    var games: [Game] = []

    lazy var player1IconView: TMIconView = {
        let iconView = TMIconView()
        return iconView
    }()

    lazy var player1RankingLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var infoTableView: UITableView = {
        let view = UITableView()
        return view
    }()

    lazy var resultLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var resultBackgroundView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var serveStatsBackgroundView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var serveStatsLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var serveStatsView: UITableView = {
        let view = UITableView()
        return view
    }()

    lazy var commonStatsBackgroundView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var commonStatsLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var commonStatsView: UITableView = {
        let view = UITableView()
        return view
    }()

    lazy var addFriendBtn: TMButton = {
        let btn = TMButton()
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundGray")
        view.addSubview(player1IconView)
        view.addSubview(player1RankingLabel)
        view.addSubview(resultBackgroundView)
        view.addSubview(addFriendBtn)
        resultBackgroundView.addSubview(infoTableView)
        resultBackgroundView.addSubview(resultLabel)
        view.addSubview(commonStatsBackgroundView)
        commonStatsBackgroundView.addSubview(commonStatsLabel)
        commonStatsBackgroundView.addSubview(commonStatsView)
        view.addSubview(serveStatsBackgroundView)
        serveStatsBackgroundView.addSubview(serveStatsLabel)
        serveStatsBackgroundView.addSubview(serveStatsView)

        player1IconView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(12)
            make.width.equalTo(138)
            make.height.equalTo(188)
        }
        player1RankingLabel.snp.makeConstraints { make in
            make.top.equalTo(player1IconView.snp.bottom).offset(6)
            make.left.equalTo(player1IconView.snp.left)
            make.width.equalTo(player1IconView.snp.width)
            make.height.equalTo(22)
        }
        addFriendBtn.snp.makeConstraints { make in
            make.top.equalTo(player1RankingLabel.snp.bottom).offset(12)
            make.left.equalTo(player1IconView.snp.left)
            make.right.equalTo(player1IconView.snp.right)
            make.height.equalTo(50)
        }
        resultBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(player1IconView.snp.top).offset(12)
            make.width.equalTo(258)
            make.left.equalTo(player1IconView.snp.right).offset(12)
            make.height.equalTo(268)
        }
        resultLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(12)
            make.width.equalTo(88)
            make.height.equalTo(25)
        }
        infoTableView.snp.makeConstraints { make in
            make.top.equalTo(resultLabel.snp.bottom).offset(12)
            make.bottom.equalToSuperview().offset(-12)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        commonStatsBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(resultBackgroundView.snp.bottom).offset(12)
            make.right.equalTo(infoTableView.snp.right)
            make.left.equalTo(infoTableView.snp.left)
            make.bottom.equalToSuperview()
        }
        commonStatsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(12)
            make.width.equalTo(112)
            make.height.equalTo(25)
        }
        commonStatsView.snp.makeConstraints { make in
            make.top.equalTo(commonStatsLabel.snp.bottom).offset(12)
            make.bottom.equalToSuperview().offset(-12)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        serveStatsBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(player1IconView.snp.top).offset(12)
            make.right.equalToSuperview().offset(-12)
            make.left.equalTo(resultBackgroundView.snp.right).offset(12)
            make.bottom.equalToSuperview().offset(-12)
        }
        serveStatsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(288)
            make.height.equalTo(25)
        }
        serveStatsView.snp.makeConstraints { make in
            make.top.equalTo(serveStatsLabel.snp.bottom).offset(6)
            make.bottom.equalToSuperview().offset(12)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        resultBackgroundView.backgroundColor = UIColor(named: "ComponentBackground")
        commonStatsBackgroundView.backgroundColor = UIColor(named: "ComponentBackground")
        serveStatsBackgroundView.backgroundColor = UIColor(named: "ComponentBackground")
        resultBackgroundView.setCorner(radii: 15)
        commonStatsBackgroundView.setCorner(radii: 15)
        serveStatsBackgroundView.setCorner(radii: 15)
        player1IconView.setupUI()
        infoTableView.register(TMCommonPlayerInfoTableViewCell.self, forCellReuseIdentifier: "Info")
        commonStatsView.register(TMCommonPlayerInfoTableViewCell.self, forCellReuseIdentifier: "CommonStats")
        serveStatsView.register(TMCommonPlayerInfoTableViewCell.self, forCellReuseIdentifier: "Stats")
        infoTableView.delegate = infoTableViewDelegate
        commonStatsView.delegate = commonStatsTableViewDelegate
        serveStatsView.delegate = self
        resultLabel.text = NSLocalizedString("Basic Info", comment: "")
        commonStatsLabel.text = NSLocalizedString("Stats", comment: "")
        serveStatsLabel.text = NSLocalizedString("STATS", comment: "")
        resultLabel.font = UIFont.systemFont(ofSize: 23)
        commonStatsLabel.font = UIFont.systemFont(ofSize: 23)
        serveStatsLabel.font = UIFont.systemFont(ofSize: 23)
        player1RankingLabel.textAlignment = .center
        serveStatsLabel.textAlignment = .center

        if TMUser.user.friends.contains(where:
            { $0.id == player.id }) {
            let deleteFriendBtnConfig = TMButtonConfig(title: "Delete Friend", action: #selector(self.deleteFriend), actionTarget: self)
            self.addFriendBtn.setUp(with: deleteFriendBtnConfig)
            self.addFriendBtn.backgroundColor = UIColor(named: "AlartBackground")
        } else {
            let addFriendBtnConfig = TMButtonConfig(title: "Add Friend", action: #selector(addFriend), actionTarget: self)
            addFriendBtn.setUp(with: addFriendBtnConfig)
            addFriendBtn.backgroundColor = UIColor(named: "ComponentBackground")
        }

        if TMUser.user.id == player.id {
            addFriendBtn.isHidden = true
        }

        setupEvent(player: player)
    }

    func setupEvent(player: Player) {
        let player1IconConfig = TMIconViewConfig(icon: player.icon.toPng(), name: player.name)

        let firstServeIn = player.careerStats.convertToRealStats().firstServeIn
        let firstServeWon = player.careerStats.convertToRealStats().firstServeWon
        let secondServeIn = player.careerStats.convertToRealStats().secondServeIn
        let secondServeWon = player.careerStats.convertToRealStats().secondServeWon
        let firstReturnServeIn = player.careerStats.convertToRealStats().firstReturnServeIn
        let firstReturnServeWon = player.careerStats.convertToRealStats().firstReturnServeWon
        let secondReturnServeIn = player.careerStats.convertToRealStats().secondReturnServeIn
        let secondReturnServeWon = player.careerStats.convertToRealStats().secondReturnServeWon
        let breakPointSaved = player.careerStats.convertToRealStats().breakPointSaved
        let breakPointConvert = player.careerStats.convertToRealStats().breakPointConvert
        let serveGameWon = player.careerStats.convertToRealStats().serveGameWon
        let returnGameWon = player.careerStats.convertToRealStats().returnGameWon
        let servePointWon = player.careerStats.convertToRealStats().servePointWon
        let returnPointWon = player.careerStats.convertToRealStats().returnPointWon

        let firstServeInConfig = [NSLocalizedString("1ST Serve In", comment: ""), "\(firstServeIn)%"]
        let firstServeWonConfig = [NSLocalizedString("1ST Serve Won", comment: ""), "\(firstServeWon)%"]
        let secondServeInConfig = [NSLocalizedString("2ND Serve In", comment: ""), "\(secondServeIn)%"]
        let secondServeWonConfig = [NSLocalizedString("2ND Serve Won", comment: ""), "\(secondServeWon)%"]
        let breakPointSavedConfig = [NSLocalizedString("Break Point Saved", comment: ""), "\(breakPointSaved)%"]
        let servePointWonConfig = [NSLocalizedString("Serve Point Won", comment: ""), "\(servePointWon)%"]
        let serveGameWonConfig = [NSLocalizedString("Serve Game Won", comment: ""), "\(serveGameWon)%"]

        let firstReturnServeInConfig = [NSLocalizedString("1ST Return In", comment: ""), "\(firstReturnServeIn)%"]
        let firstReturnServeWonConfig = [NSLocalizedString("1ST Return Won", comment: ""), "\(firstReturnServeWon)%"]
        let secondReturnServeInConfig = [NSLocalizedString("2ND Return In", comment: ""), "\(secondReturnServeIn)%"]
        let secondReturnServeWonConfig = [NSLocalizedString("2ND Return Won", comment: ""), "\(secondReturnServeWon)%"]
        let breakPointConvertConfig = [NSLocalizedString("Break Point Convert", comment: ""), "\(breakPointConvert)%"]
        let returnPointWonConfig = [NSLocalizedString("Return Point Won", comment: ""), "\(returnPointWon)%"]
        let returnGameWonConfig = [NSLocalizedString("Return Game Won", comment: ""), "\(returnGameWon)%"]

        let acesConfig = [NSLocalizedString("Aces", comment: ""), "\(player.careerStats.aces)"]
        let doubleFaultsConfig = [NSLocalizedString("Double Faults", comment: ""), "\(player.careerStats.doubleFaults)"]
        let returnAcesConfig = [NSLocalizedString("Return Aces", comment: ""), "\(player.careerStats.returnAces)"]
        let netPointsConfig = [NSLocalizedString("Net Points", comment: ""), "\(player.careerStats.netPoints)"]
        let unforcedErrorsConfig = [NSLocalizedString("UEs", comment: ""), "\(player.careerStats.unforcedErrors)"]
        let forehandWinnersConfig = [NSLocalizedString("FH Winners", comment: ""), "\(player.careerStats.forehandWinners)"]
        let backhandWinnersConfig = [NSLocalizedString("BH Winners", comment: ""), "\(player.careerStats.backhandWinners)"]

        let ageConfig = [NSLocalizedString("Age", comment: ""), "\(player.age)"]
        let widthConfig = [NSLocalizedString("Width", comment: ""), "\(player.width)"]
        let yearPlayedConfig = [NSLocalizedString("YearsPlayed", comment: ""), "\(player.yearsPlayed)"]
        let heightConfig = [NSLocalizedString("Height", comment: ""), "\(player.height)"]
        let gripConfig = [NSLocalizedString("Grip", comment: ""), "\(player.grip.rawValue)"]
        let backhandConfig = [NSLocalizedString("Backhand", comment: ""), "\(player.backhand.rawValue)"]
        let pointsConfig = [NSLocalizedString("Current Points", comment: ""), "\(player.points)"]

        infoDataSource.configs = [ageConfig, yearPlayedConfig, heightConfig, widthConfig, gripConfig, backhandConfig, pointsConfig]

        commonStatsDataSource.configs = [acesConfig, doubleFaultsConfig, returnAcesConfig, netPointsConfig, unforcedErrorsConfig, forehandWinnersConfig, backhandWinnersConfig]

        serveStatsDataSource.configs = [firstServeInConfig, firstServeWonConfig, secondServeInConfig, secondServeWonConfig, breakPointSavedConfig, servePointWonConfig, serveGameWonConfig, firstReturnServeInConfig, firstReturnServeWonConfig, secondReturnServeInConfig, secondReturnServeWonConfig, breakPointConvertConfig, returnPointWonConfig, returnGameWonConfig]

        player1IconView.setupEvent(config: player1IconConfig)
        infoTableView.dataSource = infoDataSource
        commonStatsView.dataSource = commonStatsDataSource
        serveStatsView.dataSource = serveStatsDataSource
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        48
    }

    @objc func addFriend() {
        TMUser.user.friends.append(player)
        NotificationCenter.default.post(name: Notification.Name(ToastNotification.DataFreshToast.notificationName.rawValue), object: nil)
        TMUser.addFriend(player.id) { res in
            if res {
                let toastView = UILabel()
                toastView.text = "\(self.player.name) is already your friend"
                toastView.bounds = self.view.bounds
                toastView.backgroundColor = UIColor(named: "ComponentBackground")
                toastView.textAlignment = .center
                toastView.setCorner(radii: 15)
                self.view.showToast(toastView, position: .center) { _ in
                }
                let deleteFriendBtnConfig = TMButtonConfig(title: "Delete Friend", action: #selector(self.deleteFriend), actionTarget: self)
                self.addFriendBtn.setUp(with: deleteFriendBtnConfig)
                self.addFriendBtn.backgroundColor = UIColor(named: "AlartBackground")
            } else {
                let toastView = UILabel()
                toastView.text = NSLocalizedString("add friend fail", comment: "")
                toastView.bounds = self.view.bounds
                toastView.backgroundColor = UIColor(named: "ComponentBackground")
                toastView.textAlignment = .center
                toastView.setCorner(radii: 15)
                self.view.showToast(toastView, position: .center) { _ in
                }
            }
        }
    }

    @objc func deleteFriend() {
        TMUser.user.friends.removeAll(where: { $0.id == player.id })
        NotificationCenter.default.post(name: Notification.Name(ToastNotification.DataFreshToast.notificationName.rawValue), object: nil)
        TMUser.deleteFriend(player.id) { _ in
            let addFriendBtnConfig = TMButtonConfig(title: "Add Friend", action: #selector(self.addFriend), actionTarget: self)
            self.addFriendBtn.setUp(with: addFriendBtnConfig)
            self.addFriendBtn.backgroundColor = UIColor(named: "ComponentBackground")
        }
    }
}

class InfoTableViewDelegate: NSObject, UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        30
    }
}

class CommonStatsTableViewDelegate: NSObject, UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        40
    }
}

class ServeStatsTableViewDataSource: NSObject, UITableViewDataSource {
    var configs: [[String]] = []
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        configs.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMCommonPlayerInfoTableViewCell()
        cell.setupEvent(title: configs[indexPath.row][0], info: configs[indexPath.row][1])
        return cell
    }
}

class ReturnStatsTableViewDataSource: NSObject, UITableViewDataSource {
    var configs: [[String]] = []
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        configs.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMCommonPlayerInfoTableViewCell()
        cell.setupEvent(title: configs[indexPath.row][0], info: configs[indexPath.row][1])
        return cell
    }
}

class CommonStatsTableViewDataSource: NSObject, UITableViewDataSource {
    var configs: [[String]] = []
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        configs.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMCommonPlayerInfoTableViewCell()
        cell.setupEvent(title: configs[indexPath.row][0], info: configs[indexPath.row][1])
        return cell
    }
}

class InfoTableViewDataSource: NSObject, UITableViewDataSource {
    var configs: [[String]] = []
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        configs.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMCommonPlayerInfoTableViewCell()
        cell.setupEvent(title: configs[indexPath.row][0], info: configs[indexPath.row][1])
        return cell
    }
}
