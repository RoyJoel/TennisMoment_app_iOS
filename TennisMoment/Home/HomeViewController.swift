//
//  HomeViewController.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2022/12/26.
//

import CoreLocation
import Foundation
import SwiftyJSON
import TABAnimated
import TMComponent
import Toast_Swift
import UIKit

class HomeViewController: TMViewController, CLLocationManagerDelegate, UITableViewDelegate {
    var isRecordViewFullScreen = false

    /// 比赛记录视图
    lazy var recordView: TMRecordView = {
        var view = TMRecordView()
        view.setCorner(radii: 15)
        view.backgroundColor = UIColor(named: "ComponentBackground")
        return view
    }()

    lazy var configGameView: TMGameConfigView = {
        let view = TMGameConfigView()
        return view
    }()

    lazy var playerSearchingView: TMPlayerSearchingView = {
        let view = TMPlayerSearchingView()
        return view
    }()

    lazy var gameSearchingView: TMGameSearchingView = {
        let view = TMGameSearchingView()
        return view
    }()

    lazy var scheduleView: TMUserScheduleView = {
        let view = TMUserScheduleView()
        return view
    }()

    lazy var rankingView: TMRankingView = {
        let view = TMRankingView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(recordView)
        view.addSubview(rankingView)
        view.insertSubview(configGameView, aboveSubview: rankingView)
        view.addSubview(scheduleView)
        view.insertSubview(playerSearchingView, aboveSubview: rankingView)
        view.insertSubview(gameSearchingView, aboveSubview: rankingView)

        recordView.frame = CGRect(x: 24, y: 32, width: UIStandard.shared.screenWidth * 0.44, height: UIStandard.shared.screenHeight * 0.35)
        configGameView.frame = CGRect(x: 36 + UIStandard.shared.screenWidth * 0.44, y: 32, width: 68, height: 68)
        playerSearchingView.frame = CGRect(x: 36 + UIStandard.shared.screenWidth * 0.44, y: UIStandard.shared.screenHeight * 0.175 - 2, width: 68, height: 68)
        gameSearchingView.frame = CGRect(x: 36 + UIStandard.shared.screenWidth * 0.44, y: UIStandard.shared.screenHeight * 0.35 - 36, width: 68, height: 68)
        scheduleView.frame = CGRect(x: 24, y: 44 + UIStandard.shared.screenHeight * 0.35, width: 80 + UIStandard.shared.screenWidth * 0.44, height: UIStandard.shared.screenHeight * 0.65 - 142)
        rankingView.frame = CGRect(x: 116 + UIStandard.shared.screenWidth * 0.44, y: 32, width: UIStandard.shared.screenWidth * 0.56 - 72 - 68, height: UIStandard.shared.screenHeight - 130)

        recordView.setupUI()
        let tabAnimation = TABViewAnimated()
        tabAnimation.animatedColor = UIColor(named: "TennisBlur") ?? .gray
        recordView.tabAnimated = tabAnimation
        recordView.isUserInteractionEnabled = false
        if let game = UserDefaults.standard.object(forKey: TMUDKeys.liveMatch.rawValue) as? [String: Any] {
            recordView.refreshData(game: Game(dictionary: game) ?? Game())
            recordView.tab_endAnimationEaseOut()
            recordView.isUserInteractionEnabled = true
        } else {
            recordView.setupAlart()
            recordView.tab_endAnimationEaseOut()
        }

        configGameView.setupUI()
        configGameView.setupEvent(friends: TMUser.user.friends)
        recordView.addTapGesture(self, #selector(startRecord))
        configGameView.isHidden = false

        playerSearchingView.setupUI()
        playerSearchingView.isHidden = false

        gameSearchingView.setupUI()
        gameSearchingView.isHidden = false

        rankingView.setupUI()
        rankingView.isHidden = false

        NotificationCenter.default.addObserver(self, selector: #selector(startHistoryGame(_:)), name: Notification.Name(ToastNotification.ContinueGameToast.notificationName.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(toastUp(_:)), name: Notification.Name(ToastNotification.HomeViewToast.notificationName.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(startGame), name: Notification.Name(ToastNotification.AddGameToast.notificationName.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: Notification.Name(ToastNotification.DataFreshToast.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(saveData), name: Notification.Name(ToastNotification.DataSavingToast.rawValue), object: nil)

        recordView.setup(recordView.bounds, recordView.layer.position, CGRect(x: 0, y: 0, width: UIStandard.shared.screenWidth, height: UIStandard.shared.screenHeight), CGPoint(x: UIStandard.shared.screenWidth / 2, y: UIStandard.shared.screenHeight / 2), 0.3)

        configGameView.setup(configGameView.bounds, configGameView.layer.position, CGRect(x: 0, y: 0, width: UIStandard.shared.screenWidth * 0.5, height: UIStandard.shared.screenHeight * 0.35), CGPoint(x: 36 + UIStandard.shared.screenWidth * 0.69, y: 32 + UIStandard.shared.screenHeight * 0.175), 0.3)
        playerSearchingView.setup(playerSearchingView.bounds, playerSearchingView.layer.position, CGRect(x: 0, y: 0, width: UIStandard.shared.screenWidth * 0.5, height: UIStandard.shared.screenHeight * 0.35), CGPoint(x: 36 + UIStandard.shared.screenWidth * 0.69, y: 32 + UIStandard.shared.screenHeight * 0.175), 0.3)
        gameSearchingView.setup(gameSearchingView.bounds, gameSearchingView.layer.position, CGRect(x: 0, y: 0, width: UIStandard.shared.screenWidth * 0.5, height: UIStandard.shared.screenHeight * 0.35), CGPoint(x: 36 + UIStandard.shared.screenWidth * 0.69, y: 32 + UIStandard.shared.screenHeight * 0.175), 0.3)
        rankingView.setup(rankingView.bounds, rankingView.layer.position, CGRect(x: 0, y: 0, width: rankingView.bounds.size.width, height: UIStandard.shared.screenHeight * 0.65 - 142), CGPoint(x: rankingView.layer.position.x, y: UIStandard.shared.screenHeight * 0.675 - 27), 0.3)

        configGameView.viewUpCompletionHandler = {
            self.playerSearchingView.isHidden = true
            self.gameSearchingView.isHidden = true
            self.rankingView.scaleTo(self.rankingView.toggle)
        }
        configGameView.viewDownCompletionHandler = {
            self.playerSearchingView.isHidden = false
            self.gameSearchingView.isHidden = false
            self.rankingView.scaleTo(self.rankingView.toggle)
        }
        gameSearchingView.viewUpCompletionHandler = {
            self.playerSearchingView.isHidden = true
            self.configGameView.isHidden = true
            self.rankingView.scaleTo(self.rankingView.toggle)
        }
        gameSearchingView.viewDownCompletionHandler = {
            self.playerSearchingView.isHidden = false
            self.configGameView.isHidden = false
            self.rankingView.scaleTo(self.rankingView.toggle)
        }
        playerSearchingView.viewUpCompletionHandler = {
            self.gameSearchingView.isHidden = true
            self.configGameView.isHidden = true
            self.rankingView.scaleTo(self.rankingView.toggle)
        }
        playerSearchingView.viewDownCompletionHandler = {
            self.gameSearchingView.isHidden = false
            self.configGameView.isHidden = false
            self.rankingView.scaleTo(self.rankingView.toggle)
        }
        scheduleView.setupUI()
    }

    @objc func refreshData() {
        gameSearchingView.refreshData()
        configGameView.refreshData()
        scheduleView.refreshData()
        rankingView.refreshData()
    }

    @objc func saveData() {
        recordView.saveGame()
    }

    @objc private func startRecord() {
        navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(endRecord)), animated: true)
        navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "stop"), style: .plain, target: self, action: #selector(confirmCompleteGame)), animated: true)
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "ContentBackground")
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "ContentBackground")

        recordView.scaleTo(recordView.toggle, completionHandler: {})
        recordView.startRecord()
        configGameView.isHidden = true
        playerSearchingView.isHidden = true
        gameSearchingView.isHidden = true
        scheduleView.isHidden = true
        rankingView.isHidden = true
    }

    @objc private func endRecord() {
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = nil

        recordView.saveGame()
        recordView.scaleTo(recordView.toggle, completionHandler: {
            self.configGameView.isHidden = false
            self.gameSearchingView.isHidden = false
            self.playerSearchingView.isHidden = false
            self.scheduleView.isHidden = false
            self.rankingView.isHidden = false
        })
    }

    @objc private func confirmCompleteGame() {
        let sheetCtrl = UIAlertController(title: "End Match", message: nil, preferredStyle: .alert)

        let action = UIAlertAction(title: "Ok", style: .default) { _ in
            self.completeGame()
        }
        sheetCtrl.addAction(action)

        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in
            sheetCtrl.dismiss(animated: true)
        }
        sheetCtrl.addAction(cancelAction)

        sheetCtrl.popoverPresentationController?.sourceView = view
        sheetCtrl.popoverPresentationController?.sourceRect = CGRect(x: view.bounds.width / 2 - 144, y: view.bounds.height / 2 - 69, width: 288, height: 138)
        present(sheetCtrl, animated: true, completion: nil)
    }

    @objc private func completeGame() {
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = nil

        recordView.endGame()
        configGameView.isHidden = false
        gameSearchingView.isHidden = false
        playerSearchingView.isHidden = false
        scheduleView.isHidden = false
        rankingView.isHidden = false
        UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: TMUDKeys.lastGameTime.rawValue)
    }

    @objc func toastUp(_ obj: Notification) {
        recordView.isUserInteractionEnabled = false
        let winner = obj.object as? String ?? ""
        let toastView = TMWinnerToastView()
        toastView.setupUI(winner)
        view.showToast(toastView, position: .center) { _ in
            self.completeGame()
            let vc = TMGameStatsDetailViewController()
            vc.game = self.recordView.game
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    @objc func startGame() {
        guard TMUser.user.friends.count > 0 else {
            let toastView = UILabel()
            toastView.text = NSLocalizedString("The Game Should Not start without player", comment: "")
            toastView.bounds = configGameView.bounds
            toastView.backgroundColor = UIColor(named: "ComponentBackground")
            toastView.textAlignment = .center
            toastView.setCorner(radii: 15)
            configGameView.showToast(toastView, duration: 1, position: .center) { _ in
            }
            return
        }
        let gameConfig = configGameView.getData()
        guard gameConfig.player1.id != gameConfig.player2.id else {
            let toastView = UILabel()
            toastView.text = NSLocalizedString("Player1 and player2 should not be same", comment: "")
            toastView.bounds = configGameView.bounds
            toastView.backgroundColor = UIColor(named: "ComponentBackground")
            toastView.textAlignment = .center
            toastView.setCorner(radii: 15)
            configGameView.showToast(toastView, duration: 1, position: .center) { _ in
            }
            return
        }
        configGameView.scaleTo(configGameView.toggle)
        rankingView.scaleTo(rankingView.toggle)
        var newGame = GameRequest(id: 0, place: "", surface: gameConfig.surfaceType, setNum: gameConfig.setNum, gameNum: gameConfig.gameNum, round: 0, isGoldenGoal: gameConfig.isGoldenGoal, isPlayer1Serving: gameConfig.isPlayer1Serving, isPlayer1Left: true, isChangePosition: false, startDate: Date().timeIntervalSince1970, endDate: nil, player1Id: gameConfig.player1.id, player1StatsId: 0, player2Id: gameConfig.player2.id, player2StatsId: 0, isPlayer1FirstServe: true, isPlayer2FirstServe: true, result: [[[0, 0]]])
        TMUser.getLocationdescription(completionHandler: { location in
            newGame.place = location
            let game = Game(id: 0, place: location, surface: gameConfig.surfaceType, setNum: gameConfig.setNum, gameNum: gameConfig.gameNum, round: 0, isGoldenGoal: gameConfig.isGoldenGoal, isPlayer1Serving: gameConfig.isPlayer1Serving, isPlayer1Left: true, isChangePosition: false, startDate: Date().timeIntervalSince1970, endDate: 0, player1: gameConfig.player1, player1Stats: Stats(), player2: gameConfig.player2, player2Stats: Stats(), isPlayer1FirstServe: true, isPlayer2FirstServe: true, result: [[[0, 0]]])
            self.recordView.setNewGame(game: game)
            self.navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(self.endRecord)), animated: true)
            self.navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "stop"), style: .plain, target: self, action: #selector(self.confirmCompleteGame)), animated: true)
            self.navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "ContentBackground")
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "ContentBackground")

            self.recordView.scaleTo(self.recordView.toggle, completionHandler: {})
            self.configGameView.isHidden = true
            self.gameSearchingView.isHidden = true
            self.playerSearchingView.isHidden = true
            self.scheduleView.isHidden = true
            self.rankingView.isHidden = true
        })
    }

    @objc func startHistoryGame(_ obj: Notification) {
        let selectedIndex = obj.object as? Int ?? 0
        let game = TMUser.user.allUnfinishedGames[selectedIndex]
        gameSearchingView.scaleTo(gameSearchingView.toggle)

        navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(endRecord)), animated: true)
        navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "stop"), style: .plain, target: self, action: #selector(confirmCompleteGame)), animated: true)
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "ContentBackground")
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "ContentBackground")

        recordView.scaleTo(recordView.toggle, completionHandler: {})
        configGameView.isHidden = true
        playerSearchingView.isHidden = true
        gameSearchingView.isHidden = true
        scheduleView.isHidden = true
        rankingView.isHidden = true
        rankingView.scaleTo(rankingView.toggle)
        recordView.refreshData(game: game)
        recordView.startRecord()
    }
}
