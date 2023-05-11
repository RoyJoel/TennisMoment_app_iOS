//
//  TMRankingCell.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/4/16.
//
import CoreLocation
import Foundation
import MapKit
import UIKit

class TMRankingCell: UITableViewCell {
    lazy var rankLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var playerIcon: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    lazy var playerLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var dataLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(playerIcon)
        contentView.addSubview(playerLabel)
        contentView.addSubview(rankLabel)
        contentView.addSubview(dataLabel)
        contentView.backgroundColor = UIColor(named: "ComponentBackground")
        layoutSubviews()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerIcon.snp.makeConstraints { make in
            make.left.equalTo(rankLabel.snp.right)
            make.top.equalToSuperview().offset(6)
            make.bottom.equalToSuperview().offset(-6)
            make.width.equalTo(30)
        }
        playerLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(playerIcon.snp.right).offset(6)
            make.width.equalTo(186)
        }
        rankLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(68)
        }
        dataLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(playerLabel.snp.right)
        }
        playerIcon.contentMode = .scaleAspectFill
        playerIcon.setCorner(radii: 5)
        playerIcon.clipsToBounds = true
    }

    func setupEvent(rank: Int, player: Player, selection: selectionItem) {
        playerIcon.image = UIImage(data: player.icon.toPng())
        playerLabel.text = player.name
        rankLabel.text = "\(rank)"
        rankLabel.textAlignment = .center
        switch selection {
        case .Points:
            dataLabel.text = "\(player.points)"
        case .Aces:
            dataLabel.text = "\(player.careerStats.convertToRealStats().aces)"
        case .DoubleFaults:
            dataLabel.text = "\(player.careerStats.convertToRealStats().doubleFaults)"
        case .ReturnAces:
            dataLabel.text = "\(player.careerStats.convertToRealStats().returnAces)"
        case .NetPoints:
            dataLabel.text = "\(player.careerStats.convertToRealStats().netPoints)"
        case .UnforcedErrors:
            dataLabel.text = "\(player.careerStats.convertToRealStats().unforcedErrors)"
        case .ForehandWinners:
            dataLabel.text = "\(player.careerStats.convertToRealStats().forehandWinners)"
        case .BackhandWinners:
            dataLabel.text = "\(player.careerStats.convertToRealStats().backhandWinners)"
        case .FirstServeIn:
            dataLabel.text = "\(player.careerStats.convertToRealStats().firstServeIn)%"
        case .FirstServeWon:
            dataLabel.text = "\(player.careerStats.convertToRealStats().firstServeWon)%"
        case .SecondServeIn:
            dataLabel.text = "\(player.careerStats.convertToRealStats().secondServeIn)%"
        case .SecondServeWon:
            dataLabel.text = "\(player.careerStats.convertToRealStats().secondServeWon)%"
        case .FirstReturnServeIn:
            dataLabel.text = "\(player.careerStats.convertToRealStats().firstReturnServeIn)%"
        case .FirstReturnServeWon:
            dataLabel.text = "\(player.careerStats.convertToRealStats().firstReturnServeWon)%"
        case .SecondReturnServeIn:
            dataLabel.text = "\(player.careerStats.convertToRealStats().secondReturnServeIn)%"
        case .SecondReturnServeWon:
            dataLabel.text = "\(player.careerStats.convertToRealStats().secondReturnServeWon)%"
        case .BreakPointSaved:
            dataLabel.text = "\(player.careerStats.convertToRealStats().breakPointSaved)%"
        case .BreakPointConvert:
            dataLabel.text = "\(player.careerStats.convertToRealStats().breakPointConvert)%"
        case .ServeGameWon:
            dataLabel.text = "\(player.careerStats.convertToRealStats().serveGameWon)%"
        case .ReturnGameWon:
            dataLabel.text = "\(player.careerStats.convertToRealStats().returnGameWon)%"
        case .ServePointWon:
            dataLabel.text = "\(player.careerStats.convertToRealStats().servePointWon)%"
        case .ReturnPointWon:
            dataLabel.text = "\(player.careerStats.convertToRealStats().returnPointWon)%"
        }
        dataLabel.sizeToFit()
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if CGRectContainsPoint(dataLabel.frame, point) {
            return dataLabel
        }
        return super.hitTest(point, with: event)
    }
}
