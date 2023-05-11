//
//  TMMarkerAnnotationView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/28.
//

import Foundation
import MapKit

class TMMarkerAnnotationView: MKMarkerAnnotationView {
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var annotation: MKAnnotation? {
        didSet {
            setupUI()
        }
    }

    func setupUI() {
        contentMode = .scaleAspectFit
        glyphText = ""
        glyphTintColor = UIColor.clear
        markerTintColor = UIColor(named: "Tennis")
    }
}
