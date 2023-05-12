//
//  TMAddressTMitingViewController.swift
//  TMMS
//
//  Created by Jason Zhang on 2023/4/25.
//

import Foundation
import TMComponent
import UIKit

class TMAddressEditingViewController: UIViewController {
    var address = Address()
    let provincTMs = provincTMataSource()
    let cityDs = cityDataSource()
    let districtDs = districtDataSource()
    let sexDs = sexDataSource()
    var saveCompletionHandler: ((Address) -> Void)?

    lazy var sexSelectTMView: TMPopUpView = {
        let view = TMPopUpView()
        return view
    }()

    lazy var provinceSelectionView: TMPopUpView = {
        let view = TMPopUpView()
        return view
    }()

    lazy var citySelectionView: TMPopUpView = {
        let view = TMPopUpView()
        return view
    }()

    lazy var districtSelectionView: TMPopUpView = {
        let view = TMPopUpView()
        return view
    }()

    lazy var nameTextField: TMTextField = {
        let TextField = TMTextField()
        return TextField
    }()

    lazy var phoneNumberTextField: TMTextField = {
        let TextField = TMTextField()
        return TextField
    }()

    lazy var detailTMAddressTextField: TMTextField = {
        let TextField = TMTextField()
        return TextField
    }()

    lazy var doneBtn: UIButton = {
        let btn = UIButton()
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "BackgroundGray")
        view.addSubview(nameTextField)
        view.addSubview(sexSelectTMView)
        view.addSubview(phoneNumberTextField)
        view.addSubview(provinceSelectionView)
        view.addSubview(citySelectionView)
        view.addSubview(districtSelectionView)
        view.addSubview(detailTMAddressTextField)
        view.addSubview(doneBtn)

        nameTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(188)
            make.height.equalTo(44)
            make.width.equalTo(UIScreen.main.bounds.width * 0.6)
        }

        sexSelectTMView.frame = CGRect(x: 48 + UIScreen.main.bounds.width * 0.6, y: 188, width: 88, height: 44)
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(12)
            make.height.equalTo(44)
            make.left.equalToSuperview().offset(24)
        }

        provinceSelectionView.frame = CGRect(x: 24, y: 300, width: 102, height: 44)
        citySelectionView.frame = CGRect(x: 150, y: 300, width: 102, height: 44)
        districtSelectionView.frame = CGRect(x: 276, y: 300, width: 102, height: 44)

        detailTMAddressTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(68)
            make.height.equalTo(44)
        }

        doneBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(detailTMAddressTextField.snp.bottom).offset(68)
            make.width.equalTo(88)
            make.height.equalTo(44)
        }
        doneBtn.setTitle("保存", for: .normal)
        doneBtn.addTarget(self, action: #selector(saveAddress), for: .touchDown)
        doneBtn.setTitleColor(UIColor(named: "ContentBackground"), for: .normal)
        doneBtn.setCorner(radii: 10)
        doneBtn.backgroundColor = UIColor(named: "TennisBlur")
        nameTextField.textField.textAlignment = .center
        phoneNumberTextField.textField.textAlignment = .center
    }

    func setupEvent(address: Address) {
        self.address = address
        TMAddressRequest.requestGDAddress { res in
            guard let res = res else {
                return
            }
            self.provincTMs.provinces = res
            if let province = self.provincTMs.provinces.first(where: { $0.name == address.province }) {
                self.provincTMs.provinces.removeAll(where: { $0.name == address.province })
                self.provincTMs.provinces.insert(province, at: 0)
            }
            self.provinceSelectionView.dataSource = self.provincTMs
            self.view.bringSubviewToFront(self.provinceSelectionView)
            self.provinceSelectionView.delegate = self.provinceSelectionView
            self.provinceSelectionView.reloadData()
            self.provinceSelectionView.setupUI()

            self.cityDs.cities = self.provincTMs.provinces[0].districts ?? []
            if let city = self.cityDs.cities.first(where: { $0.name == address.city }) {
                self.cityDs.cities.removeAll(where: { $0.name == address.city })
                self.cityDs.cities.insert(city, at: 0)
            }
            self.citySelectionView.dataSource = self.cityDs
            self.view.bringSubviewToFront(self.citySelectionView)
            self.citySelectionView.delegate = self.citySelectionView
            self.citySelectionView.reloadData()
            self.citySelectionView.setupUI()

            self.districtDs.districts = self.cityDs.cities[0].districts ?? []
            if let area = self.districtDs.districts.first(where: { $0.name == address.area }) {
                self.districtDs.districts.removeAll { $0.name == address.area }
                self.districtDs.districts.insert(area, at: 0)
            }
            self.districtSelectionView.dataSource = self.districtDs
            self.view.bringSubviewToFront(self.districtSelectionView)
            self.districtSelectionView.delegate = self.districtSelectionView
            self.districtSelectionView.reloadData()
            self.districtSelectionView.setupUI()

            self.provinceSelectionView.selectedCompletionHandler = { index in
                let selectTMProvince = self.provincTMs.provinces.remove(at: index)
                self.provincTMs.provinces.insert(selectTMProvince, at: 0)
                self.provinceSelectionView.reloadData()

                self.cityDs.cities = selectTMProvince.districts ?? []
                self.districtDs.districts = selectTMProvince.districts?[0].districts ?? []
                self.citySelectionView.reloadData()
                self.districtSelectionView.reloadData()
            }

            self.citySelectionView.selectedCompletionHandler = { index in
                let selectTMCity = self.cityDs.cities.remove(at: index)
                self.cityDs.cities.insert(selectTMCity, at: 0)
                self.citySelectionView.reloadData()

                self.districtDs.districts = selectTMCity.districts ?? []
                self.districtSelectionView.reloadData()
            }

            self.districtSelectionView.selectedCompletionHandler = { index in
                let selectTMdistrict = self.districtDs.districts.remove(at: index)
                self.districtDs.districts.insert(selectTMdistrict, at: 0)
                self.districtSelectionView.reloadData()
            }
        }

        if let sex = self.sexDs.sexConfig.first(where: { $0.rawValue == address.sex.rawValue }) {
            sexDs.sexConfig.removeAll { $0.rawValue == address.sex.rawValue }
            sexDs.sexConfig.insert(sex, at: 0)
        }
        sexSelectTMView.dataSource = sexDs
        view.bringSubviewToFront(sexSelectTMView)
        sexSelectTMView.delegate = sexSelectTMView
        sexSelectTMView.setupUI()
        sexSelectTMView.selectedCompletionHandler = { index in
            let selectTMSex = self.sexDs.sexConfig.remove(at: index)
            self.sexDs.sexConfig.insert(selectTMSex, at: 0)
            self.sexSelectTMView.reloadData()
        }

        let nameConfig = TMTextFieldConfig(placeholderText: "Enter your name", text: "\(address.name)")
        nameTextField.setup(with: nameConfig)
        let phoneNumberConfig = TMTextFieldConfig(placeholderText: "enter your phone number", text: "\(address.phoneNumber)")
        phoneNumberTextField.setup(with: phoneNumberConfig)
        let detailAddressConfig = TMTextFieldConfig(placeholderText: "detail address", text: "\(address.detailedAddress)")
        detailTMAddressTextField.setup(with: detailAddressConfig)
    }

    func getAddressInfo() -> Address {
        address = Address(id: address.id, name: nameTextField.textField.text ?? "", sex: sexDs.sexConfig[0], phoneNumber: phoneNumberTextField.textField.text ?? "", province: provincTMs.provinces[0].name, city: cityDs.cities[0].name, area: districtDs.districts[0].name, detailedAddress: detailTMAddressTextField.textField.text ?? "")
        return address
    }

    @objc func saveAddress() {
        (saveCompletionHandler ?? { _ in })(getAddressInfo())
        navigationController?.popViewController(animated: true)
    }
}

class sexDataSource: NSObject, UITableViewDataSource {
    var sexConfig = Sex.allCases
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        sexConfig.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMPopUpCell()
        cell.setupUI()
        cell.setupEvent(title: sexConfig[indexPath.row] == .Man ? "先生" : "女士")
        return cell
    }
}

class provincTMataSource: NSObject, UITableViewDataSource {
    var provinces: [District] = []
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        provinces.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMPopUpCell()
        cell.setupUI()
        cell.setupEvent(title: provinces[indexPath.row].name)
        return cell
    }
}

class cityDataSource: NSObject, UITableViewDataSource {
    var cities: [District] = []
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        cities.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMPopUpCell()
        cell.setupUI()
        cell.setupEvent(title: cities[indexPath.row].name)
        return cell
    }
}

class districtDataSource: NSObject, UITableViewDataSource {
    var districts: [District] = []
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        districts.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMPopUpCell()
        cell.setupUI()
        cell.setupEvent(title: districts[indexPath.row].name)
        return cell
    }
}
