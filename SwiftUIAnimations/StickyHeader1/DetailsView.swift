//
//  DetailsView.swift
//  SwiftUIAnimations
//
//  Created by Mohammad Afshar on 10/12/2024.
//

import SwiftUI

struct ContentOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat = .zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

struct DetailsView<Content: View>: View {
    @State var contentOffset: CGFloat = .zero
    
    let size: CGSize
    let safeArea: EdgeInsets
    let percentageHeight: CGFloat
    let content: Content
    
    init(
        size: CGSize,
        safeArea: EdgeInsets,
        percentageHeight: CGFloat,
        content: () -> Content
    ) {
        self.size = size
        self.safeArea = safeArea
        self.percentageHeight = percentageHeight
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    content
                        .padding(.top, size.height * percentageHeight + 14)
                        .background {
                            GeometryReader { geo in
                                Color.clear
                                    .preference(
                                        key: ContentOffsetKey.self,
                                        value: geo.frame(in: .named("scrollview")).minY
                                    )
                            }
                        }
                }
                .scrollIndicators(.hidden)
                .coordinateSpace(name: "scrollview")
                .onPreferenceChange(ContentOffsetKey.self) { value in
                    self.contentOffset = value
                }
            }
            
            VStack {
                HeaderView(
                    contentOffset: $contentOffset,
                    size: size,
                    safeArea: safeArea,
                    percentageHeight: percentageHeight
                )
                
                Spacer()
            }
        }
    }
}

#Preview {
    ContainerView()
}
