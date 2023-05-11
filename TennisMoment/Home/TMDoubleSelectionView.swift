//
//  TMDoubleSelectionView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/4/5.
//

import Foundation
import UIKit

class TMDoubleSelectionView: UIView {
    var isPlayer1Serving: Bool = true
    lazy var leftServerView: TMServerView = {
        let serveView = TMServerView()
        return serveView
    }()

    lazy var rightServerView: TMServerView = {
        let serveView = TMServerView()
        return serveView
    }()

    func setupUI() {
        addSubview(leftServerView)
        addSubview(rightServerView)
        leftServerView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2)
        }
        rightServerView.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2)
        }
        leftServerView.addTapGesture(self, #selector(changeServe))
        rightServerView.addTapGesture(self, #selector(changeServe))
    }

    func setupEvent(config: TMServeViewConfig) {
        leftServerView.setup(isServing: isPlayer1Serving, config: TMServeViewConfig(selectedImage: config.selectedImage, unSelectedImage: config.unSelectedImage, selectedTitle: config.selectedTitle, unselectedTitle: config.unselectedTitle))
        rightServerView.setup(isServing: !isPlayer1Serving, config: TMServeViewConfig(selectedImage: config.selectedImage, unSelectedImage: config.unSelectedImage, selectedTitle: config.selectedTitle, unselectedTitle: config.unselectedTitle))
    }

    @objc func changeServe() {
        isPlayer1Serving.toggle()
        leftServerView.changeStats(to: isPlayer1Serving)
        rightServerView.changeStats(to: !isPlayer1Serving)
    }
}
