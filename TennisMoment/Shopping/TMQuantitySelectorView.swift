//
// TMQuantitySelectorView.swift
// TennisMoment
//
//  Created by Jason Zhang on 2023/4/23.
//

import Foundation
import UIKit

class TMQuantitySelectorView: UIView, UITextFieldDelegate {
    public lazy var quantityTextField: UITextField = {
        let label = UITextField()
        label.textAlignment = .center
        label.text = "\(currentQuantity)"
        return label
    }()

    public lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.setTitleColor(UIColor(named: "ContentBackground"), for: .normal)
        button.setCorner(radii: 8)
        button.backgroundColor = UIColor(named: "TennisBlur")
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(decreaseQuantity), for: .touchUpInside)
        return button
    }()

    public lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setCorner(radii: 8)
        button.backgroundColor = UIColor(named: "TennisBlur")
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(increaseQuantity), for: .touchUpInside)
        return button
    }()

    public var currentQuantity: Int = 1 {
        didSet {
            quantityTextField.text = "\(currentQuantity)"
        }
    }

    var minimumQuantity: Int = 1
    var maximumQuantity: Int = 9999

    public func setupUI(maximumQuantity: Int) {
        self.maximumQuantity = maximumQuantity

        addSubview(quantityTextField)
        addSubview(minusButton)
        addSubview(plusButton)

        quantityTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(50)
        }

        minusButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalTo(quantityTextField.snp.leading)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }

        plusButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(quantityTextField.snp.trailing)
            make.trailing.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
        }

        quantityTextField.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let qua = Int(textField.text ?? "0") {
            if qua < 1 || qua > 999 {
                currentQuantity = 1
            }
        } else {
            currentQuantity = 1
        }
        textField.resignFirstResponder()
        return true
    }

    @objc private func decreaseQuantity() {
        guard currentQuantity > minimumQuantity else {
            return
        }
        currentQuantity -= 1
    }

    @objc private func increaseQuantity() {
        guard currentQuantity < maximumQuantity else {
            return
        }
        currentQuantity += 1
    }
}
