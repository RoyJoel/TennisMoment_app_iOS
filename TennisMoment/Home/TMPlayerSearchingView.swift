//
//  TMPlayerSearchingView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/4/10.
//

import Foundation
import TMComponent
import UIKit

class TMPlayerSearchingView: TMView, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    var players: [Player] = []
    var viewUpCompletionHandler: () -> Void = {}
    var viewDownCompletionHandler: () -> Void = {}

    lazy var PlayerSelectView: UITableView = {
        let textField = UITableView()
        return textField
    }()

    lazy var startGameBtn: TMTitleOrImageButton = {
        let btn = TMTitleOrImageButton()
        return btn
    }()

    lazy var playerSearchBar: UISearchBar = {
        let button = UISearchBar()
        return button
    }()

    func setupUI() {
        backgroundColor = UIColor(named: "ComponentBackground")
        setCorner(radii: 15)
        clipsToBounds = false
        addSubview(PlayerSelectView)
        addSubview(startGameBtn)
        addSubview(playerSearchBar)

        startGameBtn.frame = CGRect(x: 0, y: 0, width: 68, height: 68)
        playerSearchBar.snp.makeConstraints { make in
            make.left.equalTo(startGameBtn.snp.right).offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.equalToSuperview().offset(12)
            make.height.equalTo(50)
        }
        PlayerSelectView.frame = CGRect(x: 80, y: 74, width: UIStandard.shared.screenWidth * 0.5 - 92, height: 44)

        playerSearchBar.isHidden = true
        PlayerSelectView.isHidden = true

        let startGameBtnConfig = TMTitleOrImageButtonConfig(image: UIImage(systemName: "magnifyingglass")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(gameSearchingViewUp), actionTarget: self)
        startGameBtn.setUp(with: startGameBtnConfig)

        playerSearchBar.placeholder = NSLocalizedString("Search Player By LoginName", comment: "")
        playerSearchBar.searchBarStyle = .minimal
        playerSearchBar.delegate = self
        PlayerSelectView.delegate = self
        PlayerSelectView.dataSource = self
        PlayerSelectView.register(TMplayerSelectionCell.self, forCellReuseIdentifier: "playerCell")
        PlayerSelectView.register(TMPopUpCell.self, forCellReuseIdentifier: "noPlayerCell")
        bringSubviewToFront(PlayerSelectView)
    }

    override func scaleTo(_ isEnlarge: Bool, completionHandler _: @escaping () -> Void) {
        if !toggle {
            viewUpCompletionHandler()
            let config = TMTitleOrImageButtonConfig(image: UIImage(systemName: "magnifyingglass")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(startGame), actionTarget: self)
            startGameBtn.setUp(with: config)
            super.scaleTo(isEnlarge) {
                self.playerSearchBar.isHidden = false
            }
        } else {
            playerSearchBar.isHidden = true
            PlayerSelectView.isHidden = true
            playerSearchBar.resignFirstResponder()
            let config = TMTitleOrImageButtonConfig(image: UIImage(systemName: "magnifyingglass")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(gameSearchingViewUp), actionTarget: self)
            startGameBtn.setUp(with: config)
            super.scaleTo(isEnlarge) {
                self.viewDownCompletionHandler()
            }
        }
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !self.point(inside: point, with: nil), toggle == true {
            scaleTo(toggle, completionHandler: {})
        }
        return super.hitTest(point, with: event)
    }

    // 实现 UISearchBarDelegate 协议中的 searchBarSearchButtonClicked 方法
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 获取搜索栏中的文本
        if let searchText = searchBar.text, !searchText.isEmpty {
            TMPlayerRequest.getInfo(loginName: searchText) { player in
                guard let player = player else {
                    self.players = []
                    self.PlayerSelectView.reloadData()
                    self.PlayerSelectView.isHidden = false
                    return
                }
                self.players = [player]
                self.PlayerSelectView.reloadData()
                self.PlayerSelectView.isHidden = false
            }
        } else {
            let toastView = UILabel()
            toastView.text = NSLocalizedString("The LoginName Should Not Be Null", comment: "")
            toastView.bounds = bounds
            toastView.backgroundColor = UIColor(named: "ComponentBackground")
            toastView.textAlignment = .center
            toastView.setCorner(radii: 15)
            showToast(toastView, position: .center) { _ in
            }
        }
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if players.count == 0 {} else {
            let vc = TMCommonPlayerInfoViewController()
            vc.player = players[indexPath.row]
            if let currentVC = self.getParentViewController() {
                currentVC.present(vc, animated: true)
            }
        }
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        players.count == 0 ? 1 : players.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if players.count == 0 {
            let cell = TMPopUpCell()
            cell.setupUI()
            cell.setupEvent(title: "No Such Player")
            return cell
        } else {
            let cell = TMplayerSelectionCell()
            cell.setupEvent(imageName: players[indexPath.row].icon.toPng(), playerName: players[indexPath.row].name, playerId: players[indexPath.row].id)
            return cell
        }
    }

    @objc func gameSearchingViewUp() {
        scaleTo(toggle, completionHandler: {})
    }

    @objc func startGame() {}
}
