//
//  BundleExtension.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/4/6.
//

import Foundation

extension Bundle {
    private static var bundle: Bundle?

    public static func localizedBundle() -> Bundle? {
        if bundle == nil {
            let appLang = Bundle.main.object(forInfoDictionaryKey: "Language") as? String ?? "Ch"
            let path = Bundle.main.path(forResource: appLang, ofType: "lproj")
            bundle = Bundle(path: path!)
        }

        return bundle
    }

    public static func setLanguage(lang: String) {
        UserDefaults.standard.set(lang, forKey: "app_lang")
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        bundle = Bundle(path: path!)
    }
}
