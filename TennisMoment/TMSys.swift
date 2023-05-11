//
//  TMSys.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/6.
//

import Foundation
import Reachability
import TABAnimated

class TMSys {
    var reachability: Reachability?
    static let shard = TMSys()
    private init() {}

    func initWindow() -> UIWindow {
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        window.backgroundColor = .white
        window.overrideUserInterfaceStyle = initStyle()
        window.rootViewController = initRootViewController()
        window.makeKeyAndVisible()
        return window
    }

    func observeNetState() {
        if reachability == nil {
            do {
                reachability = try Reachability()
            } catch {
                print("Unable to create Reachability")
                return
            }

            reachability?.whenReachable = { _ in
                let localGamesDatas = UserDefaults.standard.array(forKey: TMUDKeys.LocalGames.rawValue) as? [[String: Any]]
                var localGames = localGamesDatas?.compactMap { Game(dictionary: $0) } ?? []
                for game in localGames {
                    TMGameRequest.updateGameAndStats(game: game) { updatedGame in
                        if updatedGame == game {
                            localGames.removeAll(where: { $0.id == updatedGame.id })
                        }
                    }
                }
                self.auth()
            }
            reachability?.whenUnreachable = { _ in
                if let userInfo = UserDefaults.standard.data(forKey: TMUDKeys.UserInfo.rawValue) {
                    do {
                        TMUser.user = try PropertyListDecoder().decode(User.self, from: userInfo)
                    } catch {
                        if let window = UIApplication.shared.windows.first {
                            window.rootViewController = TMSignInViewController()
                        }
                    }
                } else {
                    if let window = UIApplication.shared.windows.first {
                        window.rootViewController = TMSignInViewController()
                    }
                }
            }
        }
        try? reachability?.startNotifier()
    }

    func enterForeground() {
        if reachability?.connection != .unavailable {
            auth()
        }
    }

    func initRootViewController() -> UIViewController {
        let isNotFirstDownload = UserDefaults.standard.bool(forKey: TMUDKeys.isNotFirstDownload.rawValue)
        if !isNotFirstDownload {
            DispatchQueue.main.async {
                UserDefaults.standard.set(true, forKey: TMUDKeys.isNotFirstDownload.rawValue)
            }
            return TMSignInViewController()
        } else {
            if let userInfo = UserDefaults.standard.data(forKey: TMUDKeys.UserInfo.rawValue) {
                do {
                    TMUser.user = try PropertyListDecoder().decode(User.self, from: userInfo)
                    return TabViewController()
                } catch {
                    return TMSignInViewController()
                }
            } else {
                return TMSignInViewController()
            }
        }
    }

    func initStyle() -> UIUserInterfaceStyle {
        guard let appearance = UserDefaults.standard.string(forKey: "AppleAppearance") else {
            // 如果没有设置外观，则默认使用浅色模式。
            return .unspecified
        }
        let appearanceType = AppearanceSetting(userDisplayName: appearance)
        // 根据用户设置的外观来设置应用程序的外观。
        if appearanceType == .Dark {
            return .dark
        } else if appearanceType == .Light {
            return .light
        } else {
            return .unspecified
        }
    }

    func saveUserInfo() {
        if UserDefaults.standard.string(forKey: TMUDKeys.JSONWebToken.rawValue) != nil {
            let userInfo = try? PropertyListEncoder().encode(TMUser.user)
            UserDefaults.standard.set(userInfo, forKey: TMUDKeys.UserInfo.rawValue)
            NotificationCenter.default.post(name: Notification.Name(ToastNotification.DataSavingToast.notificationName.rawValue), object: nil)
            UserDefaults.standard.synchronize()
            TMUser.updateInfo { _ in
            }
        }
    }

    func auth() {
        if let token = UserDefaults.standard.string(forKey: TMUDKeys.JSONWebToken.rawValue) {
            TMUser.auth(token: token) { userLoginName, userPassword, error in
                guard error == nil else {
                    if let window = UIApplication.shared.windows.first {
                        let signInVC = TMSignInViewController()
                        window.rootViewController = signInVC
                        let toastView = UILabel()
                        toastView.text = NSLocalizedString("The login information has expired\n please log in again", comment: "")
                        toastView.numberOfLines = 2
                        toastView.bounds = CGRect(x: 0, y: 0, width: 350, height: 150)
                        toastView.backgroundColor = UIColor(named: "ComponentBackground")
                        toastView.textAlignment = .center
                        toastView.setCorner(radii: 15)
                        (window.rootViewController as? TMSignInViewController)?.contentOverlayView?.showToast(toastView, duration: 1, point: CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)) { _ in
                        }
                        window.rootViewController = TMSignInViewController()
                    }
                    return
                }
                guard let userLoginName = userLoginName else {
                    return
                }
                guard let userPassword = userPassword else {
                    return
                }
                TMUser.user.loginName = userLoginName
                TMUser.user.password = userPassword
                TMUser.signIn { user, error in
                    guard error == nil else {
                        if let window = UIApplication.shared.windows.first {
                            let toastView = UILabel()
                            toastView.text = NSLocalizedString("No such loginname or password", comment: "")
                            toastView.numberOfLines = 2
                            toastView.bounds = CGRect(x: 0, y: 0, width: 350, height: 150)
                            toastView.backgroundColor = UIColor(named: "ComponentBackground")
                            toastView.textAlignment = .center
                            toastView.setCorner(radii: 15)
                            (window.rootViewController as? TMSignInViewController)?.contentOverlayView?.showToast(toastView, duration: 1, point: CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)) { _ in
                            }
                            window.rootViewController = TMSignInViewController()
                        }
                        return
                    }
                    guard let user = user else {
                        if let window = UIApplication.shared.windows.first {
                            let toastView = UILabel()
                            toastView.text = NSLocalizedString("Login Failed", comment: "")
                            toastView.numberOfLines = 2
                            toastView.bounds = CGRect(x: 0, y: 0, width: 350, height: 150)
                            toastView.backgroundColor = UIColor(named: "ComponentBackground")
                            toastView.textAlignment = .center
                            toastView.setCorner(radii: 15)
                            (window.rootViewController as? TMSignInViewController)?.contentOverlayView?.showToast(toastView, duration: 1, point: CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)) { _ in
                            }
                            window.rootViewController = TMSignInViewController()
                        }
                        return
                    }
                    if let userInfo = UserDefaults.standard.data(forKey: TMUDKeys.UserInfo.rawValue) {
                        do {
                            let localUser = try PropertyListDecoder().decode(User.self, from: userInfo)
                            if localUser == user {
                                TMUser.user = user
                            } else {
                                if let window = UIApplication.shared.windows.first {
                                    let vc = TMUserDataSelectViewController()
                                    vc.localUserInfo = localUser
                                    vc.netUserInfo = user
                                    vc.isModalInPresentation = true
                                    window.rootViewController?.present(vc, animated: true)
                                }
                            }
                        } catch {
                            TMUser.user = user
                        }
                    } else {
                        TMUser.user = user
                    }
                    NotificationCenter.default.post(name: Notification.Name(ToastNotification.DataFreshToast.notificationName.rawValue), object: nil)
                    UserDefaults.standard.set(user.token, forKey: TMUDKeys.JSONWebToken.rawValue)
                }
            }
        } else {
            if let window = UIApplication.shared.windows.first {
                let signInVC = TMSignInViewController()
                window.rootViewController = signInVC
            }
        }
    }
}
