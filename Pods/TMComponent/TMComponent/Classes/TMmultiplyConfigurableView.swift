//
//  TMLabel.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/17.
//

import Foundation
import UIKit

/// TM可配置多条比分视图
open class TMmultiplyConfigurableView: TMView {
    private lazy var view: TMPointComparingView = {
        var label = TMPointComparingView()
        return label
    }()

    var vsViews: [TMPointComparingView] = []

    public func setup(with config: TMmultiplyConfigurableViewConfig) {
        setupUI()
        setupEvent(config: config)
    }

    public func reset(with config: TMmultiplyConfigurableViewConfig) {
        var lastView = view
        view.snp.remakeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(config.rowHeight)
        }
        view.setup(with: config.configs[0])
        for i in 1 ..< vsViews.count {
            vsViews[i].setup(with: config.configs[i])
            vsViews[i].snp.remakeConstraints { make in
                make.top.equalTo(lastView.snp.bottom).offset(config.rowSpacing)
                make.width.equalToSuperview()
                make.height.equalTo(config.rowHeight)
            }
            lastView = vsViews[i]
        }
    }

    public func updateLeftDate(at index: Int, isServingOnLeft: Bool, newNum: String) {
        vsViews[index].updateLeftViewData(isServingOnLeft: isServingOnLeft, newNum: newNum)
    }

    public func updateRightDate(at index: Int, isServingOnRight: Bool, newNum: String) {
        vsViews[index].updateRightViewData(isServingOnRight: isServingOnRight, newNum: newNum)
    }

    public func setupUI() {
        addSubview(view)

        view.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }

    public func setupEvent(config: TMmultiplyConfigurableViewConfig) {
        var lastView = view
        vsViews.append(view)
        view.snp.remakeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(config.rowHeight)
        }
        view.setup(with: config.configs[0])
        for i in 1 ..< config.configs.count {
            lazy var nextView: TMPointComparingView = {
                let label = TMPointComparingView()
                return label
            }()
            nextView.setup(with: config.configs[i])
            addSubview(nextView)
            nextView.snp.makeConstraints { make in
                make.top.equalTo(lastView.snp.bottom).offset(config.rowSpacing)
                make.width.equalToSuperview()
                make.height.equalTo(config.rowHeight)
            }
            lastView = nextView
            vsViews.append(nextView)
        }
//        setView.setup(with: config.setViewConfig)
//        gameView.setup(with: config.gameViewConfig)
//        pointView.setup(with: config.pointViewConfig)
//        setView.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.width.equalToSuperview()
//            make.centerX.equalToSuperview()
//            make.height.equalTo(config.rowHeight)
//        }
//        gameView.snp.makeConstraints { make in
//            make.width.equalToSuperview()
//            make.centerX.equalToSuperview()
//            make.centerY.equalToSuperview()
//            make.height.equalTo(config.rowHeight)
//        }
//        pointView.snp.makeConstraints { make in
//            make.bottom.equalToSuperview()
//            make.width.equalToSuperview()
//            make.centerX.equalToSuperview()
//            make.height.equalTo(config.rowHeight)
//        }
    }

    public override func scaleTo(_ isEnlarge: Bool) {
        super.scaleTo(isEnlarge)
        if !isEnlarge {
//            setLabel.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
//            gameLabel.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
//            pointLabel.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
//
//            setLabel.isHidden = false
//            gameLabel.isHidden = false
//            pointLabel.isHidden = false

//            setView.snp.makeConstraints { make in
//                make.centerX.equalToSuperview()
//            }
//            gameView.snp.makeConstraints { make in
//                make.top.equalTo(setView.snp.bottom).offset(32)
//                make.centerX.equalToSuperview()
//            }
//            pointView.snp.makeConstraints { make in
//                make.top.equalTo(gameView.snp.bottom).offset(32)
//                make.centerX.equalToSuperview()
//            }

//            let setNumFont = UIFont.systemFont(ofSize: 36, weight: .semibold)
//            setNumLabel.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: setNumFont)
//            let gameNumFont = UIFont.systemFont(ofSize: 32, weight: .regular)
//            gameNumLabel.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: gameNumFont)
//            let pointNumFont = UIFont.systemFont(ofSize: 28, weight: .light)
//            pointNumLabel.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: pointNumFont)
//

        } else {
//            setView.snp.makeConstraints { make in
//                make.centerX.equalToSuperview()
//            }
//            gameView.snp.makeConstraints { make in
//                make.top.equalTo(setView.snp.bottom).offset(8)
//                make.centerX.equalToSuperview()
//            }
//            pointView.snp.makeConstraints { make in
//                make.top.equalTo(gameView.snp.bottom).offset(8)
//                make.centerX.equalToSuperview()
//            }

//            setLabel.isHidden = true
//            gameLabel.isHidden = true
//            pointLabel.isHidden = true
//
//            setLabel.snp.remakeConstraints { make in
//                make.top.equalToSuperview().offset(4)
//                make.centerX.equalToSuperview()
//            }
//            setNumLabel.snp.remakeConstraints { make in
//                make.top.equalTo(setLabel.snp.bottom).offset(4)
//                make.centerX.equalToSuperview()
//            }
//            gameLabel.snp.remakeConstraints { make in
//                make.top.equalTo(setNumLabel.snp.bottom).offset(8)
//                make.centerX.equalToSuperview()
//            }
//            gameNumLabel.snp.remakeConstraints { make in
//                make.top.equalTo(gameLabel.snp.bottom).offset(4)
//                make.centerX.equalToSuperview()
//            }
//            pointLabel.snp.remakeConstraints { make in
//                make.top.equalTo(gameNumLabel.snp.bottom).offset(8)
//                make.centerX.equalToSuperview()
//            }
//            pointNumLabel.snp.remakeConstraints { make in
//                make.top.equalTo(pointLabel.snp.bottom).offset(4)
//                make.centerX.equalToSuperview()
//            }
//            let font = UIFont.systemFont(ofSize: 17, weight: .light)
//            setLabel.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: font)
//            setNumLabel.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: font)
//            gameLabel.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: font)
//            gameNumLabel.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: font)
//            pointLabel.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: font)
//            pointNumLabel.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: font)
        }
    }
}
