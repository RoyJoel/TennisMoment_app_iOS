//
//  TMScheduleBookingView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/28.
//

import Foundation
import MapKit
import TMComponent
import UIKit

class TMScheduleBookingView: TMView, UISearchBarDelegate, MKMapViewDelegate, UITableViewDataSource {
    var players: [Player] = TMUser.user.friends
    var selectedMapItem: MKMapItem?
    var isDatePickerUp = false

    lazy var playerSelectView: TMPopUpView = {
        let popUoView = TMPopUpView()
        return popUoView
    }()

    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        return datePicker
    }()

    lazy var placeSearchBar: UISearchBar = {
        let button = UISearchBar()
        return button
    }()

    lazy var mapView: MKMapView = {
        let view = MKMapView()
        return view
    }()

    func setupUI() {
        backgroundColor = UIColor(named: "ComponentBackground")
        addSubview(placeSearchBar)
        addSubview(mapView)
        insertSubview(playerSelectView, aboveSubview: mapView)
        insertSubview(datePicker, aboveSubview: mapView)

        playerSelectView.frame = CGRect(x: 12, y: 12, width: 158, height: 44)
        datePicker.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.width.equalTo(222)
            make.height.equalTo(44)
        }
        placeSearchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalTo(playerSelectView.snp.right).offset(6)
            make.right.equalTo(datePicker.snp.left).offset(-6)
            make.height.equalTo(44)
        }
        mapView.snp.makeConstraints { make in
            make.top.equalTo(placeSearchBar.snp.bottom).offset(6)
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
        playerSelectView.delegate = playerSelectView
        placeSearchBar.placeholder = NSLocalizedString("Search", comment: "")
        placeSearchBar.searchBarStyle = .minimal
        placeSearchBar.delegate = self
        playerSelectView.isHidden = true
        placeSearchBar.isHidden = true
        datePicker.isHidden = true
        mapView.isHidden = true

        mapView.delegate = self
        mapView.addLongPressGesture(self, #selector(tapMapView(_:)))
        TMUser.getLocationCoor(completionHandler: { location in
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 3000, longitudinalMeters: 3000)
            self.mapView.setRegion(region, animated: true)
        })
    }

    override func scaleTo(_ isEnlarge: Bool) {
        super.scaleTo(isEnlarge) {
            if self.toggle {
                self.playerSelectView.isHidden = false
                self.placeSearchBar.isHidden = false
                self.datePicker.isHidden = false
                self.mapView.isHidden = false
            }
        }
        if !toggle {
            playerSelectView.isHidden = true
            placeSearchBar.isHidden = true
            datePicker.isHidden = true
            mapView.isHidden = true
            placeSearchBar.resignFirstResponder()
        }
    }

    func setupEvent(date: TimeInterval, place: String) {
        playerSelectView.dataSource = self
        playerSelectView.setupUI()
        playerSelectView.selectedCompletionHandler = { indexPath in
            if self.players.count == 0 {} else {
                let selectedPlayer = self.players.remove(at: indexPath)
                self.players.insert(selectedPlayer, at: 0)
                self.playerSelectView.reloadData()
            }
        }
        datePicker.date = Date(timeIntervalSince1970: date)
        placeSearchBar.text = place == "" ? nil : place
    }

    func refreshData() {
        playerSelectView.reloadData()
        playerSelectView.setupSize()
    }

    @objc func dateSelectButtonDidCliked() {
        isDatePickerUp.toggle()
        if isDatePickerUp {
            datePicker.isHidden = false
        } else {
            datePicker.isHidden = true
        }
    }

    @objc func tapMapView(_ gestureRecognizer: UIGestureRecognizer) {
        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)

        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = coordinate
        mapView.addAnnotation(pointAnnotation)
        selectedMapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
        let geocoder = CLGeocoder()
        let cllocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geocoder.reverseGeocodeLocation(cllocation) { placemarks, error in
            if error != nil {} else if let placemark = placemarks?.first {
                pointAnnotation.title = placemark.name
                self.selectedMapItem?.name = placemark.name
            }
        }
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        players = TMDataConvert.union(TMUser.user.friends, to: players)
        return players.count == 0 ? 1 : players.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if players.count == 0 {
            let cell = TMPopUpCell()
            cell.setupUI()
            cell.setupEvent(title: "Find a friend To Play With")
            return cell
        } else {
            let cell = TMplayerSelectionCell()
            cell.setupEvent(imageName: players[indexPath.row].icon.toPng(), playerName: players[indexPath.row].name, playerId: players[indexPath.row].id)
            return cell
        }
    }

    func tableView(_: UITableView, canMoveRowAt _: IndexPath) -> Bool {
        true
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // 获取用户选择的地点
        guard let annotation = view.annotation else { return }
        let selectedPlace = annotation.title!

        // 将地点添加到搜索框中
        placeSearchBar.text = selectedPlace
        selectedMapItem?.name = selectedPlace
        // 移动地图到选择的地点
        mapView.setCenter(annotation.coordinate, animated: true)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "marker"
        var view: TMMarkerAnnotationView

        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? TMMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = TMMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.glyphImage = UIImage(named: "TennisCourt")
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }

        view.isEnabled = true // 确保 annotation view 是可交互的

        return view
    }

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated _: Bool) {
        if placeSearchBar.text == "" {
            let searchRequest = MKLocalSearch.Request()
            searchRequest.naturalLanguageQuery = "网球场"
            searchRequest.region = mapView.region

            // 创建一个 MKLocalSearch 对象，并开始搜索
            let localSearch = MKLocalSearch(request: searchRequest)
            localSearch.start { response, error in
                if error != nil {
                    // 搜索出错，处理错误
                } else if let response = response {
                    // 搜索成功，处理搜索结果
                    self.mapView.removeAnnotations(self.mapView.annotations)
                    let mapItems = response.mapItems
                    for item in mapItems {
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = item.placemark.coordinate
                        annotation.title = item.name
                        annotation.subtitle = item.phoneNumber
                        self.mapView.addAnnotation(annotation)
                    }
                }
            }
        }
    }

    // 实现 UISearchBarDelegate 协议中的 searchBarSearchButtonClicked 方法
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 获取搜索栏中的文本
        let searchText = searchBar.text ?? ""

        if let selectedMapItem = selectedMapItem {
            searchBar.text = selectedMapItem.name
        }
        // 创建一个 MKLocalSearchRequest 对象，设置搜索文本和搜索区域（如果需要）
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchText
        searchRequest.region = mapView.region

        // 创建一个 MKLocalSearch 对象，并开始搜索
        let localSearch = MKLocalSearch(request: searchRequest)
        localSearch.start { response, error in
            if error != nil {} else if let response = response {
                // 搜索成功，处理搜索结果
                self.mapView.removeAnnotations(self.mapView.annotations)
                let mapItems = response.mapItems
                for item in mapItems {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    annotation.subtitle = item.phoneNumber
                    self.mapView.addAnnotation(annotation)
                }
                // 获取第一个搜索结果的经纬度坐标
                if let firstItem = mapItems.first {
                    let coordinate = firstItem.placemark.coordinate
                    // 移动地图到搜索位置
                    self.mapView.setCenter(coordinate, animated: true)
                }
            }
        }
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !self.point(inside: point, with: nil), toggle == true {
            scaleTo(toggle)
        }
        return super.hitTest(point, with: event)
    }
}
