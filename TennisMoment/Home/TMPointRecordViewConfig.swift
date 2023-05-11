//
//  TMPointRecordViewConfig.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/23.
//

import Foundation
import UIKit

class TMPointRecordViewConfig {
    var rowHeight: CGFloat
    var rowSpacing: CGFloat
    var font: UIFont
    var isTitleHidden: Bool
    var isPlayer1Serving: Bool
    var isPlayer1Left: Bool
    var isGameCompleted: Bool
    var player1SetNum: Int
    var player2SetNum: Int
    var player1GameNum: Int
    var player2GameNum: Int
    var player1PointNum: String
    var player2PointNum: String

    init(rowHeight: CGFloat, rowSpacing: CGFloat, font: UIFont, isTitleHidden: Bool, isPlayer1Serving: Bool, isPlayer1Left: Bool, isGameCompleted: Bool, player1SetNum: Int, player2SetNum: Int, player1GameNum: Int, player2GameNum: Int, player1PointNum: String, player2PointNum: String) {
        self.rowHeight = rowHeight
        self.rowSpacing = rowSpacing
        self.font = font
        self.isTitleHidden = isTitleHidden
        self.isPlayer1Serving = isPlayer1Serving
        self.isPlayer1Left = isPlayer1Left
        self.isGameCompleted = isGameCompleted
        self.player1SetNum = player1SetNum
        self.player2SetNum = player2SetNum
        self.player1GameNum = player1GameNum
        self.player2GameNum = player2GameNum
        self.player1PointNum = player1PointNum
        self.player2PointNum = player2PointNum
    }
}
