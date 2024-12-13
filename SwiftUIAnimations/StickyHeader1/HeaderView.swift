//
//  HeaderView.swift
//  SwiftUIAnimations
//
//  Created by Mohammad Afshar on 11/12/2024.
//

import SwiftUI

struct HeaderView: View {
    @State private var progress: CGFloat = 0
    @Binding var contentOffset: CGFloat
    
    let size: CGSize
    let safeArea: EdgeInsets
    private let minHeight: CGFloat
    let percentageHeight: CGFloat
    
    init(
        contentOffset: Binding<CGFloat>,
        size: CGSize,
        safeArea: EdgeInsets,
        percentageHeight: CGFloat
    ) {
        self._contentOffset = contentOffset
        self.size = size
        self.safeArea = safeArea
        self.percentageHeight = percentageHeight
        self.minHeight = safeArea.top + 60
    }
    
    var body: some View {
        ZStack {
            GeometryReader {
                let rect = $0.frame(in: .global)
                
                AsyncImage(url: URL(string: "https://picsum.photos/200/300")) { phase in
                    switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(
                                    width: rect.size.width + (52 - rect.width) * progress,
                                    height: rect.size.height + (52 - rect.height) * progress
                                )
                                .clipShape(.rect(cornerRadius: 12 * progress))
                                .offset(x: 52 * progress, y: (safeArea.top - 4) * progress)
                                .onChange(of: contentOffset) { oldValue, newValue in
                                    progress = min(max(-contentOffset / (size.height * percentageHeight - minHeight), 0), 1)
                                }
                        case .empty:
                            ProgressView()
                        case .failure(_):
                            EmptyView()
                        @unknown default:
                            Text("Load Failed")
                    }
                }
            }
            VStack(alignment: .leading) {
                Spacer()
                Text("Mohammad Afshar")
                    .font(.title.bold())
//                    .foregroundStyle()
                
                Text("Software Engineer")
//                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .scaleEffect(1 - 0.4 * progress, anchor: .leading)
            .offset(x: 100 * progress)
            .padding(.horizontal)
            .padding(.bottom, max(10 - progress * 100, 0))
        }
        .frame(height: height())
        .background(
            Rectangle()
                .fill(.ultraThinMaterial)
                .opacity(1 * progress)
        )
        .clipped()
    }
}

extension HeaderView {
    func height() -> CGFloat {
        size.height * percentageHeight + contentOffset < minHeight ? minHeight : size.height * percentageHeight + contentOffset
    }
}

#Preview {
    ContainerView()
}
