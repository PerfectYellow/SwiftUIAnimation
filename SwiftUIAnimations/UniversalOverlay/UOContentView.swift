//
//  UOContentView.swift
//  SwiftUIAnimations
//
//  Created by Mohammad Afshar on 15/12/2024.
//

import SwiftUI
import AVKit

struct UOContentView: View {
    @State private var show: Bool = false
    @State private var showSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Button("Floating Video Player") {
                    show.toggle()
                }
                .universalOverlay(show: $show) {
                    FloatingVideoPlayerView(
                        show: $show
                    )
                }
                
                Button("Show Dummy Sheet") {
                    showSheet.toggle()
                }
            }
            .navigationTitle("Universal Overlay")
        }
        .sheet(isPresented: $showSheet) {
            Text("Hello From Sheet")
        }
    }
}

struct FloatingVideoPlayerView: View {
    @Binding var show: Bool
    @State private var player: AVPlayer?
    @State private var offset: CGSize = .zero
    @State private var lastStoredOffset: CGSize = .zero
    
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            Group {
                VideoPlayer(player: player)
                    .background(.black)
                    .clipShape(.rect(cornerRadius: 25))
            }
            .frame(height: 250)
            .offset(offset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let translation = value.translation + lastStoredOffset
                        offset = translation
                    }
                    .onEnded { value in
                        withAnimation(.bouncy) {
                            /// Limiting to not move outside of screen
                            offset.width = 0
                            
                            if offset.height < 0 {
                                offset.height = 0
                            }
                            
                            if offset.height > (size.height - 250) {
                                offset.height = (size.height - 250)
                            }
                        }
                        lastStoredOffset = offset
                    }
            )
            .frame(maxWidth: .infinity, alignment: .top)
        }
        .padding(.horizontal, 15)
        .transition(.blurReplace)
        .onAppear {
            player = AVPlayer(url: URL(string: "https://videos.pexels.com/video-files/2795172/2795172-uhd_2560_1440_25fps.mp4")!)
            player?.play()
        }
    }
}

extension CGSize {
    static func +(lhs: CGSize, rhs: CGSize) -> CGSize {
        .init(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
}

#Preview {
    RootView {
        UOContentView()
    }
}
