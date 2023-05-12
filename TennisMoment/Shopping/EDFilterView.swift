//
//  EDFilterView.swift
//  EDMS
//
//  Created by Jason Zhang on 2023/4/21.
//

import Foundation
import TMComponent
import UIKit

class TMFilterView: TMView {
    let cagDS = cagFilterDataSource()
    let pointsDS = pointsFilterDataSource()
    var cagCurIndex: String = comCag.none.displayName
    var pointsCurIndex = ""
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

        filterBtn.frame = CGRect(x: bounds.width - 100, y: 0, width: 88, height: bounds.height)
        cagFilter.frame = CGRect(x: 12, y: 0, width: 88, height: bounds.height)
        pointsFilter.frame = CGRect(x: 12, y: 0, width: 88, height: bounds.height)
        filterBtn.setCorner(radii: 8)
        filterBtn.backgroundColor = UIColor(named: "ComponentBackground")
        filterBtn.setTitleColor(UIColor(named: "ContentBackground"), for: .normal)
        filterBtn.setTitle("Filter", for: .normal)

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
            pointsFilter.addAnimation(pointsFilter.layer.position, CGPoint(x: 150, y: bounds.height / 2), 0.15, "position")
            pointsFilter.layer.position = CGPoint(x: 150, y: bounds.height / 2)
            pointsFilter.setupSize()
            filterBtn.addAnimation(filterBtn.layer.position, CGPoint(x: 244, y: bounds.height / 2), 0.3, "position")
            filterBtn.layer.position = CGPoint(x: 244, y: bounds.height / 2)
        } else {
            filterBtn.addAnimation(filterBtn.layer.position, CGPoint(x: 56, y: bounds.height / 2), 0.3, "position")
            filterBtn.layer.position = CGPoint(x: 56, y: bounds.height / 2)
            pointsFilter.addAnimation(pointsFilter.layer.position, CGPoint(x: 56, y: bounds.height / 2), 0.15, "position")
            pointsFilter.layer.position = CGPoint(x: 56, y: bounds.height / 2)
            pointsFilter.setupSize()
        }
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)

        if CGRectContainsPoint(cagFilter.frame, point) {
            pointsDS.filterItems.removeAll(where: { $0 == pointsCurIndex })
            pointsDS.filterItems.insert(pointsCurIndex, at: 0)
            pointsFilter.reloadData()
            if pointsFilter.toggle == true {
                pointsFilter.fold()
            }
        } else if CGRectContainsPoint(pointsFilter.frame, point) {
            cagDS.filterItems.removeAll { $0 == cagCurIndex }
            cagDS.filterItems.insert(cagCurIndex, at: 0)
            cagFilter.reloadData()
            if cagFilter.toggle == true {
                cagFilter.fold()
            }
        } else if CGRectContainsPoint(filterBtn.frame, point) {
            cagDS.filterItems.removeAll { $0 == cagCurIndex }
            cagDS.filterItems.insert(cagCurIndex, at: 0)
            cagFilter.reloadData()
            if cagFilter.toggle == true {
                cagFilter.fold()
            }
            pointsDS.filterItems.removeAll(where: { $0 == pointsCurIndex })
            pointsDS.filterItems.insert(pointsCurIndex, at: 0)
            pointsFilter.reloadData()
            if pointsFilter.toggle == true {
                pointsFilter.fold()
            }
        } else {
            if toggle {
                cagDS.filterItems.removeAll { $0 == cagCurIndex }
                cagDS.filterItems.insert(cagCurIndex, at: 0)
                cagFilter.reloadData()
                if cagFilter.toggle == true {
                    cagFilter.fold()
                }
                pointsDS.filterItems.removeAll(where: { $0 == pointsCurIndex })
                pointsDS.filterItems.insert(pointsCurIndex, at: 0)
                pointsFilter.reloadData()
                if pointsFilter.toggle == true {
                    pointsFilter.fold()
                }
                scaleTo(toggle)
                filterBtn.removeTarget(self, action: #selector(applyFilter), for: .touchDown)
                filterBtn.setTitle("Filter", for: .normal)
                filterBtn.addTarget(self, action: #selector(showFilter), for: .touchDown)
            }
        }
        return view
    }

    @objc func showFilter() {
        scaleTo(toggle)
        filterBtn.removeTarget(self, action: #selector(showFilter), for: .touchDown)
        filterBtn.setTitle("Apply", for: .normal)
        filterBtn.addTarget(self, action: #selector(applyFilter), for: .touchDown)
    }

    @objc func applyFilter() {
        let selectedCag = cagDS.filterItems[0]
        let selectedPoints = pointsDS.filterItems[0]
        var filteredComs: [Commodity] = []
        if comCag(displayName: selectedCag).rawValue == 0 {
            filteredComs = com
        } else {
            filteredComs = com.filter { $0.cag == comCag(displayName: selectedCag).rawValue }
        }
        (completionHandler ?? { _ in })(filteredComs)

        scaleTo(toggle)
        filterBtn.removeTarget(self, action: #selector(applyFilter), for: .touchDown)
        filterBtn.setTitle("Filter", for: .normal)
        filterBtn.addTarget(self, action: #selector(showFilter), for: .touchDown)
        cagCurIndex = cagDS.filterItems[0]
        pointsCurIndex = pointsDS.filterItems[0]
    }
}

class pointsFilterDataSource: NSObject, UITableViewDataSource {
    var filterItems = ["<100", "100-500", "500-1000", "1000-2000", ">2000"]

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
    var filterItems = comCag.allCases.compactMap { $0.displayName }

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

enum comCag: Int, CaseIterable {
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
