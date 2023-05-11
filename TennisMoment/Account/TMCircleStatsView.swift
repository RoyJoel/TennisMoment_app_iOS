//
//  TMCircleStatsView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/12.
//

import Foundation
import TMComponent

class TMCircleStatsView: TMView {
    var title: String = ""
    var sideLen: CGFloat = 0
    var radii: CGFloat = 0

    lazy var bigCircle: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var smallCircle: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var dataLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    func setUpUI(sideLen: CGFloat, insight _: CGFloat, title: String) {
        self.sideLen = sideLen
        backgroundColor = UIColor(named: "ComponentBackground")
        setCorner(radii: 15)

        addSubview(bigCircle)
        addSubview(smallCircle)
        addSubview(dataLabel)
        addSubview(titleLabel)

        bigCircle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(sideLen)
        }
        bigCircle.setCorner(radii: sideLen / 2)
        bigCircle.clipsToBounds = true
        smallCircle.clipsToBounds = true
        dataLabel.snp.makeConstraints { make in
            make.center.equalTo(bigCircle.snp.center)
        }
        bigCircle.backgroundColor = UIColor(named: "TennisBlur")
        smallCircle.backgroundColor = UIColor(named: "Tennis")

        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-12)
            make.centerX.equalToSuperview()
        }
        dataLabel.textAlignment = .center
        titleLabel.text = title
        if UIScreen.main.nativeBounds.height < 2360 {
            titleLabel.font = UIFont.systemFont(ofSize: 8)
        } else {
            titleLabel.font = UIFont.systemFont(ofSize: 10)
        }
        titleLabel.numberOfLines = 2
        dataLabel.textColor = .black
    }

    func startAnimation(radii: Int) {
        self.radii = Double(radii) / 100
        smallCircle.setCorner(radii: sideLen * self.radii / 2)
        smallCircle.snp.makeConstraints { make in
            make.center.equalTo(bigCircle.snp.center)
            make.width.height.equalTo(sideLen * self.radii)
        }
        dataLabel.text = "\(radii)%"
    }
}

// if UIDevice.current.userInterfaceIdiom == .pad && UIScreen.main.nativeBounds.height == 768 {
//    // iPad (第一代) 和 iPad 2
//    // 在这里添加您想要实现的逻辑
// } else if UIDevice.current.userInterfaceIdiom == .pad && UIScreen.main.nativeBounds.height == 1536 {
//    // iPad (第三代) 到 iPad (第八代)
//    // 在这里添加另外一种情况下您想要实现的逻辑
// } else if UIDevice.current.userInterfaceIdiom == .pad && UIScreen.main.nativeBounds.height == 1668 {
//    // iPad Air, iPad Air (第二代) 和 iPad Pro (第二代)
//    // 在这里添加另外一种情况下您想要实现的逻辑
// } else if UIDevice.current.userInterfaceIdiom == .pad && UIScreen.main.nativeBounds.height == 2224 {
//    // iPad Pro (第一代) 10.5 英寸
//    // 在这里添加另外一种情况下您想要实现的逻辑
// } else if UIDevice.current.userInterfaceIdiom == .pad && UIScreen.main.nativeBounds.height == 2360 {
//    // iPad Air (第四代)
//    // 在这里添加另外一种情况下您想要实现的逻辑
// } else if UIDevice.current.userInterfaceIdiom == .pad && UIScreen.main.nativeBounds.height == 2388 {
//    // iPad Pro (第三代) 和 iPad Pro (第四代) 11 英寸
//    // 在这里添加另外一种情况下您想要实现的逻辑
// } else if UIDevice.current.userInterfaceIdiom == .pad && UIScreen.main.nativeBounds.height == 2732 {
//    // iPad Pro (第一代) 12.9 英寸，iPad Pro (第二代) 到 iPad Pro (第五代) 12.9 英寸
//    // 在这里添加另外一种情况下您想要实现的逻辑
// }
