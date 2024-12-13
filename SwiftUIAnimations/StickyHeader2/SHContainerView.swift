//
//  SHContainerView.swift
//  SwiftUIAnimations
//
//  Created by Mohammad Afshar on 13/12/2024.
//

import SwiftUI

struct SHContainerView: View {
    var body: some View {
        ScrollView {
            VStack {
                imageView()
                
                GeometryReader { geometry in
                    let minY = geometry.frame(in: .global).minY
                    
                    HStack(spacing: 10) {
                        Button {
                            
                        } label: {
                            Label("Message", systemImage: "message")
                                .font(.callout)
                                .bold()
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 45)
                                .background(.black, in: .capsule)
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "multiply")
                                .resizable()
                                .scaledToFill()
                                .foregroundStyle(.white)
                                .frame(width: 14, height: 10)
                                .padding()
                                .background(.black, in: .circle)
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "camera")
                                .resizable()
                                .scaledToFill()
                                .foregroundStyle(.white)
                                .frame(width: 14, height: 10)
                                .padding()
                                .background(.black, in: .circle)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .offset(y: max(60 - minY, 0))
                }
                .offset(y: -44)
                .zIndex(1)
                
                LazyVGrid(
                    columns: Array(
                        repeating: GridItem(),
                        count: 2
                    )) {
                        ForEach(0...25, id: \.self) { item in
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.ultraThinMaterial)
                                .frame(width: 180, height: 220)
                        }
                    }
                    .padding(.vertical, 10)
            }
        }
//        .ignoresSafeArea()
    }
}

extension SHContainerView {
    @ViewBuilder
    private func imageView() -> some View {
        GeometryReader { geometry in
            let minY = geometry.frame(in: .global).minY
            let isScrolling = minY > 0
            
            VStack {
                Image(.imageA)
                    .resizable()
                    .scaledToFill()
                    .frame(height: isScrolling ? minY + 180 : 180)
                    .clipped()
                    .offset(y: isScrolling ? -minY : 0)
                    .blur(radius: isScrolling ? 0 + minY / 180 : 0)
                    .overlay(alignment: .bottom) {
                        ZStack {
                            Image(.imageB)
                                .resizable()
                                .scaledToFill()
                            
                            Circle()
                                .stroke(lineWidth: 5)
                        }
                        .frame(width: 110, height: 110)
                        .clipShape(.circle)
                        .offset(y: 50)
                        .offset(y: isScrolling ? -minY : 0)
                    }
                
                Group {
                    VStack(spacing: 5) {
                        Text("Mohammad Afshar")
                            .font(.title)
                            .bold()
                        
                        Text("Software Engineer")
                            .font(.callout)
                            .multilineTextAlignment(.center)
                            .frame(width: geometry.size.width - 30)
                            .lineLimit(3)
                            .fixedSize()
                    }
                    .offset(y: isScrolling ? -minY : 0)
                }
                .padding(.vertical, 50)
            }
        }
        .frame(height: 395)
    }
}

#Preview {
    SHContainerView()
}
