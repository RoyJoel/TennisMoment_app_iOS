//
//  scoreControllerView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/23.
//

import Foundation
import TMComponent
import Toast_Swift
import UIKit

class TMScoreControllerView: TMScalableView {
    var isLeft: Bool = true

    lazy var aceBtn: TMButton = {
        let button = TMButton()
        button.backgroundColor = UIColor(named: "BackgroundGray")
        return button
    }()

    lazy var serveScoreBtn: TMButton = {
        let button = TMButton()
        button.backgroundColor = UIColor(named: "BackgroundGray")
        return button
    }()

    lazy var serveFaultBtn: TMButton = {
        let button = TMButton()
        button.backgroundColor = UIColor(named: "BackgroundGray")
        return button
    }()

    lazy var returnAceBtn: TMButton = {
        let button = TMButton()
        button.backgroundColor = UIColor(named: "BackgroundGray")
        return button
    }()

    lazy var unforcedErrorBtn: TMButton = {
        let button = TMButton()
        button.backgroundColor = UIColor(named: "BackgroundGray")
        return button
    }()

    lazy var forehandWinnersBtn: TMButton = {
        let button = TMButton()
        button.backgroundColor = UIColor(named: "BackgroundGray")
        return button
    }()

    lazy var backhandWinnersBtn: TMButton = {
        let button = TMButton()
        button.backgroundColor = UIColor(named: "BackgroundGray")
        return button
    }()

    lazy var netPointBtn: TMButton = {
        let button = TMButton()
        button.backgroundColor = UIColor(named: "BackgroundGray")
        return button
    }()

    func setupUI(isLeft: Bool) {
        toggle = true

        self.isLeft = isLeft

        addSubview(aceBtn)
        addSubview(serveScoreBtn)
        addSubview(serveFaultBtn)
        addSubview(returnAceBtn)
        addSubview(unforcedErrorBtn)
        addSubview(forehandWinnersBtn)
        addSubview(backhandWinnersBtn)
        addSubview(netPointBtn)

        let largeBtnWidth = (UIStandard.shared.screenHeight * 0.46 - 50) / 3
        let largeBtnHeight = (UIStandard.shared.screenWidth * 0.25 - 40) / 2
        let smallBtnHeight = (largeBtnHeight - 10) / 2

        if isLeft {
            aceBtn.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(15)
                make.left.equalToSuperview().offset(15)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(largeBtnHeight)
            }
            serveScoreBtn.snp.makeConstraints { make in
                make.top.equalTo(aceBtn.snp.top)
                make.left.equalTo(aceBtn.snp.right).offset(10)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(smallBtnHeight)
            }
            serveFaultBtn.snp.makeConstraints { make in
                make.top.equalTo(serveScoreBtn.snp.bottom).offset(10)
                make.left.equalTo(serveScoreBtn.snp.left)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(smallBtnHeight)
            }
            returnAceBtn.snp.makeConstraints { make in
                make.top.equalTo(aceBtn.snp.top)
                make.left.equalTo(serveScoreBtn.snp.right).offset(10)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(largeBtnHeight)
            }
            unforcedErrorBtn.snp.makeConstraints { make in
                make.top.equalTo(aceBtn.snp.bottom).offset(10)
                make.left.equalTo(aceBtn.snp.left)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(largeBtnHeight)
            }
            forehandWinnersBtn.snp.makeConstraints { make in
                make.top.equalTo(aceBtn.snp.bottom).offset(10)
                make.left.equalTo(unforcedErrorBtn.snp.right).offset(10)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(smallBtnHeight)
            }
            backhandWinnersBtn.snp.makeConstraints { make in
                make.top.equalTo(forehandWinnersBtn.snp.bottom).offset(10)
                make.left.equalTo(forehandWinnersBtn.snp.left)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(smallBtnHeight)
            }
            netPointBtn.snp.makeConstraints { make in
                make.top.equalTo(aceBtn.snp.bottom).offset(10)
                make.left.equalTo(forehandWinnersBtn.snp.right).offset(10)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(largeBtnHeight)
            }
        } else {
            aceBtn.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(15)
                make.right.equalToSuperview().offset(-15)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(largeBtnHeight)
            }
            serveScoreBtn.snp.makeConstraints { make in
                make.top.equalTo(aceBtn.snp.top)
                make.right.equalTo(aceBtn.snp.left).offset(-10)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(smallBtnHeight)
            }
            serveFaultBtn.snp.makeConstraints { make in
                make.top.equalTo(serveScoreBtn.snp.bottom).offset(10)
                make.right.equalTo(serveScoreBtn.snp.right)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(smallBtnHeight)
            }
            returnAceBtn.snp.makeConstraints { make in
                make.top.equalTo(aceBtn.snp.top)
                make.right.equalTo(serveScoreBtn.snp.left).offset(-10)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(largeBtnHeight)
            }
            unforcedErrorBtn.snp.makeConstraints { make in
                make.top.equalTo(aceBtn.snp.bottom).offset(10)
                make.right.equalTo(aceBtn.snp.right)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(largeBtnHeight)
            }
            forehandWinnersBtn.snp.makeConstraints { make in
                make.top.equalTo(aceBtn.snp.bottom).offset(10)
                make.right.equalTo(unforcedErrorBtn.snp.left).offset(-10)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(smallBtnHeight)
            }
            backhandWinnersBtn.snp.makeConstraints { make in
                make.top.equalTo(forehandWinnersBtn.snp.bottom).offset(10)
                make.right.equalTo(forehandWinnersBtn.snp.right)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(smallBtnHeight)
            }
            netPointBtn.snp.makeConstraints { make in
                make.top.equalTo(aceBtn.snp.bottom).offset(10)
                make.right.equalTo(forehandWinnersBtn.snp.left).offset(-10)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(largeBtnHeight)
            }
        }
    }
}
