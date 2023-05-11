//
//  TMUserAllHistoryGamesViewController.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/4/15.
//
import Foundation
import TMComponent
import UIKit

class TMUserAllHistoryGamesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var viewUpCompletionHandler: () -> Void = {}
    var viewDownCompletionHandler: () -> Void = {}
    lazy var opponentLabel: UILabel = {
        let iconView = UILabel()
        return iconView
    }()

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var placeLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var resultLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var scheduleList: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    // 无比赛时提示窗口
    lazy var alartView: UILabel = {
        let view = UILabel()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundGray")
        view.addSubview(opponentLabel)
        view.addSubview(dateLabel)
        view.addSubview(resultLabel)
        view.addSubview(alartView)
        view.addSubview(placeLabel)
        view.insertSubview(scheduleList, belowSubview: opponentLabel)

        opponentLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.right.equalTo(resultLabel.snp.left).offset(6)
            make.width.equalTo(178)
            make.height.equalTo(44)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(opponentLabel.snp.top)
            make.left.equalToSuperview().offset(68)
            make.width.equalTo(158)
            make.height.equalTo(opponentLabel.snp.height)
        }
        placeLabel.snp.makeConstraints { make in
            make.top.equalTo(opponentLabel.snp.top)
            make.left.equalTo(dateLabel.snp.right)
            make.right.equalTo(opponentLabel.snp.left)
            make.height.equalTo(opponentLabel.snp.height)
        }
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(opponentLabel.snp.top)
            make.width.equalTo(228)
            make.right.equalToSuperview().offset(-36)
            make.height.equalTo(opponentLabel.snp.height)
        }
        scheduleList.snp.makeConstraints { make in
            make.top.equalTo(opponentLabel.snp.bottom)
            make.bottom.equalToSuperview()
            make.left.equalTo(dateLabel.snp.left)
            make.right.equalTo(resultLabel.snp.right)
        }
        alartView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(40)
        }

        opponentLabel.text = NSLocalizedString("Opponent", comment: "")
        dateLabel.text = NSLocalizedString("Date", comment: "")
        resultLabel.text = NSLocalizedString("Result", comment: "")
        placeLabel.text = NSLocalizedString("Place", comment: "")
        opponentLabel.font = UIFont.systemFont(ofSize: 21)
        dateLabel.font = UIFont.systemFont(ofSize: 21)
        resultLabel.font = UIFont.systemFont(ofSize: 21)
        placeLabel.font = UIFont.systemFont(ofSize: 21)
        scheduleList.delegate = self
        scheduleList.dataSource = self
        scheduleList.register(TMHistoryGameCell.self, forCellReuseIdentifier: "TMHistoryGameCell")
        scheduleList.separatorStyle = .none
        scheduleList.showsVerticalScrollIndicator = false
        scheduleList.showsHorizontalScrollIndicator = false
        scheduleList.allowsSelectionDuringEditing = true
        scheduleList.backgroundColor = UIColor(named: "BackgroundGray")

        if TMUser.user.allHistoryGames.count == 0 {
            setupAlart()
        } else {
            opponentLabel.isHidden = false
            dateLabel.isHidden = false
            resultLabel.isHidden = false
            scheduleList.isHidden = false
            alartView.isHidden = true
        }
    }

    func setupAlart() {
        opponentLabel.isHidden = true
        dateLabel.isHidden = true
        resultLabel.isHidden = true
        scheduleList.isHidden = true
        alartView.isHidden = false

        alartView.text = NSLocalizedString("You don't have any game to finish", comment: "")
        alartView.font = UIFont.systemFont(ofSize: 22)
        alartView.textAlignment = .center
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        42
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        TMUser.user.allHistoryGames.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMHistoryGameCell()
        cell.selectionStyle = .none
        cell.showsReorderControl = true // 显示移动编辑样式
        cell.editingAccessoryType = .disclosureIndicator // 显示向右箭头的编辑样式
        cell.setupEvent(game: TMUser.user.allHistoryGames[indexPath.row])
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TMGameStatsDetailViewController()
        vc.game = TMUser.user.allHistoryGames[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
