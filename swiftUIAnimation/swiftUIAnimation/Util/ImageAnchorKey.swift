//
//  ImageAnchorKey.swift
//  swiftUIAnimation
//
//  Created by Adhithya Ramakumar on 8/11/23.
//

import SwiftUI

struct ImageAnchorKey: PreferenceKey {
    static var defaultValue: [String: Anchor<CGRect>] = [:]
    static func reduce(value: inout [String : Anchor<CGRect>], nextValue: () -> [String : Anchor<CGRect>]) {
        value.merge(nextValue()) {
            $1
        }
    }
}

