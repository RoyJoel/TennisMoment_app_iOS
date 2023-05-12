//
//  EDComIntroContainerView.swift
//  EDMS
//
//  Created by Jason Zhang on 2023/4/22.
//

import Foundation
import JXSegmentedView
import UIKit

class TMComIntroContainerView: UIImageView, JXSegmentedListContainerViewListDelegate {
    override init(image: UIImage?) {
        super.init(image: image)
        contentMode = .scaleAspectFit
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func listView() -> UIView {
        return self
    }
}
