//
//  HAAnchorKey.swift
//  SwiftUIAnimations
//
//  Created by Mohammad Afshar on 15/12/2024.
//

import SwiftUI

// For Reading the source and destination view bounds for our custom matched geometry reader
struct HAAnchorKey: PreferenceKey {
    static let defaultValue: [String : Anchor<CGRect>] = [:]
    
    static func reduce(value: inout [String : Anchor<CGRect>], nextValue: () -> [String : Anchor<CGRect>]) {
        value.merge(nextValue()) { $1 }
    }
}


//#Preview {
//    
//}
