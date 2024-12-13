//
//  ContainerView.swift
//  SwiftUIAnimations
//
//  Created by Mohammad Afshar on 11/12/2024.
//

import SwiftUI

struct ContainerView: View {
    var body: some View {
        GeometryReader {
            DetailsView(
                size: $0.size,
                safeArea: $0.safeAreaInsets,
                percentageHeight: 0.5) {
                    PlaceholderStackTextView()
                        .padding(.horizontal, 10)
                }
                .ignoresSafeArea(.all, edges: .top)
        }
    }
}

#Preview {
    ContainerView()
}
