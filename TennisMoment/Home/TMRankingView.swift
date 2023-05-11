//
//  TMRankingView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/4/16.
//

import Foundation
import TMComponent
import UIKit

class TMRankingView: TMView, UITableViewDataSource, UITableViewDelegate {
    let selections = selectionDataSource()
    var rankings: [Player] = TMUser.user.friends

    lazy var selectionView: TMPopUpView = {
        let view = TMPopUpView()
        return view
    }()

    lazy var titleView: UILabel = {
        let view = UILabel()
        return view
    }()

    lazy var playerLabel: UILabel = {
        let iconView = UILabel()
        return iconView
    }()

    lazy var rankLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var dataLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var rankingTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    // 无比赛时提示窗口
    lazy var alartView: UILabel = {
        let view = UILabel()
        return view
    }()

    func setupUI() {
        backgroundColor = UIColor(named: "ComponentBackground")
        setCorner(radii: 15)
        addSubview(selectionView)
        addSubview(titleView)
        addSubview(playerLabel)
        addSubview(rankLabel)
        addSubview(dataLabel)
        addSubview(alartView)
        insertSubview(rankingTableView, belowSubview: playerLabel)
        bringSubviewToFront(selectionView)

        selectionView.frame = CGRect(x: 36, y: 12, width: 188, height: 40)
        titleView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalTo(selectionView.snp.right)
            make.width.equalTo(188)
            make.height.equalTo(40)
        }
        playerLabel.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(6)
            make.left.equalTo(rankLabel.snp.right)
            make.width.equalTo(216)
            make.height.equalTo(50)
        }
        rankLabel.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(36)
            make.width.equalTo(68)
            make.height.equalTo(50)
        }
        dataLabel.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(6)
            make.left.equalTo(playerLabel.snp.right)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(50)
        }
        rankingTableView.snp.makeConstraints { make in
            make.top.equalTo(playerLabel.snp.bottom)
            make.bottom.equalToSuperview()
            make.left.equalTo(rankLabel.snp.left)
            make.right.equalToSuperview()
        }
        alartView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(40)
        }

        selectionView.dataSource = selections
        selectionView.delegate = selectionView
        selectionView.setupUI()
        selectionView.selectedCompletionHandler = { index in
            let selectedItem = self.selections.configs.remove(at: index)
            self.selections.configs.insert(selectedItem, at: 0)
            self.rankings = self.sort(by: self.selections.configs[0])
            self.rankingTableView.reloadData()
            self.dataLabel.text = NSLocalizedString(self.selections.configs[0].rawValue, comment: "")
        }

        titleView.text = NSLocalizedString("Rankings", comment: "")

        playerLabel.text = NSLocalizedString("Player", comment: "")
        rankLabel.text = NSLocalizedString("Rank", comment: "")
        dataLabel.text = NSLocalizedString(selections.configs[0].rawValue, comment: "")
        playerLabel.font = UIFont.systemFont(ofSize: 21)
        rankLabel.font = UIFont.systemFont(ofSize: 21)
        dataLabel.font = UIFont.systemFont(ofSize: 21)

        rankingTableView.delegate = self
        rankingTableView.dataSource = self
        rankingTableView.register(TMRankingCell.self, forCellReuseIdentifier: "TMRankingCell")
        rankingTableView.separatorStyle = .none
        rankingTableView.showsVerticalScrollIndicator = false
        rankingTableView.showsHorizontalScrollIndicator = false
        rankingTableView.allowsSelectionDuringEditing = true
        rankingTableView.backgroundColor = UIColor(named: "ComponentBackground")

        if TMUser.user.friends.count == 0 {
            setupAlart()
        } else {
            playerLabel.isHidden = false
            rankLabel.isHidden = false
            dataLabel.isHidden = false
            rankingTableView.isHidden = false
            alartView.isHidden = true
        }
    }

    func setupAlart() {
        playerLabel.isHidden = true
        rankLabel.isHidden = true
        dataLabel.isHidden = true
        rankingTableView.isHidden = true
        alartView.isHidden = false

        alartView.text = NSLocalizedString("You don't have any friend", comment: "")
        alartView.font = UIFont.systemFont(ofSize: 22)
        alartView.textAlignment = .center
    }

    func sort(by item: selectionItem) -> [Player] {
        switch item {
        case .Points:
            return TMUser.user.friends.sorted { $0.points > $1.points }
        case .Aces:
            return TMUser.user.friends.sorted { $0.careerStats.convertToRealStats().aces > $1.careerStats.convertToRealStats().aces }
        case .DoubleFaults:
            return TMUser.user.friends.sorted { $0.careerStats.convertToRealStats().doubleFaults < $1.careerStats.convertToRealStats().doubleFaults }
        case .ReturnAces:
            return TMUser.user.friends.sorted { $0.careerStats.convertToRealStats().returnAces > $1.careerStats.convertToRealStats().returnAces }
        case .NetPoints:
            return TMUser.user.friends.sorted { $0.careerStats.convertToRealStats().netPoints > $1.careerStats.convertToRealStats().netPoints }
        case .UnforcedErrors:
            return TMUser.user.friends.sorted { $0.careerStats.convertToRealStats().unforcedErrors < $1.careerStats.convertToRealStats().unforcedErrors }
        case .ForehandWinners:
            return TMUser.user.friends.sorted { $0.careerStats.convertToRealStats().forehandWinners > $1.careerStats.convertToRealStats().forehandWinners }
        case .BackhandWinners:
            return TMUser.user.friends.sorted { $0.careerStats.convertToRealStats().backhandWinners > $1.careerStats.convertToRealStats().backhandWinners }
        case .FirstServeIn:
            return TMUser.user.friends.sorted { $0.careerStats.convertToRealStats().firstServeIn > $1.careerStats.convertToRealStats().firstServeIn }
        case .FirstServeWon:
            return TMUser.user.friends.sorted { $0.careerStats.convertToRealStats().firstServeWon > $1.careerStats.convertToRealStats().firstServeWon }
        case .SecondServeIn:
            return TMUser.user.friends.sorted { $0.careerStats.convertToRealStats().secondServeIn > $1.careerStats.convertToRealStats().secondServeIn }
        case .SecondServeWon:
            return TMUser.user.friends.sorted { $0.careerStats.convertToRealStats().secondServeWon > $1.careerStats.convertToRealStats().secondServeWon }
        case .FirstReturnServeIn:
            return TMUser.user.friends.sorted { $0.careerStats.convertToRealStats().firstReturnServeIn > $1.careerStats.convertToRealStats().firstReturnServeIn }
        case .FirstReturnServeWon:
            return TMUser.user.friends.sorted { $0.careerStats.convertToRealStats().firstReturnServeWon > $1.careerStats.convertToRealStats().firstReturnServeWon }
        case .SecondReturnServeIn:
            return TMUser.user.friends.sorted { $0.careerStats.convertToRealStats().secondReturnServeIn > $1.careerStats.convertToRealStats().secondReturnServeIn }
        case .SecondReturnServeWon:
            return TMUser.user.friends.sorted { $0.careerStats.convertToRealStats().secondReturnServeWon > $1.careerStats.convertToRealStats().secondReturnServeWon }
        case .BreakPointSaved:
            return TMUser.user.friends.sorted { $0.careerStats.convertToRealStats().breakPointSaved > $1.careerStats.convertToRealStats().breakPointSaved }
        case .BreakPointConvert:
            return TMUser.user.friends.sorted { $0.careerStats.convertToRealStats().breakPointConvert > $1.careerStats.convertToRealStats().breakPointConvert }
        case .ServeGameWon:
            return TMUser.user.friends.sorted { $0.careerStats.convertToRealStats().serveGameWon > $1.careerStats.convertToRealStats().serveGameWon }
        case .ReturnGameWon:
            return TMUser.user.friends.sorted { $0.careerStats.convertToRealStats().returnGameWon > $1.careerStats.convertToRealStats().returnGameWon }
        case .ServePointWon:
            return TMUser.user.friends.sorted { $0.careerStats.convertToRealStats().servePointWon > $1.careerStats.convertToRealStats().servePointWon }
        case .ReturnPointWon:
            return TMUser.user.friends.sorted { $0.careerStats.convertToRealStats().returnPointWon > $1.careerStats.convertToRealStats().returnPointWon }
        }
    }

    func refreshData() {
        if TMUser.user.friends.count == 0 {
            setupAlart()
        } else {
            playerLabel.isHidden = false
            rankLabel.isHidden = false
            dataLabel.isHidden = false
            rankingTableView.isHidden = false
            alartView.isHidden = true
        }
        rankingTableView.reloadData()
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        42
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        rankings = sort(by: selections.configs[0])
        return rankings.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMRankingCell()
        cell.selectionStyle = .none
        cell.setupEvent(rank: indexPath.row + 1, player: rankings[indexPath.row], selection: selections.configs[0])
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TMCommonPlayerInfoViewController()
        vc.player = rankings[indexPath.row]
        if let parentVC = getParentViewController() {
            parentVC.present(vc, animated: true)
        }
    }
}

class selectionDataSource: NSObject, UITableViewDataSource {
    var configs = selectionItem.allCases

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        configs.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMPopUpCell()
        cell.setupUI()
        cell.setupEvent(title: NSLocalizedString(configs[indexPath.row].rawValue, comment: ""))
        return cell
    }
}

enum selectionItem: String, CaseIterable {
    case Points = "Current Points"
    case Aces
    case DoubleFaults = "Double Faults"
    case ReturnAces = "Return Aces"
    case NetPoints = "Net Points"
    case UnforcedErrors = "Unforced Errors"
    case ForehandWinners = "Forehand Winners"
    case BackhandWinners = "Backhand Winners"
    case FirstServeIn = "First Serve In"
    case FirstServeWon = "First Serve Won"
    case SecondServeIn = "Second Serve In"
    case SecondServeWon = "Second Serve Won"
    case FirstReturnServeIn = "First Return In"
    case FirstReturnServeWon = "First Return Won"
    case SecondReturnServeIn = "Second Return In"
    case SecondReturnServeWon = "Second Return Won"
    case BreakPointSaved = "Break Point Saved"
    case BreakPointConvert = "Break Point Convert"
    case ServeGameWon = "Serve Game Won"
    case ReturnGameWon = "Return Game Won"
    case ServePointWon = "Serve Point Won"
    case ReturnPointWon = "Return Point Won"
}
