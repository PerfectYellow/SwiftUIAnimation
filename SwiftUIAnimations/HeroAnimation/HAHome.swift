//
//  HAHome.swift
//  SwiftUIAnimations
//
//  Created by Mohammad Afshar on 15/12/2024.
//

import SwiftUI

struct HAHome: View {
    @Binding var selectedProfile: ProfileModel?
    @Binding var pushedView: Bool
    
    var body: some View {
        List {
            ForEach(profileSample) { profile in
                Button {
                    selectedProfile = profile
                    pushedView.toggle()
                } label: {
                    HStack {
                        Color.clear
                            .frame(width: 60, height: 60)
                            /// Source View Anchor
                            .anchorPreference(key: HAAnchorKey.self, value: .bounds) { anchor in
                                print(anchor)
                                return [profile.id : anchor]
                            }
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(profile.userName)
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                            
                            Text(profile.lastMsg)
                                .font(.callout)
                                .textScale(.secondary)
                                .foregroundStyle(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(profile.lastActive)
                            .font(.caption)
                            .foregroundStyle(.gray)
                        
                    }
                    .contentShape(.rect)
                }
            }
        }
        .overlayPreferenceValue(HAAnchorKey.self) { value in
            GeometryReader { geometry in
                ForEach(profileSample) { profile in
                    /// Fetching Each Profile Image view using Profile ID
                    /// Hiding the current tapped view
                    if let anchor = value[profile.id], profile.id != selectedProfile?.id {
                        let rect = geometry[anchor]
                        HAImageView(profile: profile, size: rect.size)
                            .offset(x: rect.minX, y: rect.minY)
                            .allowsHitTesting(false)
                    }
                }
            }
        }
    }
}

struct HADetailsView: View {
    @Binding var selectedProfile: ProfileModel?
    @Binding var pushView: Bool
    @Binding var hideView: (Bool, Bool)
    
    var body: some View {
        if let selectedProfile {
            VStack {
                GeometryReader { geometry in
                    let size = geometry.size
                    
                    VStack {
                        if hideView.0 {
                            HAImageView(profile: selectedProfile, size: size)
                            // Custom Close Button
                                .overlay(alignment: .top) {
                                    ZStack {
                                        Button {
                                            /// Closing the view with animations
                                            hideView.0 = false
                                            hideView.1 = false
                                            pushView = false
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                                self.selectedProfile = nil
                                            }
                                        } label: {
                                            Image(systemName: "xmark")
                                                .foregroundStyle(.white)
                                                .padding(10)
                                                .background(.black, in: .circle)
                                                .contentShape(.circle)
                                        }
                                        .padding(15)
                                        .padding(.top, 40)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                        
                                        Text(selectedProfile.userName)
                                            .font(.title.bold())
                                            .foregroundStyle(.black)
                                            .padding()
                                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                                    }
                                    .opacity(hideView.0 ? 1 : 0)
                                    .animation(.snappy, value: hideView.1)
                                }
                        } else {
                            Color.clear
                        }
                    }
                    /// Destination View Anchor
                    .anchorPreference(key: HAAnchorKey.self, value: .bounds) { anchor in
                        return [selectedProfile.id : anchor]
                    }
                }
                .frame(height: 400)
                .ignoresSafeArea()
                
                Spacer(minLength: 0)
            }
//            .navigationBarBackButtonHidden(true)
            .toolbarVisibility(hideView.0 ? .hidden : .visible, for: .navigationBar)
            .onAppear {
//                Task {
//                    try await Task.sleep(for: .seconds(0.4))
//                    await MainActor.run {
//                        hideView.0 = true
//                    }
//                }
                /// Removing the animated view once the animation finished
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                    hideView.0 = true
                }
            }
        }
    }
}

struct HAImageView: View {
    var profile: ProfileModel
    var size: CGSize
    
    var body: some View {
        Image(profile.profilePicture)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size.width, height: size.height)
            .overlay {
                LinearGradient(
                    colors: [
                        .clear,
                        .clear,
                        .clear,
                        .white.opacity(0.1),
                        .white.opacity(0.5),
                        .white.opacity(0.9),
                        .white
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .opacity(size.width > 60 ? 1 : 0)
            }
            .clipShape(.rect(cornerRadius: size.width > 60 ? 0 : 30))
    }
}

#Preview {
    HAContentView()
}
