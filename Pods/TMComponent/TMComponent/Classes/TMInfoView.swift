//
//  TMInfoView.swift
//  TMComponent
//
//  Created by Jason Zhang on 2023/3/24.
//

import Foundation

open class TMInfoView: TMView {
    public var config = TMInfoViewConfig(infoContent: "", infoContentFont: 0, infoTitle: "", infoTitleFont: 0, inset: 0)

    private lazy var infoContentView: UILabel = {
        var view = UILabel()
        return view
    }()

    private lazy var infoTitleView: UILabel = {
        var view = UILabel()
        return view
    }()

    public func setup(with config: TMInfoViewConfig) {
        self.config = config

        setupUI()
        setupEvent(config: config)
    }

    public func setupUI() {
        backgroundColor = UIColor(named: "ComponentBackground")
        addSubview(infoContentView)
        addSubview(infoTitleView)

        infoContentView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        infoTitleView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    public func setupEvent(config: TMInfoViewConfig) {
        infoContentView.text = config.infoContent
        infoContentView.font = UIFont.systemFont(ofSize: config.infoContentFont)
        infoTitleView.text = config.infoTitle
        infoTitleView.font = UIFont.systemFont(ofSize: config.infoTitleFont)
        infoContentView.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(config.inset)
        }
        infoTitleView.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-config.inset)
        }
    }

    public func updateInfo(with newData: String) {
        infoContentView.text = newData
    }
}
