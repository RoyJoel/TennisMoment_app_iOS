//
//  TMSettingSelectionViewController.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/31.
//

import Foundation
import TMComponent
import UIKit

class TMSettingSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var selectedRow: Int?
    var dataSource: [String] = []
    var completionHandler: (String) -> Void = { _ in }
    lazy var selectionTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(selectionTableView)
        selectionTableView.backgroundColor = UIColor(named: "BackgroundGray")
        selectionTableView.dataSource = self
        selectionTableView.delegate = self
        selectionTableView.register(TMSettingSelectionCell.self, forCellReuseIdentifier: "TMSettingSelectionCell")
        selectionTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        dataSource.count
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        118
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if title == "Language" {
            let selectedLanguage = LanguageSetting(userDisplayName: dataSource[indexPath.row])
            let message = "Change language of this app including its content."
            let sheetCtrl = UIAlertController(title: "Change language", message: message, preferredStyle: .alert)

            let action = UIAlertAction(title: "Ok", style: .default) { _ in
                self.changeToLanguage(languageCode: selectedLanguage.rawValue)
                self.select(at: indexPath)
            }
            sheetCtrl.addAction(action)

            let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in
                sheetCtrl.dismiss(animated: true)
            }
            sheetCtrl.addAction(cancelAction)

            sheetCtrl.popoverPresentationController?.sourceView = view
            sheetCtrl.popoverPresentationController?.sourceRect = CGRect(x: view.bounds.width / 2 - 144, y: view.bounds.height / 2 - 69, width: 288, height: 138)
            present(sheetCtrl, animated: true, completion: nil)
            completionHandler(selectedLanguage.userDisplayName)
        } else if title == "Appearance" {
            let selectedAppearance = AppearanceSetting(userDisplayName: dataSource[indexPath.row])
            UserDefaults.standard.set(selectedAppearance.userDisplayName, forKey: "AppleAppearance")

            if let window = selectionTableView.window {
                if selectedAppearance == .Dark {
                    window.overrideUserInterfaceStyle = .dark
                } else if selectedAppearance == .Light {
                    window.overrideUserInterfaceStyle = .light
                } else {
                    window.overrideUserInterfaceStyle = .unspecified
                }
            }

            select(at: indexPath)
            completionHandler(selectedAppearance.userDisplayName)
        }
    }

    func select(at indexPath: IndexPath) {
        if let lastSelected = selectedRow {
            let cell = selectionTableView.cellForRow(at: IndexPath(row: lastSelected, section: 0))
            cell?.isSelected = false
        }
        selectedRow = indexPath.row
        let cell = selectionTableView.cellForRow(at: indexPath) as? TMSettingSelectionCell
        cell?.isSelected = true
    }

    func changeToLanguage(languageCode: String) {
        UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        exit(1)
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMSettingSelectionCell()
        cell.setupEvent(title: dataSource[indexPath.row])
        cell.selectionStyle = .none
        if title == "Appearance" {
            if dataSource[indexPath.row] == UserDefaults.standard.string(forKey: "AppleAppearance") {
                cell.isSelected = true
                selectedRow = indexPath.row
            }
        } else if title == "Language" {
            var selectedLanguage = "Chinese"
            if (UserDefaults.standard.stringArray(forKey: "AppleLanguages")?[0] ?? "Chinese").contains("zh") {
                selectedLanguage = "Chinese"
            } else if (UserDefaults.standard.stringArray(forKey: "AppleLanguages")?[0] ?? "Chinese").contains("en") {
                selectedLanguage = "English"
            } else if (UserDefaults.standard.stringArray(forKey: "AppleLanguages")?[0] ?? "Chinese").contains("es") {
                selectedLanguage = "Spanish"
            } else if (UserDefaults.standard.stringArray(forKey: "AppleLanguages")?[0] ?? "Chinese").contains("fr") {
                selectedLanguage = "French"
            } else if (UserDefaults.standard.stringArray(forKey: "AppleLanguages")?[0] ?? "Chinese").contains("de") {
                selectedLanguage = "German"
            }
            if dataSource[indexPath.row] == selectedLanguage {
                cell.isSelected = true
                selectedRow = indexPath.row
            }
        }
        cell.addObserver(cell, forKeyPath: "isBeenSelected", options: [.new, .old], context: nil)
        return cell
    }
}
