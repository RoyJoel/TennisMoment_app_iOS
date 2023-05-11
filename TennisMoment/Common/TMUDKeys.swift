//
//  TMUDKeys.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/4/2.
//

import Foundation

enum TMUDKeys: String {
    // 用户信息
    case UserInfo

    // 非首次下载
    case isNotFirstDownload

    // 距离上次比赛的时间
    case lastGameTime

    // 目前设备上正在进行的比赛
    case liveMatch

    // 用户token
    case JSONWebToken

    // 此设备登录过的用户
    case loggedinUser

    // 离线状态下记录的比赛
    case LocalGames
}
