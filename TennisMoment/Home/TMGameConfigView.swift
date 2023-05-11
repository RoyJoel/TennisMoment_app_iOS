//
//  GameConfigToast.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/2.
//

import Foundation
import TMComponent
import UIKit

class TMGameConfigView: TMScalableView {
    let player1Selections = Player1SelectViewDataSource()
    let player2Selections = Player1SelectViewDataSource()
    let setNumSelections = setNumSelectViewDataSource()
    let gameNumSelections = gameNumSelectViewDataSource()
    let surfaceTypeSelections = surfaceTypeConfigViewDataSource()
    var viewUpCompletionHandler: () -> Void = {}
    var viewDownCompletionHandler: () -> Void = {}

    lazy var startGameBtn: TMTitleOrImageButton = {
        let btn = TMTitleOrImageButton()
        return btn
    }()

    lazy var Player1SelectView: TMPopUpView = {
        let textField = TMPopUpView()
        return textField
    }()

    lazy var Player2SelectView: TMPopUpView = {
        let textField = TMPopUpView()
        return textField
    }()

    lazy var serverView: TMDoubleSelectionView = {
        let view = TMDoubleSelectionView()
        return view
    }()

    lazy var isGoldenGoalLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var isGoldenGoalConfigView: UISwitch = {
        let textField = UISwitch()
        return textField
    }()

    lazy var setConfigView: TMPopUpView = {
        let textField = TMPopUpView()
        return textField
    }()

    lazy var gameConfigView: TMPopUpView = {
        let textField = TMPopUpView()
        return textField
    }()

    lazy var surfaceConfigView: TMPopUpView = {
        let textField = TMPopUpView()
        return textField
    }()

    lazy var setConfigLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var gameConfigLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var surfaceConfigLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    func setupUI() {
        backgroundColor = UIColor(named: "ComponentBackground")
        setCorner(radii: 15)
        clipsToBounds = false

        addSubview(startGameBtn)
        addSubview(Player1SelectView)
        addSubview(Player2SelectView)
        addSubview(serverView)
        addSubview(isGoldenGoalLabel)
        addSubview(isGoldenGoalConfigView)
        addSubview(setConfigView)
        addSubview(gameConfigView)
        addSubview(surfaceConfigView)
        addSubview(setConfigLabel)
        addSubview(gameConfigLabel)
        addSubview(surfaceConfigLabel)

        startGameBtn.frame = CGRect(x: 0, y: 0, width: 68, height: 68)
        Player1SelectView.frame = CGRect(x: 120, y: 12, width: UIStandard.shared.screenWidth * 0.15, height: 44)
        Player2SelectView.frame = CGRect(x: 380, y: 12, width: UIStandard.shared.screenWidth * 0.15, height: 44)

        serverView.frame = CGRect(x: 120, y: 70, width: 260 + UIStandard.shared.screenWidth * 0.15, height: 80)

        isGoldenGoalLabel.frame = CGRect(x: 52 + UIStandard.shared.screenWidth * 0.3, y: 108 + UIStandard.shared.screenHeight * 0.08, width: UIStandard.shared.screenWidth * 0.10, height: 30)

        isGoldenGoalConfigView.frame = CGRect(x: 52 + UIStandard.shared.screenWidth * 0.32, y: 150 + UIStandard.shared.screenHeight * 0.08, width: UIStandard.shared.screenWidth * 0.6, height: 30)

        setConfigView.frame = CGRect(x: 16, y: 108 + UIStandard.shared.screenHeight * 0.08, width: UIStandard.shared.screenWidth * 0.10, height: 30)
        setConfigLabel.frame = CGRect(x: 16, y: 150 + UIStandard.shared.screenHeight * 0.08, width: UIStandard.shared.screenWidth * 0.10, height: 30)
        gameConfigView.frame = CGRect(x: 28 + UIStandard.shared.screenWidth * 0.10, y: 108 + UIStandard.shared.screenHeight * 0.08, width: UIStandard.shared.screenWidth * 0.10, height: 30)
        gameConfigLabel.frame = CGRect(x: 28 + UIStandard.shared.screenWidth * 0.10, y: 150 + UIStandard.shared.screenHeight * 0.08, width: UIStandard.shared.screenWidth * 0.10, height: 30)
        surfaceConfigView.frame = CGRect(x: 40 + UIStandard.shared.screenWidth * 0.2, y: 108 + UIStandard.shared.screenHeight * 0.08, width: UIStandard.shared.screenWidth * 0.10, height: 30)
        surfaceConfigLabel.frame = CGRect(x: 40 + UIStandard.shared.screenWidth * 0.2, y: 150 + UIStandard.shared.screenHeight * 0.08, width: UIStandard.shared.screenWidth * 0.10, height: 30)

        Player1SelectView.isHidden = true
        Player2SelectView.isHidden = true
        serverView.isHidden = true
        isGoldenGoalLabel.isHidden = true
        isGoldenGoalConfigView.isHidden = true
        setConfigView.isHidden = true
        setConfigLabel.isHidden = true
        gameConfigView.isHidden = true
        gameConfigLabel.isHidden = true
        surfaceConfigView.isHidden = true
        surfaceConfigLabel.isHidden = true

        bringSubviewToFront(setConfigView)
        bringSubviewToFront(gameConfigView)
        bringSubviewToFront(surfaceConfigView)
        bringSubviewToFront(Player1SelectView)
        bringSubviewToFront(Player2SelectView)

        let startGameBtnConfig = TMTitleOrImageButtonConfig(image: UIImage(systemName: "plus")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(configGameViewUp), actionTarget: self)
        startGameBtn.setUp(with: startGameBtnConfig)

        Player1SelectView.delegate = Player1SelectView
        Player2SelectView.delegate = Player2SelectView
        setConfigView.delegate = setConfigView
        gameConfigView.delegate = gameConfigView
        surfaceConfigView.delegate = surfaceConfigView
        serverView.setupUI()
        serverView.setupEvent(config: TMServeViewConfig(selectedImage: "tennisball.fill", unSelectedImage: "tennisball", selectedTitle: "To Serve", unselectedTitle: "To Return"))
        isGoldenGoalLabel.text = NSLocalizedString("GoldenGoal", comment: "")
        isGoldenGoalLabel.textAlignment = .center
        setConfigLabel.text = NSLocalizedString("Sets (Best Of)", comment: "")
        gameConfigLabel.text = NSLocalizedString("Games", comment: "")
        surfaceConfigLabel.text = NSLocalizedString("Surface Type", comment: "")
        setConfigLabel.textAlignment = .center
        gameConfigLabel.textAlignment = .center
        surfaceConfigLabel.textAlignment = .center
    }

    func setupEvent(friends _: [Player]) {
        Player1SelectView.dataSource = player1Selections
        Player2SelectView.dataSource = player2Selections
        setConfigView.dataSource = setNumSelections
        gameConfigView.dataSource = gameNumSelections
        surfaceConfigView.dataSource = surfaceTypeSelections
        Player1SelectView.setupUI()
        Player2SelectView.setupUI()
        setConfigView.setupUI()
        gameConfigView.setupUI()
        surfaceConfigView.setupUI()
        Player1SelectView.selectedCompletionHandler = { indexPath in
            if self.player1Selections.players.count == 0 {} else {
                let selectedPlayer = self.player1Selections.players.remove(at: indexPath)
                self.player1Selections.players.insert(selectedPlayer, at: 0)
                self.Player1SelectView.reloadData()
            }
        }
        Player2SelectView.selectedCompletionHandler = { indexPath in
            if self.player2Selections.players.count == 0 {} else {
                let selectedPlayer = self.player2Selections.players.remove(at: indexPath)
                self.player2Selections.players.insert(selectedPlayer, at: 0)
                self.Player2SelectView.reloadData()
            }
        }
        setConfigView.selectedCompletionHandler = { indexPath in
            let selectedPlayer = self.setNumSelections.numConfig.remove(at: indexPath)
            self.setNumSelections.numConfig.insert(selectedPlayer, at: 0)
            self.setConfigView.reloadData()
        }
        gameConfigView.selectedCompletionHandler = { indexPath in
            let selectedPlayer = self.gameNumSelections.numConfig.remove(at: indexPath)
            self.gameNumSelections.numConfig.insert(selectedPlayer, at: 0)
            self.gameConfigView.reloadData()
        }
        surfaceConfigView.selectedCompletionHandler = { indexPath in
            let selectedPlayer = self.surfaceTypeSelections.surfaceConfig.remove(at: indexPath)
            self.surfaceTypeSelections.surfaceConfig.insert(selectedPlayer, at: 0)
            self.surfaceConfigView.reloadData()
        }
    }

    override func scaleTo(_ isEnlarge: Bool, completionHandler _: @escaping () -> Void) {
        if !toggle {
            viewUpCompletionHandler()
            let config = TMTitleOrImageButtonConfig(image: UIImage(systemName: "figure.table.tennis")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(startGame), actionTarget: self)
            startGameBtn.setUp(with: config)
            super.scaleTo(isEnlarge) {
                self.Player1SelectView.isHidden = false
                self.Player2SelectView.isHidden = false
                self.serverView.isHidden = false
                self.isGoldenGoalLabel.isHidden = false
                self.isGoldenGoalConfigView.isHidden = false
                self.setConfigView.isHidden = false
                self.setConfigLabel.isHidden = false
                self.gameConfigView.isHidden = false
                self.gameConfigLabel.isHidden = false
                self.surfaceConfigView.isHidden = false
                self.surfaceConfigLabel.isHidden = false
            }
        } else {
            Player1SelectView.isHidden = true
            Player2SelectView.isHidden = true
            serverView.isHidden = true
            isGoldenGoalLabel.isHidden = true
            isGoldenGoalConfigView.isHidden = true
            setConfigView.isHidden = true
            setConfigLabel.isHidden = true
            gameConfigView.isHidden = true
            gameConfigLabel.isHidden = true
            surfaceConfigView.isHidden = true
            surfaceConfigLabel.isHidden = true
            let config = TMTitleOrImageButtonConfig(image: UIImage(systemName: "plus")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(configGameViewUp), actionTarget: self)
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
            let config = TMTitleOrImageButtonConfig(image: UIImage(systemName: "figure.table.tennis")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(startGame), actionTarget: self)
            startGameBtn.setUp(with: config)
        } else {
            Player1SelectView.isHidden = true
            Player2SelectView.isHidden = true
            serverView.isHidden = true
            isGoldenGoalLabel.isHidden = true
            isGoldenGoalConfigView.isHidden = true
            setConfigView.isHidden = true
            setConfigLabel.isHidden = true
            gameConfigView.isHidden = true
            gameConfigLabel.isHidden = true
            surfaceConfigView.isHidden = true
            surfaceConfigLabel.isHidden = true
            let config = TMTitleOrImageButtonConfig(image: UIImage(systemName: "plus")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(configGameViewUp), actionTarget: self)
            startGameBtn.setUp(with: config)
        }
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !self.point(inside: point, with: nil), toggle == true {
            scaleTo(toggle, completionHandler: {})
        }
        return super.hitTest(point, with: event)
    }

    /// 返回用户填写的比赛数据
    /// - Returns: 0：player1LoginName，1: player2LoginName，2：setNum，3: gameNum， 4: isGoldenGoal
    func getData() -> (player1: Player, player2: Player, surfaceType: SurfaceType, setNum: Int, gameNum: Int, isGoldenGoal: Bool, isPlayer1Serving: Bool) {
        let player1 = player1Selections.players[0]
        let player2 = player2Selections.players[0]
        let setConfig = setNumSelections.numConfig[0]
        let gameConfig = gameNumSelections.numConfig[0]
        let surfaceConfig = surfaceTypeSelections.surfaceConfig[0].rawValue
        return (player1, player2, SurfaceType(rawValue: surfaceConfig) ?? .hard, setConfig, gameConfig, isGoldenGoalConfigView.isOn, serverView.isPlayer1Serving)
    }

    @objc func configGameViewUp() {
        scaleTo(toggle, completionHandler: {})
    }

    @objc func startGame() {
        NotificationCenter.default.post(name: Notification.Name(ToastNotification.AddGameToast.notificationName.rawValue), object: nil)
    }

    func refreshData() {
        Player1SelectView.reloadData()
        Player1SelectView.setupSize()
        Player2SelectView.reloadData()
        Player2SelectView.setupSize()
    }
}

class Player1SelectViewDataSource: NSObject, UITableViewDataSource {
    var players: [Player] = TMUser.user.friends

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        players = TMDataConvert.union(TMUser.user.friends, to: players)
        return players.count == 0 ? 1 : players.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if players.count == 0 {
            let cell = TMPopUpCell()
            cell.setupUI()
            cell.setupEvent(title: "Find a friend To Play With")
            return cell
        } else {
            let cell = TMplayerSelectionCell()
            cell.setupEvent(imageName: players[indexPath.row].icon.toPng(), playerName: players[indexPath.row].name, playerId: players[indexPath.row].id)
            return cell
        }
    }

    func tableView(_: UITableView, canMoveRowAt _: IndexPath) -> Bool {
        true
    }
}

class Player2SelectViewDataSource: NSObject, UITableViewDataSource {
    var players: [Player] = TMUser.user.friends

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        players = TMDataConvert.union(TMUser.user.friends, to: players)
        return players.count == 0 ? 1 : players.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if players.count == 0 {
            let cell = TMPopUpCell()
            cell.setupUI()
            cell.setupEvent(title: "Find a friend To Play With")
            return cell
        } else {
            let cell = TMplayerSelectionCell()
            cell.setupEvent(imageName: players[indexPath.row].icon.toPng(), playerName: players[indexPath.row].name, playerId: players[indexPath.row].id)
            return cell
        }
    }
}

class setNumSelectViewDataSource: NSObject, UITableViewDataSource {
    var numConfig: [Int] = [1, 2, 3]
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        numConfig.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMPopUpCell()
        cell.setupUI()
        cell.setupEvent(title: "\(numConfig[indexPath.row])")
        return cell
    }
}

class gameNumSelectViewDataSource: NSObject, UITableViewDataSource {
    var numConfig: [Int] = [4, 6]
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        numConfig.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMPopUpCell()
        cell.setupUI()
        cell.setupEvent(title: "\(numConfig[indexPath.row])")
        return cell
    }
}

class surfaceTypeConfigViewDataSource: NSObject, UITableViewDataSource {
    var surfaceConfig: [SurfaceType] = [.hard, .clay, .grass]

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        surfaceConfig.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMPopUpCell()
        cell.setupUI()
        cell.setupEvent(title: NSLocalizedString(surfaceConfig[indexPath.row].rawValue, comment: ""))
        return cell
    }
}
