//
//  BundleExtensions.swift
//  KindleBookshelf
//
//  Created by Yamazaki Mitsuyoshi on 2020/12/30.
//

import Foundation

extension Bundle {
    var appName: String {
        guard let name = object(forInfoDictionaryKey: "CFBundleDisplayName") as? String else {
            return ""
        }
        return name
    }
}
