//
//  DSOffsetKey.swift
//  SwiftUIAnimations
//
//  Created by Mohammad Afshar on 30/12/2024.
//

import SwiftUI

struct DSOffsetKey: PreferenceKey {
    static let defaultValue: CGFloat = .zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
