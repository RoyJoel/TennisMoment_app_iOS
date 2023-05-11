//
//  TMSettingViewController.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/30.
//

import Foundation
import TMComponent
import UIKit

class TMSettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var settingConfig = ["Appearance": [AppearanceSetting.Light.userDisplayName, AppearanceSetting.Dark.userDisplayName, AppearanceSetting.UnSpecified.userDisplayName], "Language": [LanguageSetting.Ch.userDisplayName, LanguageSetting.En.userDisplayName, LanguageSetting.Es.userDisplayName, LanguageSetting.De.userDisplayName, LanguageSetting.Fr.userDisplayName], "Info": [""]]
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    lazy var signOutBtn: TMButton = {
        let btn = TMButton()
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundGray")
        navigationController?.navigationBar.tintColor = UIColor(named: "ContentBackground")
        view.addSubview(tableView)
        view.addSubview(signOutBtn)
        tableView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(signOutBtn.snp.top).offset(-5)
        }
        signOutBtn.snp.makeConstraints { make in
            make.width.equalTo(68)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-5)
        }
        tableView.backgroundColor = UIColor(named: "BackgroundGray")
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TMsettingTableViewCell.self, forCellReuseIdentifier: "TMsettingTableViewCell")
        let signOutBtnConfig = TMButtonConfig(title: "Sign Out", action: #selector(signOut), actionTarget: self)
        signOutBtn.setupUI()
        signOutBtn.setupEvent(config: signOutBtnConfig)
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = TMSettingIconCell()
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
            return cell
        } else if indexPath.row == 1 {
            let cell = TMsettingTableViewCell()
            cell.setupEvent(title: "Appearance", info: UserDefaults.standard.string(forKey: "AppleAppearance") ?? "UnSpecified")
            cell.selectionStyle = .none
            return cell
        } else if indexPath.row == 2 {
            let cell = TMsettingTableViewCell()
            if (UserDefaults.standard.stringArray(forKey: "AppleLanguages")?[0] ?? "Chinese").contains("en") {
                cell.setupEvent(title: "Language", info: "English")
            } else if (UserDefaults.standard.stringArray(forKey: "AppleLanguages")?[0] ?? "Chinese").contains("es") {
                cell.setupEvent(title: "Language", info: "Spanish")
            } else if (UserDefaults.standard.stringArray(forKey: "AppleLanguages")?[0] ?? "Chinese").contains("fr") {
                cell.setupEvent(title: "Language", info: "French")
            } else if (UserDefaults.standard.stringArray(forKey: "AppleLanguages")?[0] ?? "Chinese").contains("de") {
                cell.setupEvent(title: "Language", info: "German")
            } else {
                cell.setupEvent(title: "Language", info: "Chinese")
            }
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = TMsettingTableViewCell()
            cell.setupEvent(title: "Info", info: "")
            cell.selectionStyle = .none
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TMsettingTableViewCell
        if indexPath.row < 3 {
            let vc = TMSettingSelectionViewController()
            vc.title = cell.titleView.text
            let configs = ["Appearance", "Language"]
            vc.dataSource = settingConfig[configs[indexPath.row - 1]] ?? []
            vc.completionHandler = { result in
                if indexPath.row == 1 {
                    cell.setupEvent(title: "Appearance", info: result)
                } else if indexPath.row == 2 {
                    cell.setupEvent(title: "Language", info: result)
                }
            }
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = TMSettingInfoViewController()
            vc.isModalInPresentation = true
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 362
        } else {
            return 98
        }
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        4
    }

    @objc func signOut() {
        let sheetCtrl = UIAlertController(title: "Sign out?", message: nil, preferredStyle: .alert)

        let action = UIAlertAction(title: "Ok", style: .default) { _ in
            if let window = self.signOutBtn.window {
                UserDefaults.standard.set(nil, forKey: TMUDKeys.JSONWebToken.rawValue)
                UserDefaults.standard.set(nil, forKey: TMUDKeys.UserInfo.rawValue)
                window.rootViewController = TMSignInViewController()
            }
            self.navigationController?.popViewController(animated: true)
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
}
