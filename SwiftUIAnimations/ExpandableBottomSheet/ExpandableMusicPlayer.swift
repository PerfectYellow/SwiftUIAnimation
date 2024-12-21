//
//  ExpandableMusicPlayer.swift
//  SwiftUIAnimations
//
//  Created by Mohammad Afshar on 18/12/2024.
//

import SwiftUI

struct ExpandableMusicPlayer: View {
    @Binding var show: Bool
    @State private var expandPlayer: Bool = false
    @State private var offsetY: CGFloat = .zero
    @State private var mainWindow: UIWindow?
    @State private var windowProgress: CGFloat = .zero
    @Namespace private var animation
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            
            ZStack(alignment: .top) {
                ZStack {
                    Rectangle()
                        .fill(.gray.opacity(0.1))
                    
                    Rectangle()
                        .fill(
                            .linearGradient(
                                colors: [
                                    .yellow,
                                    .yellow.opacity(0.7),
                                    .yellow.opacity(0.5),
                                    .white.opacity(0.5),
                                    .white.opacity(0.9),
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .opacity(expandPlayer ? 1 : 0)
                }
                .clipShape(.rect(cornerRadius: expandPlayer ? 45 : 15))
                .frame(height: expandPlayer ? nil : 55)
//                .shadow(color: .primary.opacity(0.06), radius: 5, x: 5, y: 5)
//                .shadow(color: .primary.opacity(0.05), radius: 5, x: -5, y: -5)
                
                MiniPlayer()
                    .opacity(expandPlayer ? 0 : 1)
                
                ExpandedPlayer(size, safeAre: safeArea)
                    .opacity(expandPlayer ? 1 : 0)
            }
            .frame(height: expandPlayer ? nil : 55, alignment: .top)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, expandPlayer ? 0 : safeArea.bottom + 55)
            .padding(.horizontal, expandPlayer ? 0 : 15)
            .offset(y: offsetY)
            .gesture(
                PanGesture { value in
                    guard expandPlayer else { return }
                    
                    let translation = max(value.translation.height, 0)
                    offsetY = translation
                    windowProgress = max(min((translation / size.height), 1), 0)
                    resizeWindow(0.1 - windowProgress)
                } onEnd: { value in
                    guard expandPlayer else { return }
                    
                    let translation = max(value.translation.height, 0)
                    let velocity = value.velocity.height / 5
                    
                    withAnimation(.snappy(duration: 0.3, extraBounce: 0)) {
                        if (translation + velocity) > (size.height * 0.5) {
                            /// Closing view
                            expandPlayer = false
                            
                            /// Reseting view to identity with animation
                            resetWindowWithAnimation()
                        } else {
                            /// Reset window to 0.1 with animation
                            UIView.animate(withDuration: 0.3) {
                                resizeWindow(0.1)
                            }
                        }
                        
                        offsetY = 0
                    }
                }
            )
            .ignoresSafeArea()
            
//            Slider(value: $windowProgress, in: 0...0.1)
//                .padding(15)
//                .onChange(of: windowProgress) { oldValue, newValue in
//                    resizeWindow(newValue)
//                }
        }
        .onAppear {
            if let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow, mainWindow == nil {
                mainWindow = window
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
            print("Background")
        }
    }
    
    @ViewBuilder
    func MiniPlayer() -> some View {
        HStack(spacing: 12) {
            ZStack {
                if !expandPlayer {
                    Image(.imageB)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(.rect(cornerRadius: 10))
                        .matchedGeometryEffect(id: "artwork", in: animation)
                    
                }
            }
            .frame(width: 45, height: 45)
            
            Text("Calm Down")
                .padding(.leading)
            
            Spacer(minLength: 0)
            
            Group {
                Button("", systemImage: "play.fill") {
                    
                }
                
                Button("", systemImage: "forward.fill") {
                    
                }
            }
            .font(.title3)
            .foregroundStyle(.primary)
        }
        .padding(10)
        .frame(height: 55)
        .contentShape(.rect)
        .onTapGesture {
            withAnimation(.smooth) {
                self.expandPlayer = true
            }
            
            /// Resizing window when opening player
            UIView.animate(withDuration: 0.1) {
                resizeWindow(0.1)
            }
        }
    }
    
    @ViewBuilder
    func ExpandedPlayer(_ size: CGSize, safeAre: EdgeInsets) -> some View {
        VStack(spacing: 12) {
            Capsule()
                .fill(.white.secondary)
                .frame(width: 35, height: 5)
                .offset(y: -10)
                
            HStack(spacing: 12) {
                ZStack {
                    if expandPlayer {
                        Image(.imageB)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(.rect(cornerRadius: 10))
                            .matchedGeometryEffect(id: "artwork", in: animation)
                            .transition(.offset(y: 1))
                    }
                }
                .frame(width: 80, height: 80)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Calm Down")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                    
                    Text("Rema, Selena Gomez")
                        .font(.caption2)
                        .foregroundStyle(.white.secondary)
                }
                .padding(.leading)
                
                Spacer(minLength: 0)
                
                HStack(spacing: 0) {
                    Button("", systemImage: "star.circle.fill") {
                        
                    }
                    
                    Button("", systemImage: "ellipsis.circle.fill") {
                        
                    }
                }
                .foregroundStyle(.white)
                .font(.title2)
            }
        }
        .padding(15)
        .padding(.top, safeAre.top)
    }
    
    func resizeWindow(_ progress: CGFloat) {
        if let mainWindow = mainWindow?.subviews.first {
            let offsetY = (mainWindow.frame.height * progress) /  2
            
            mainWindow.layer.cornerRadius = (progress / 0.1) * 30
            mainWindow.layer.masksToBounds = true
            
            mainWindow.subviews.first?.transform = .identity.scaledBy(x: 1 - progress, y: 1 - progress)
        }
    }
    
    func resetWindowWithAnimation() {
        if let mainWindow = mainWindow?.subviews.first {
            mainWindow.layer.cornerRadius = 0
            mainWindow.transform = .identity
        }
    }
}


#Preview {
    RootView {
        MPContentView()
    }
}
