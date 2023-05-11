//
//  TMLocation.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/4.
//

import CoreLocation
import Foundation
import UIKit

class TMLocationManager: NSObject {
    public static let shared = TMLocationManager()

    private var locationManager: CLLocationManager?
    private var viewController: UIViewController? // 承接外部传过来的视图控制器，做弹框处理

    // 外部初始化的对象调用，执行定位处理。
    func startPositioning(completionHandler: @escaping (CLLocation, String) -> Void) {
        if locationManager != nil, CLLocationManager.authorizationStatus() == .denied {
            // 定位提示
            let alert = UIAlertController(title: "定位服务未开启", message: "请进入系统设置>隐私>定位服务中打开开关,并允许TennisMoment使用定位服务", preferredStyle: .alert)
            let tempAction = UIAlertAction(title: "取消", style: .cancel) { _ in
            }
            let callAction = UIAlertAction(title: "前往设置", style: .default) { _ in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    }
                }
            }
            alert.addAction(tempAction)
            alert.addAction(callAction)

            if let window = UIApplication.shared.windows.first {
                viewController = window.rootViewController
                viewController?.present(alert, animated: true, completion: nil)
            }
        } else {
            requestLocationServicesAuthorization(completionHandler: { location, description in
                completionHandler(location, description)
            })
        }
    }

    // 初始化定位
    private func requestLocationServicesAuthorization(completionHandler: @escaping (CLLocation, String) -> Void) {
        if locationManager == nil {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
        }

        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()

        locationManager?.requestWhenInUseAuthorization()

        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse {
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            let distance: CLLocationDistance = 10.0
            locationManager?.distanceFilter = distance
            locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager?.startUpdatingLocation()
            let location = locationManager?.location
            getLocationDescription(location: location ?? CLLocation(), completionHandler: { location, des in
                completionHandler(location, des)
            })
        }
    }

    // 获取定位代理返回状态进行处理
    private func reportLocationServicesAuthorizationStatus(status: CLAuthorizationStatus) {
        if status == .notDetermined {} else if status == .restricted {} else if status == .denied {}
    }

    func getLocationDescription(location: CLLocation, completionHandler: @escaping (CLLocation, String) -> Void) {
        let geocoder = CLGeocoder()

        geocoder.reverseGeocodeLocation(location) { placemarks, _ in
            if let place = placemarks?[0] {
                let locality = place.locality ?? ""
                let name = place.name ?? ""
                let addressLines = locality + name

                completionHandler(location, addressLines)
            }
        }
    }
}

extension TMLocationManager: CLLocationManagerDelegate {
    func locationManager(_: CLLocationManager, didUpdateLocations _: [CLLocation]) {
        locationManager?.stopUpdatingLocation()
    }

    func locationManager(_: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        reportLocationServicesAuthorizationStatus(status: status)
    }

    func locationManager(_: CLLocationManager, didFailWithError _: Error) {
        locationManager?.stopUpdatingLocation()
    }
}
