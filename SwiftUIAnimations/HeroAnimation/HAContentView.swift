//
//  HAContentView.swift
//  SwiftUIAnimations
//
//  Created by Mohammad Afshar on 15/12/2024.
//

import SwiftUI

struct HAContentView: View {
    @State var selectedProfile: ProfileModel?
    @State var pushView: Bool = false
    @State var hideView: (Bool, Bool) = (false, false)
    
    var body: some View {
        NavigationStack {
            HAHome(
                selectedProfile: $selectedProfile,
                pushedView: $pushView
            )
                .navigationTitle("Profile")
                .navigationDestination(isPresented: $pushView) {
                    HADetailsView(
                        selectedProfile: $selectedProfile,
                        pushView: $pushView,
                        hideView: $hideView
                    )
                }
        }
        .overlayPreferenceValue(HAAnchorKey.self) { value in
            GeometryReader { geometry in
                if let selectedProfile, let anchor = value[selectedProfile.id], !hideView.0 {
                    let rect = geometry[anchor]
                    HAImageView(profile: selectedProfile, size: rect.size)
                        .offset(x: rect.minX, y: rect.minY)
                        .animation(.snappy(duration: 0.35, extraBounce: 0), value: rect)
                }
            }
        }
    }
}

#Preview {
    HAContentView()
}
