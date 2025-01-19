//
//  MathOperationsSwift.swift
//  SwiftUIAnimations
//
//  Created by Mohammad Afshar on 22/12/2024.
//

import SwiftUI

struct NewScrollView: View {
    @State var scrollYPosition: Double = 0
    @State var scrollYNewPosition: Double = 0
    @State var frameFinal: Double = 0
    
    var frameHeight: CGFloat {
        get {
            if scrollYNewPosition >= 0 {
                return max(200 + (-scrollYNewPosition), 50)
            } else {
                return 200
            }
        }
    }
    
    var body: some View {
        getHeader()
//            .frame(
//                height: scrollYNewPosition >= 0.0
//                ? 200 + (-scrollYNewPosition) > 50
//                    ? 200 + (-scrollYNewPosition)
//                    : 50
//                : 200
//            )
            .frame(height: frameFinal != 0 ? frameFinal : frameHeight )
            .overlay {
                Text("\(scrollYNewPosition)")
            }
        
        ScrollView {
            ForEach(1...40, id: \.self) { item in
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.brown)
                    .frame(height: 50)
            }
        }
        .onScrollGeometryChange(for: Double.self) { geo in
            geo.contentOffset.y
        } action: { oldValue, newValue in
            scrollYNewPosition = newValue
        }
        .onScrollPhaseChange { oldPhase, newPhase, context in
            if newPhase == .idle {
//                if (scrollYPosition - scrollYNewPosition) >= 50 {
//                    frameFinal = 50
//                } else {
//                    frameFinal = 200
//                }
                scrollYPosition = context.geometry.contentOffset.y
//                print(scrollYNewPosition)
//                if context.geometry.contentOffset.y > scrollYPosition + 100 {
//                    scrollYPosition = 200
//                } else {
//                    scrollYPosition = 0
//                }
            } else {
                frameFinal = 0
            }
        }
        .animation(.bouncy, value: frameHeight)
    }
    
    @ViewBuilder
    func getHeader() -> some View {
        if frameHeight == 50 {
            RoundedRectangle(cornerRadius: 10)
                .fill(.pink)
        } else {
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray)
        }
    }
}

#Preview {
    NewScrollView()
}
