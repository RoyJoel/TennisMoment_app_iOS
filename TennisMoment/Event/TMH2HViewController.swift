//
//  TMH2HViewController.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/4/9.
//

import Foundation
import TMComponent
import UIKit

class TMH2HViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var player1: Player = Player()
    var player2: Player = Player()
    var h2hGames: [Game] = []

    lazy var player1IconView: TMIconView = {
        let view = TMIconView()
        return view
    }()

    lazy var player2IconView: TMIconView = {
        let view = TMIconView()
        return view
    }()

    lazy var infoComparingView: TMmultiplyConfigurableView = {
        let view = TMmultiplyConfigurableView()
        return view
    }()

    lazy var H2HRecordView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    lazy var alartView: UILabel = {
        let label = UILabel()
        return label
    }()

    override func viewDidLoad() {
        view.backgroundColor = UIColor(named: "BackgroundGray")
        view.addSubview(player1IconView)
        view.addSubview(player2IconView)
        view.addSubview(infoComparingView)
        view.addSubview(H2HRecordView)
        view.addSubview(alartView)

        player2IconView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.width.equalTo(128)
            make.height.equalTo(188)
        }
        player1IconView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(12)
            make.width.equalTo(128)
            make.height.equalTo(188)
        }
        H2HRecordView.snp.makeConstraints { make in
            make.top.equalTo(infoComparingView.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-12)
        }
        infoComparingView.snp.makeConstraints { make in
            make.top.equalTo(player1IconView.snp.top)
            make.centerX.equalToSuperview()
            make.width.equalTo(428)
            make.height.equalTo(250)
        }
        alartView.snp.makeConstraints { make in
            make.edges.equalTo(H2HRecordView.snp.edges)
        }
        let player1Config = TMIconViewConfig(icon: player1.icon.toPng(), name: player1.name)
        let player2Config = TMIconViewConfig(icon: player2.icon.toPng(), name: player2.name)
        player1IconView.setup(with: player1Config)
        player2IconView.setup(with: player2Config)

        let ypConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: "YearsPlayed", isServingOnLeft: false, areBothServing: false, isComparing: false, font: UIFont.systemFont(ofSize: 17), leftNum: "\(player1.yearsPlayed)", rightNum: "\(player2.yearsPlayed)")
        let heightConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: "Height", isServingOnLeft: false, areBothServing: false, isComparing: false, font: UIFont.systemFont(ofSize: 17), leftNum: "\(player1.height)", rightNum: "\(player2.height)")
        let widghtConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: "Widght", isServingOnLeft: false, areBothServing: false, isComparing: false, font: UIFont.systemFont(ofSize: 17), leftNum: "\(player1.width)", rightNum: "\(player2.width)")
        let gripConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: "Grip", isServingOnLeft: false, areBothServing: false, isComparing: false, font: UIFont.systemFont(ofSize: 17), leftNum: "\(player1.grip)", rightNum: "\(player2.grip)")
        let backhandConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: "Backhand", isServingOnLeft: false, areBothServing: false, isComparing: false, font: UIFont.systemFont(ofSize: 17), leftNum: "\(player1.backhand.rawValue)", rightNum: "\(player2.backhand.rawValue)")

        let infoConfig = TMmultiplyConfigurableViewConfig(rowHeight: 50, rowSpacing: 0, configs: [ypConfig, heightConfig, widghtConfig, gripConfig, backhandConfig])
        infoComparingView.setup(with: infoConfig)
        infoComparingView.backgroundColor = UIColor(named: "ComponentBackground")
        infoComparingView.setCorner(radii: 15)

        if h2hGames.count == 0 {
            H2HRecordView.isHidden = true
            alartView.isHidden = false

            alartView.text = NSLocalizedString("No Game Record", comment: "")
            alartView.font = UIFont.systemFont(ofSize: 22)
            alartView.textAlignment = .center
        } else {
            alartView.isHidden = true
            H2HRecordView.isHidden = false
            H2HRecordView.register(TMH2HRecordCell.self, forCellReuseIdentifier: "TMRecordCell")
            H2HRecordView.delegate = self
            H2HRecordView.dataSource = self
            H2HRecordView.separatorStyle = .none
            H2HRecordView.showsVerticalScrollIndicator = false
            H2HRecordView.showsHorizontalScrollIndicator = false
            H2HRecordView.allowsSelectionDuringEditing = true
            H2HRecordView.setCorner(radii: 15)
        }
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        50
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        h2hGames.count + 1
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = TMH2HContentLabelCell()
            return cell
        } else {
            let cell = TMH2HRecordCell()
            cell.setupEvent(game: h2hGames[indexPath.row - 1])
            return cell
        }
    }
}
