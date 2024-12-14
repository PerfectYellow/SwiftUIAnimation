//
//  SHHome.swift
//  SwiftUIAnimations
//
//  Created by Mohammad Afshar on 14/12/2024.
//

import SwiftUI

struct SHHome: View {
    @State private var offsetY: CGFloat = .zero
    
    let size: CGSize
    let safeArea: EdgeInsets
    
    var body: some View {
        ScrollViewReader { scrollProxy in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    HeaderView()
                        .zIndex(1)
                    
                    SampleCardsView()
                }
                .id("SCROLLVIEW")
                .background {
                    ScrollDetector { offset in
                        offsetY = -offset
    //                    print("offsetY: \(offsetY)")
                    } onDraggingEnd: { offset, velocity in
    //                    print("offset: \(offset), velocity: \(velocity)")
                        let headerHeight = (size.height * 0.3) + safeArea.top
                        let minimumHeaderHeight = 65 + safeArea.top
                        let targetEnd = offset + (velocity * 45)
                        
                        if targetEnd < (headerHeight - minimumHeaderHeight) && targetEnd > 0 {
                            withAnimation(.interactiveSpring) {
                                scrollProxy.scrollTo("SCROLLVIEW", anchor: .top)
                            }
                        }
                    }

                }
            }
        }
    }
}

// MARK: - Extensions
extension SHHome {
    @ViewBuilder
    func HeaderView() -> some View {
        let headerHeight = (size.height * 0.3) + safeArea.top
        let minimumHeaderHeight = 65 + safeArea.top
        let progress = max(min(-offsetY / (headerHeight - minimumHeaderHeight), 1), 0)
        
        GeometryReader { _ in
            ZStack {
                Rectangle()
                    .fill(.pink.gradient)
                
                VStack(spacing: 15) {
                    GeometryReader {
                        let rect = $0.frame(in: .global)
                        let halfScaledHeight = (rect.height * 0.3) * 0.5
                        let midY = rect.midY
                        let bottomPadding: CGFloat = 15
                        let resizedOffsetY = midY - (minimumHeaderHeight - halfScaledHeight - bottomPadding)
                        
                        Image(.imageC)
                            .resizable()
                            .aspectRatio(10/10, contentMode: .fit)
                            .frame(width: rect.width, height: rect.height)
                            .clipShape(.circle)
                            .scaleEffect(1 - (progress * 0.7), anchor: .leading)
                            .offset(x: -(rect.minX - 15) * progress, y: -resizedOffsetY * progress)
                    }
//                    .border(.blue, width: 5)
                    .frame(width: headerHeight * 0.5, height: headerHeight * 0.5)
                    
                    Text("Mohammad Afshar")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .scaleEffect(1 - (progress * 0.35))
                        .offset(y: -4.5 * progress)
                }
                .padding(.top, safeArea.top)
                .padding(.bottom, 15)
//                .border(.green, width: 5)
            }
            .frame(height: (headerHeight + offsetY) < minimumHeaderHeight ? minimumHeaderHeight : (headerHeight + offsetY), alignment: .bottom)
            .offset(y: -offsetY)
        }
        .frame(height: headerHeight)
    }
    
    @ViewBuilder
    func SampleCardsView() -> some View {
        VStack(spacing: 15) {
            ForEach(1...25, id: \.self) { _ in
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(.black.opacity(0.05))
                    .frame(height: 75)
            }
        }
    }
}


#Preview {
    SH3ContentView()
}
