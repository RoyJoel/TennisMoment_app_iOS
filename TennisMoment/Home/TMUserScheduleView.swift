//
//  TMUserScheduleView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/28.
//

import Foundation
import TMComponent
import UIKit

class TMUserScheduleView: UIView, UITableViewDelegate, UITableViewDataSource {
    var modifiRow: Int = -1
    var modifiSchedule: Schedule = Schedule()
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

    lazy var scheduleList: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    lazy var scheduleConfigView: TMScheduleBookingView = {
        let configView = TMScheduleBookingView()
        return configView
    }()

    lazy var addScheduleButton: TMTitleOrImageButton = {
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
        addSubview(placeLabel)
        addSubview(alartView)
        insertSubview(scheduleList, belowSubview: opponentLabel)
        insertSubview(scheduleConfigView, aboveSubview: scheduleList)

        addSubview(addScheduleButton)

        opponentLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.width.equalTo(146)
            make.height.equalTo(50)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(opponentLabel.snp.right)
            make.width.equalTo(158)
            make.height.equalTo(50)
        }
        placeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(dateLabel.snp.right)
            make.right.equalTo(addScheduleButton.snp.left).offset(-12)
            make.height.equalTo(50)
        }
        scheduleList.snp.makeConstraints { make in
            make.top.equalTo(opponentLabel.snp.bottom)
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        alartView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(40)
        }

        addScheduleButton.frame = CGRect(x: bounds.width - 50, y: 0, width: 50, height: 50)
        scheduleConfigView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 50)
        scheduleConfigView.setupUI()
        scheduleConfigView.setupEvent(date: Date().timeIntervalSince1970, place: "")

        scheduleConfigView.setup(scheduleConfigView.bounds, scheduleConfigView.layer.position, CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height - 50), CGPoint(x: bounds.width / 2, y: bounds.height / 2 + 25), 0.3)

        let addScheduleButtonConfig = TMTitleOrImageButtonConfig(image: UIImage(systemName: "plus")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(scheduleGameViewUp), actionTarget: self)
        addScheduleButton.setUp(with: addScheduleButtonConfig)

        opponentLabel.text = NSLocalizedString("Opponent", comment: "")
        dateLabel.text = NSLocalizedString("Date", comment: "")
        placeLabel.text = NSLocalizedString("Place", comment: "")
        opponentLabel.font = UIFont.systemFont(ofSize: 21)
        dateLabel.font = UIFont.systemFont(ofSize: 21)
        placeLabel.font = UIFont.systemFont(ofSize: 21)
        scheduleList.delegate = self
        scheduleList.dataSource = self
        scheduleList.register(TMScheduleCell.self, forCellReuseIdentifier: "TMScheduleCell.self")
        scheduleList.separatorStyle = .none
        scheduleList.showsVerticalScrollIndicator = false
        scheduleList.showsHorizontalScrollIndicator = false
        scheduleList.allowsSelectionDuringEditing = true
        scheduleList.backgroundColor = UIColor(named: "ComponentBackground")

        if TMUser.user.allSchedules.count == 0 {
            setupAlart()
        } else {
            opponentLabel.isHidden = false
            dateLabel.isHidden = false
            placeLabel.isHidden = false
            scheduleList.isHidden = false
            alartView.isHidden = true
        }
    }

    func setupAlart() {
        opponentLabel.isHidden = true
        dateLabel.isHidden = true
        placeLabel.isHidden = true
        scheduleList.isHidden = true
        alartView.isHidden = false

        alartView.text = NSLocalizedString("You don't have any schedule", comment: "")
        alartView.font = UIFont.systemFont(ofSize: 22)
        alartView.textAlignment = .center
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        42
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        TMUser.user.allSchedules.count
    }

    func tableView(_: UITableView, canEditRowAt _: IndexPath) -> Bool {
        true
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt _: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let modifyAction = UIContextualAction(style: .destructive, title: NSLocalizedString("Modify", comment: "")) { _, _, completion in
            self.modifiRow = indexPath.row
            self.modifiSchedule = TMUser.user.allSchedules[indexPath.row]
            self.scheduleConfigView.setupEvent(date: TMUser.user.allSchedules[indexPath.row].startDate, place: TMUser.user.allSchedules[indexPath.row].place)
            self.scheduleConfigView.scaleTo(self.scheduleConfigView.toggle)
            let addScheduleButtonConfig = TMTitleOrImageButtonConfig(image: UIImage(systemName: "paperplane")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(self.modifySchedule), actionTarget: self)
            self.addScheduleButton.setUp(with: addScheduleButtonConfig)
            completion(true)
        }
        modifyAction.backgroundColor = UIColor(named: "Tennis")

        let deleteAction = UIContextualAction(style: .destructive, title: NSLocalizedString("Delete", comment: "")) { _, _, _ in
            TMUser.user.allSchedules.remove(at: indexPath.row)
            self.refreshData()
            let addScheduleButtonConfig = TMTitleOrImageButtonConfig(image: UIImage(systemName: "plus")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(self.scheduleGameViewUp), actionTarget: self)
            self.addScheduleButton.setUp(with: addScheduleButtonConfig)
        }
        deleteAction.backgroundColor = .red // Set the background color of the delete button to red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, modifyAction])
        return configuration
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMScheduleCell()
        cell.selectionStyle = .none
        cell.showsReorderControl = true // 显示移动编辑样式
        cell.editingAccessoryType = .disclosureIndicator // 显示向右箭头的编辑样式
        cell.setupEvent(schedule: TMUser.user.allSchedules[indexPath.row])
        return cell
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !CGRectContainsPoint(scheduleList.frame, point), !CGRectContainsPoint(addScheduleButton.frame, point) {
            if scheduleConfigView.toggle == true {
                scheduleConfigView.scaleTo(scheduleConfigView.toggle)
                if scheduleConfigView.toggle == false {
                    let addScheduleButtonConfig = TMTitleOrImageButtonConfig(image: UIImage(systemName: "plus")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(scheduleGameViewUp), actionTarget: self)
                    addScheduleButton.setUp(with: addScheduleButtonConfig)
                }
            }
        }
        return super.hitTest(point, with: event)
    }

    func refreshData() {
        scheduleList.reloadData()
        scheduleConfigView.refreshData()
        if TMUser.user.allSchedules.count == 0 {
            setupAlart()
        } else {
            opponentLabel.isHidden = false
            dateLabel.isHidden = false
            placeLabel.isHidden = false
            scheduleList.isHidden = false
            alartView.isHidden = true
        }
    }

    @objc func scheduleGameViewUp() {
        scheduleConfigView.scaleTo(scheduleConfigView.toggle)
        let addScheduleButtonConfig = TMTitleOrImageButtonConfig(image: UIImage(systemName: "paperplane")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(addSchedule), actionTarget: self)
        addScheduleButton.setUp(with: addScheduleButtonConfig)
    }

    @objc func addSchedule() {
        if let place = scheduleConfigView.placeSearchBar.text, place != "" {
            if scheduleConfigView.players[0].id != TMUser.user.id {
                scheduleConfigView.scaleTo(scheduleConfigView.toggle)
                let newSchedule = Schedule(id: 0, startDate: scheduleConfigView.datePicker.date.timeIntervalSince1970, place: place, opponent: scheduleConfigView.players[0])
                TMUser.user.allSchedules.append(newSchedule)
                refreshData()
                let addScheduleButtonConfig = TMTitleOrImageButtonConfig(image: UIImage(systemName: "plus")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(scheduleGameViewUp), actionTarget: self)
                addScheduleButton.setUp(with: addScheduleButtonConfig)
                DispatchQueue.main.async {
                    TMUser.addSchedule(id: newSchedule.id, startDate: newSchedule.startDate, place: newSchedule.place, OpponentId: newSchedule.opponent.id, completionHandler: { _ in })
                }
            } else {
                let toastView = UILabel()
                toastView.text = NSLocalizedString("The opponent can not be yourself", comment: "")
                toastView.bounds = bounds
                toastView.backgroundColor = UIColor(named: "ComponentBackground")
                toastView.textAlignment = .center
                toastView.setCorner(radii: 15)
                showToast(toastView, duration: 1, position: .center) { _ in
                }
            }
        } else {
            let toastView = UILabel()
            toastView.text = NSLocalizedString("The Place Should Not Be Null", comment: "")
            toastView.bounds = bounds
            toastView.backgroundColor = UIColor(named: "ComponentBackground")
            toastView.textAlignment = .center
            toastView.setCorner(radii: 15)
            showToast(toastView, duration: 1, position: .center) { _ in
            }
        }
    }

    @objc func modifySchedule() {
        if let place = scheduleConfigView.placeSearchBar.text, place != "" {
            if scheduleConfigView.players[0].id != TMUser.user.id {
                scheduleConfigView.scaleTo(scheduleConfigView.toggle)
                let newSchedule = Schedule(id: modifiSchedule.id, startDate: scheduleConfigView.datePicker.date.timeIntervalSince1970, place: place, opponent: scheduleConfigView.players[0])
                TMUser.user.allSchedules[modifiRow] = newSchedule
                refreshData()
                let addScheduleButtonConfig = TMTitleOrImageButtonConfig(image: UIImage(systemName: "plus")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(scheduleGameViewUp), actionTarget: self)
                addScheduleButton.setUp(with: addScheduleButtonConfig)
                DispatchQueue.main.async {
                    TMUser.addSchedule(id: newSchedule.id, startDate: newSchedule.startDate, place: newSchedule.place, OpponentId: newSchedule.opponent.id, completionHandler: { _ in })
                }
            } else {
                let toastView = UILabel()
                toastView.text = NSLocalizedString("The opponent can not be yourself", comment: "")
                toastView.bounds = bounds
                toastView.backgroundColor = UIColor(named: "ComponentBackground")
                toastView.textAlignment = .center
                toastView.setCorner(radii: 15)
                showToast(toastView, duration: 1, position: .center) { _ in
                }
            }
        } else {
            let toastView = UILabel()
            toastView.text = NSLocalizedString("The Place Should Not Be Null", comment: "")
            toastView.bounds = bounds
            toastView.backgroundColor = UIColor(named: "ComponentBackground")
            toastView.textAlignment = .center
            toastView.setCorner(radii: 15)
            showToast(toastView, duration: 1, position: .center) { _ in
            }
        }
    }
}
