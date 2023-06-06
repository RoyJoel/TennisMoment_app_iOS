//
//  TMFilterView.swift
// TennisMoment
//
//  Created by Jason Zhang on 2023/4/21.
//

import Foundation
import TMComponent
import UIKit

class TMFilterView: TMView {
    let cagDS = cagFilterDataSource()
    let pointsDS = pointsFilterDataSource()
    var cagCurIndex: String = cagFilterDataSource().filterItems[0]
    var pointsCurIndex: String = comPoint.none.displayName
    var completionHandler: (([Commodity]) -> Void)?

    lazy var filterBtn: UIButton = {
        let btn = UIButton()
        return btn
    }()

    lazy var cagFilter: TMPopUpView = {
        let view = TMPopUpView()
        return view
    }()

    lazy var pointsFilter: TMPopUpView = {
        let view = TMPopUpView()
        return view
    }()

    func setupUI() {
        addSubview(filterBtn)
        addSubview(cagFilter)
        addSubview(pointsFilter)
        bringSubviewToFront(filterBtn)

        filterBtn.frame = CGRect(x: bounds.width - 74, y: 0, width: 78, height: bounds.height)
        cagFilter.frame = CGRect(x: 6, y: 0, width: 78, height: bounds.height)
        pointsFilter.frame = CGRect(x: 6, y: 0, width: 78, height: bounds.height)
        filterBtn.setCorner(radii: 8)
        filterBtn.backgroundColor = UIColor(named: "ComponentBackground")
        filterBtn.setTitleColor(UIColor(named: "ContentBackground"), for: .normal)
        filterBtn.setTitle("筛选", for: .normal)

        cagFilter.delegate = cagFilter
        cagFilter.dataSource = cagDS
        cagFilter.setupUI()
        cagFilter.selectedCompletionHandler = { index in
            let selectedCag = self.cagDS.filterItems.remove(at: index)
            self.cagDS.filterItems.insert(selectedCag, at: 0)
            self.cagFilter.reloadData()
        }

        pointsFilter.delegate = pointsFilter
        pointsFilter.dataSource = pointsDS
        pointsFilter.setupUI()
        pointsFilter.selectedCompletionHandler = { index in
            let selectedPoints = self.pointsDS.filterItems.remove(at: index)
            self.pointsDS.filterItems.insert(selectedPoints, at: 0)
            self.pointsFilter.reloadData()
        }

        cagFilter.isHidden = true
        pointsFilter.isHidden = true
        filterBtn.addTarget(self, action: #selector(showFilter), for: .touchDown)

        cagCurIndex = cagDS.filterItems[0]
        pointsCurIndex = pointsDS.filterItems[0]
    }

    override func scaleTo(_ isEnlarge: Bool) {
        super.scaleTo(isEnlarge) {
            if isEnlarge {
                self.cagFilter.isHidden = true
                self.pointsFilter.isHidden = true
            }
        }
        if !isEnlarge {
            cagFilter.isHidden = false
            pointsFilter.isHidden = false
            pointsFilter.addAnimation(pointsFilter.layer.position, CGPoint(x: 135, y: bounds.height / 2), 0.15, "position")
            pointsFilter.layer.position = CGPoint(x: 135, y: bounds.height / 2)
            pointsFilter.setupSize()
            filterBtn.addAnimation(filterBtn.layer.position, CGPoint(x: 225, y: bounds.height / 2), 0.3, "position")
            filterBtn.layer.position = CGPoint(x: 225, y: bounds.height / 2)
        } else {
            filterBtn.addAnimation(filterBtn.layer.position, CGPoint(x: 45, y: bounds.height / 2), 0.3, "position")
            filterBtn.layer.position = CGPoint(x: 45, y: bounds.height / 2)
            pointsFilter.addAnimation(pointsFilter.layer.position, CGPoint(x: 45, y: bounds.height / 2), 0.15, "position")
            pointsFilter.layer.position = CGPoint(x: 45, y: bounds.height / 2)
            pointsFilter.setupSize()
        }
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)

        if CGRectContainsPoint(cagFilter.frame, point) {
            if pointsFilter.toggle == true {
                pointsFilter.fold()
            }
        } else if CGRectContainsPoint(pointsFilter.frame, point) {
            if cagFilter.toggle == true {
                cagFilter.fold()
            }
        } else if CGRectContainsPoint(filterBtn.frame, point) {
            if cagFilter.toggle == true {
                cagFilter.fold()
            }
            if pointsFilter.toggle == true {
                pointsFilter.fold()
            }
        } else {
            if toggle {
                if cagFilter.toggle == true {
                    cagFilter.fold()
                }
                if pointsFilter.toggle == true {
                    pointsFilter.fold()
                }
                scaleTo(toggle)
                filterBtn.removeTarget(self, action: #selector(applyFilter), for: .touchDown)
                filterBtn.setTitle("筛选", for: .normal)
                filterBtn.addTarget(self, action: #selector(showFilter), for: .touchDown)
            }
        }
        return view
    }

    @objc func showFilter() {
        scaleTo(toggle)
        filterBtn.removeTarget(self, action: #selector(showFilter), for: .touchDown)
        filterBtn.setTitle("应用", for: .normal)
        filterBtn.addTarget(self, action: #selector(applyFilter), for: .touchDown)
    }

    @objc func applyFilter() {
        let selectedCag = cagDS.filterItems[0]
        let selectedPoints = pointsDS.filterItems[0]
        var cagFilteredComs: [Commodity] = []
        var pointFilteredComs: [Commodity] = []
        if ComCag(displayName: selectedCag).rawValue == 0 {
            cagFilteredComs = TMUser.commodities
        } else {
            cagFilteredComs = TMUser.commodities.filter { $0.cag.displayName == selectedCag }
        }

        if comPoint(displayName: selectedPoints).rawValue == 0 {
            pointFilteredComs = cagFilteredComs
        } else if comPoint(displayName: selectedPoints).rawValue == 1 {
            pointFilteredComs = cagFilteredComs.filter { $0.options[0].price < 100 }
        } else if comPoint(displayName: selectedPoints).rawValue == 2 {
            pointFilteredComs = cagFilteredComs.filter { $0.options[0].price >= 100 && $0.options[0].price < 500 }
        } else if comPoint(displayName: selectedPoints).rawValue == 3 {
            pointFilteredComs = cagFilteredComs.filter { $0.options[0].price > 500 && $0.options[0].price < 1000 }
        } else if comPoint(displayName: selectedPoints).rawValue == 4 {
            pointFilteredComs = cagFilteredComs.filter { $0.options[0].price > 1000 }
        }
        (completionHandler ?? { _ in })(pointFilteredComs)

        scaleTo(toggle)
        filterBtn.removeTarget(self, action: #selector(applyFilter), for: .touchDown)
        filterBtn.setTitle("筛选", for: .normal)
        filterBtn.addTarget(self, action: #selector(showFilter), for: .touchDown)
        cagCurIndex = cagDS.filterItems[0]
        pointsCurIndex = pointsDS.filterItems[0]
    }
}

class pointsFilterDataSource: NSObject, UITableViewDataSource {
    var filterItems = comPoint.allCases.compactMap { $0.displayName }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        filterItems.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMPopUpCell()
        cell.setupUI()
        cell.setupEvent(title: filterItems[indexPath.row])
        cell.backgroundColor = UIColor(named: "ComponentBackground")
        return cell
    }
}

class cagFilterDataSource: NSObject, UITableViewDataSource {
    var filterItems = ComCag.allCases.compactMap { $0.displayName }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        filterItems.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMPopUpCell()
        cell.setupUI()
        cell.setupEvent(title: filterItems[indexPath.row])
        cell.backgroundColor = UIColor(named: "ComponentBackground")
        return cell
    }
}

enum comPoint: Int, Codable, CaseIterable {
    case none = 0
    case small = 1
    case med = 2
    case medWell = 3
    case wellDone = 4

    var displayName: String {
        switch self {
        case .none:
            return "不限"
        case .small:
            return "<100"
        case .med:
            return "100-500"
        case .medWell:
            return "500-1000"
        case .wellDone:
            return ">1000"
        }
    }

    init(displayName: String) {
        switch displayName {
        case ">1000":
            self = .wellDone
        case "500-1000":
            self = .medWell
        case "100-500":
            self = .med
        case "<100":
            self = .small
        default:
            self = .none
        }
    }
}

enum comCag: Int, Codable, CaseIterable {
    case none = 0
    case Decoration = 1
    case ClothingMatching = 2
    case Accessories = 3
    case Tableware = 4
    case PictureFrame = 5

    var displayName: String {
        switch self {
        case .none:
            return "不限"
        case .Decoration:
            return "家居装饰"
        case .ClothingMatching:
            return "服饰搭配"
        case .Accessories:
            return "手机配件"
        case .Tableware:
            return "水杯餐具"
        case .PictureFrame:
            return "相框摆台"
        }
    }

    init(displayName: String) {
        switch displayName {
        case "家居装饰":
            self = .Decoration
        case "服饰搭配":
            self = .ClothingMatching
        case "手机配件":
            self = .Accessories
        case "水杯餐具":
            self = .Tableware
        case "相框摆台":
            self = .PictureFrame
        default:
            self = .none
        }
    }
}
