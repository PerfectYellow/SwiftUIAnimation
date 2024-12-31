//
//  View+Extension.swift
//  SwiftUIAnimations
//
//  Created by Mohammad Afshar on 30/12/2024.
//

import SwiftUI

extension View {
    @ViewBuilder
    func heightChangePreference(completion: /*@Sendable*/ @escaping (CGFloat) -> Void) -> some View {
        self
            .overlay {
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: DSSizeKey.self, value: geometry.size.height)
                        .onPreferenceChange(DSSizeKey.self) { value in
                            completion(value)
                        }
                }
            }
    }
    
    @ViewBuilder
    func minXChangePreference(completion: /*@Sendable*/ @escaping (CGFloat) -> Void) -> some View {
        self
            .overlay {
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: DSOffsetKey.self, value: geometry.frame(in: .scrollView).minX)
                        .onPreferenceChange(DSOffsetKey.self) { value in
                            completion(value)
                        }
                }
            }
    }
}
