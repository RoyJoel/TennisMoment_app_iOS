//
//  TMGameSearchingView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/4/10.
//

import Foundation
import TMComponent
import UIKit

class TMGameSearchingView: TMView, UITableViewDataSource, UITableViewDelegate {
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

    lazy var lastResultLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var scheduleList: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    lazy var startGameBtn: TMTitleOrImageButton = {
        let button = TMTitleOrImageButton()
        return button
    }()

    // 无比赛时提示窗口
    lazy var alartView: UILabel = {
        let view = UILabel()
        return view
    }()

    func setupUI() {
        backgroundColor = UIColor(named: "ComponentBackground")
        setCorner(radii: 15)
        addSubview(opponentLabel)
        addSubview(dateLabel)
        addSubview(lastResultLabel)
        addSubview(alartView)
        insertSubview(scheduleList, belowSubview: opponentLabel)

        addSubview(startGameBtn)

        opponentLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(dateLabel.snp.right)
            make.width.equalTo(146)
            make.height.equalTo(50)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(startGameBtn.snp.right).offset(12)
            make.width.equalTo(158)
            make.height.equalTo(50)
        }
        lastResultLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(opponentLabel.snp.right)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(50)
        }
        scheduleList.snp.makeConstraints { make in
            make.top.equalTo(opponentLabel.snp.bottom)
            make.bottom.equalToSuperview()
            make.left.equalTo(dateLabel.snp.left)
            make.right.equalToSuperview()
        }
        alartView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(40)
        }

        startGameBtn.frame = CGRect(x: 0, y: 0, width: 68, height: 68)

        let addScheduleButtonConfig = TMTitleOrImageButtonConfig(image: UIImage(systemName: "clock")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(scheduleGameViewUp), actionTarget: self)
        startGameBtn.setUp(with: addScheduleButtonConfig)

        opponentLabel.text = NSLocalizedString("Opponent", comment: "")
        dateLabel.text = NSLocalizedString("Date", comment: "")
        lastResultLabel.text = NSLocalizedString("Last Result", comment: "")
        opponentLabel.font = UIFont.systemFont(ofSize: 21)
        dateLabel.font = UIFont.systemFont(ofSize: 21)
        lastResultLabel.font = UIFont.systemFont(ofSize: 21)
        scheduleList.delegate = self
        scheduleList.dataSource = self
        scheduleList.register(TMScheduleCell.self, forCellReuseIdentifier: "TMScheduleCell.self")
        scheduleList.separatorStyle = .none
        scheduleList.showsVerticalScrollIndicator = false
        scheduleList.showsHorizontalScrollIndicator = false
        scheduleList.allowsSelectionDuringEditing = true
        scheduleList.backgroundColor = UIColor(named: "ComponentBackground")

        if TMUser.user.allUnfinishedGames.count == 0 {
            setupAlart()
        } else {
            opponentLabel.isHidden = false
            dateLabel.isHidden = false
            lastResultLabel.isHidden = false
            scheduleList.isHidden = false
            alartView.isHidden = true
        }
    }

    func setupAlart() {
        opponentLabel.isHidden = true
        dateLabel.isHidden = true
        lastResultLabel.isHidden = true
        scheduleList.isHidden = true
        alartView.isHidden = false

        alartView.text = NSLocalizedString("You don't have any game to finish", comment: "")
        alartView.font = UIFont.systemFont(ofSize: 22)
        alartView.textAlignment = .center
    }

    override func scaleTo(_ isEnlarge: Bool, completionHandler _: @escaping () -> Void) {
        if !toggle {
            viewUpCompletionHandler()
            let config = TMTitleOrImageButtonConfig(image: UIImage(systemName: "figure.table.tennis")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(scheduleGameViewUp), actionTarget: self)
            startGameBtn.setUp(with: config)
            super.scaleTo(isEnlarge) {
                if TMUser.user.allUnfinishedGames.count != 0 {
                    self.opponentLabel.isHidden = false
                    self.dateLabel.isHidden = false
                    self.lastResultLabel.isHidden = false
                    self.scheduleList.isHidden = false
                    self.alartView.isHidden = true
                } else {
                    self.opponentLabel.isHidden = true
                    self.dateLabel.isHidden = true
                    self.lastResultLabel.isHidden = true
                    self.scheduleList.isHidden = true
                    self.alartView.isHidden = false
                }
            }
        } else {
            opponentLabel.isHidden = true
            dateLabel.isHidden = true
            lastResultLabel.isHidden = true
            scheduleList.isHidden = true
            alartView.isHidden = true
            let config = TMTitleOrImageButtonConfig(image: UIImage(systemName: "clock")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(scheduleGameViewUp), actionTarget: self)
            startGameBtn.setUp(with: config)
            super.scaleTo(isEnlarge) {
                self.viewDownCompletionHandler()
            }
        }
    }

    override func scaleTo(_ isEnlarge: Bool) {
        super.scaleTo(isEnlarge)
        if toggle {
            viewUpCompletionHandler()
            let config = TMTitleOrImageButtonConfig(image: UIImage(systemName: "figure.table.tennis")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(scheduleGameViewUp), actionTarget: self)
            startGameBtn.setUp(with: config)
        } else {
            let config = TMTitleOrImageButtonConfig(image: UIImage(systemName: "clock")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(scheduleGameViewUp), actionTarget: self)
            startGameBtn.setUp(with: config)
        }
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        42
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        TMUser.user.allUnfinishedGames.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMUnfinishedGameCell()
        cell.selectionStyle = .none
        cell.showsReorderControl = true // 显示移动编辑样式
        cell.editingAccessoryType = .disclosureIndicator // 显示向右箭头的编辑样式
        cell.setupEvent(game: TMUser.user.allUnfinishedGames[indexPath.row])
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: Notification.Name(ToastNotification.ContinueGameToast.notificationName.rawValue), object: indexPath.row)
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !self.point(inside: point, with: nil), toggle == true {
            scaleTo(toggle, completionHandler: {})
        }
        return super.hitTest(point, with: event)
    }

    func refreshData() {
        if TMUser.user.allUnfinishedGames.count == 0 {
            setupAlart()
        } else {
            opponentLabel.isHidden = false
            dateLabel.isHidden = false
            lastResultLabel.isHidden = false
            scheduleList.isHidden = false
            alartView.isHidden = true
        }
        scheduleList.reloadData()
    }

    @objc func scheduleGameViewUp() {
        scaleTo(toggle, completionHandler: {})
    }
}
