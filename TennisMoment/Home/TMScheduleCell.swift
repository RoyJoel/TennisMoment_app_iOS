//
//  TMScheduleCell.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/28.
//

import CoreLocation
import Foundation
import MapKit
import UIKit

class TMScheduleCell: UITableViewCell {
    lazy var opponentIcon: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    lazy var opponentLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var placeLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(opponentIcon)
        contentView.addSubview(opponentLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(placeLabel)
        contentView.backgroundColor = UIColor(named: "ComponentBackground")
        layoutSubviews()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        opponentIcon.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(6)
            make.bottom.equalToSuperview().offset(-6)
            make.width.equalTo(30)
        }
        opponentLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(opponentIcon.snp.right).offset(6)
            make.width.equalTo(116)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(opponentLabel.snp.right)
            make.width.equalTo(158)
        }
        placeLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(dateLabel.snp.right)
        }
        opponentIcon.contentMode = .scaleAspectFill
        opponentIcon.setCorner(radii: 5)
        opponentIcon.clipsToBounds = true
        placeLabel.addTapGesture(self, #selector(openMap))
    }

    func setupEvent(schedule: Schedule) {
        opponentIcon.image = UIImage(data: schedule.opponent.icon.toPng())
        opponentLabel.text = schedule.opponent.name
        dateLabel.text = schedule.startDate.convertToString(formatterString: "yyyy MM-dd HH:mm")
        placeLabel.text = schedule.place
        placeLabel.sizeToFit()
    }

    @objc func openMap() {
        let address = placeLabel.text

        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = address
        let localSearch = MKLocalSearch(request: searchRequest)
        localSearch.start { response, error in
            if error != nil {} else if let response = response {
                // 获取第一个搜索结果的经纬度坐标
                if let firstItem = response.mapItems.first {
                    // Step 1: 创建MKMapItem对象
                    let fromMap = MKMapItem.forCurrentLocation()
                    let placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: firstItem.placemark.coordinate.latitude, longitude: firstItem.placemark.coordinate.longitude))
                    let toMapItem = MKMapItem(placemark: placemark)
                    toMapItem.name = address
                    // Step 2: 打开Apple地图应用程序
                    let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                    MKMapItem.openMaps(with: [fromMap, toMapItem], launchOptions: options)
                }
            }
        }
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if CGRectContainsPoint(placeLabel.frame, point) {
            return placeLabel
        }
        return super.hitTest(point, with: event)
    }
}
