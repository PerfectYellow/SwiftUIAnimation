//
//  DSHome.swift
//  SwiftUIAnimations
//
//  Created by Mohammad Afshar on 30/12/2024.
//

import SwiftUI

struct DSHome: View {
    @State var showSheet: Bool = false
    @State var sheetHeight: CGFloat = .zero
    @State var sheetFirstPageHeight: CGFloat = .zero
    @State var sheetSecondPageHeight: CGFloat = .zero
    @State var sheetScrollProgress: CGFloat = .zero
    @State var emailAddress: String = ""
    @State var password: String = ""
    @State var alreadyHaveAccount: Bool = false
    @State var isKeyboardShowing: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            Button("Show Sheet") {
                showSheet.toggle()
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
        }
        .sheet(isPresented: $showSheet) {
            sheetHeight = .zero
            sheetFirstPageHeight = .zero
            sheetSecondPageHeight = .zero
            sheetScrollProgress = .zero
        } content: {
            GeometryReader { geometry in
                let size = geometry.size
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top, spacing: 0) {
                            OnBoarding(size)
                                .id("FirstPage")
                            
                            LoginView(size)
                                .id("SecondPage")
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.paging)
                    .scrollDisabled(isKeyboardShowing)
                    .overlay(alignment: .topTrailing) {
                        Button {
                            if sheetScrollProgress < 1 {
                                /// Continue Button
                                /// Moving to the Next Page (Using ScrollView Reader)
                                withAnimation(.snappy) {
                                    proxy.scrollTo("SecondPage", anchor: .leading)
                                }
                            } else {
                                /// Get Started Button
                                
                            }
                        } label: {
                            Text("Continue")
                                .fontWeight(.semibold)
                                .opacity(1 - sheetScrollProgress)
                                .frame(width: 120 + (sheetScrollProgress * (alreadyHaveAccount ? 0 : 50)))
                                .overlay {
                                    HStack(spacing: 8) {
                                        Text(alreadyHaveAccount ? "Login" : "Get Started")
                                        
                                        Image(systemName: "arrow.right")
                                    }
                                    .fontWeight(.semibold)
                                    .opacity(sheetScrollProgress)
                                }
                                .padding(.vertical, 12)
                                .foregroundStyle(.white)
                                .background(
                                    .linearGradient(
                                        colors: [.red, .orange],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ),
                                    in: .capsule
                                )
                        }
                        .padding(15)
                        .offset(y: sheetHeight - 100)
                        .offset(y: sheetScrollProgress * -120)
                    }
                }
            }
            .presentationCornerRadius(30)
            .presentationDetents(sheetHeight == .zero ? [.medium] : [.height(sheetHeight)])
            .interactiveDismissDisabled()
            .onReceive(
                NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            ) { _ in
                isKeyboardShowing = true
            }
            .onReceive(
                NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            ) { _ in
                isKeyboardShowing = false
            }
        }
    }
}

extension DSHome {
    @ViewBuilder
    func OnBoarding(_ size: CGSize) -> some View {
//        let _ = print("is \(size.height)")
        VStack(alignment: .leading, spacing: 12) {
            Text("SwiftUI Animations\nDynamic Sheet")
                .font(.largeTitle.bold())
                .lineLimit(2)
            
            Text(attributedSubtitle)
                .font(.callout)
                .foregroundStyle(.gray)
        }
        .padding(15)
        .padding(.horizontal, 10)
        .padding(.top, 15)
        .padding(.bottom, 130)
        .frame(width: size.width, alignment: .leading)
        .heightChangePreference { height in
//            Task { @MainActor in
                sheetFirstPageHeight = height
                sheetHeight = height
//            }
        }
    }
    
    var attributedSubtitle: AttributedString {
        let string = "This is a app about button Dynamic Sheet"
        var attributedString = AttributedString(stringLiteral: string)
        if let range = attributedString.range(of: "Dynamic Sheet") {
            attributedString[range].foregroundColor = .black
            attributedString[range].font = .callout.bold()
        }
        return attributedString
    }
    
    @ViewBuilder
    func LoginView(_ size: CGSize) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(alreadyHaveAccount ? "Login" : "Create an account")
                .font(.largeTitle.bold())
            
            DSCustomTextField(text: $emailAddress, hint: "Email Address", icon: "envelope")
                .padding(.top, 20)
            
            DSCustomTextField(text: $password, hint: "*****", icon: "lock", isPassword: true)
                .padding(.top, 20)
        }
        .padding(15)
        .padding(.horizontal, 10)
        .padding(.top, 15)
        .padding(.bottom, 220)
        .overlay(alignment: .bottom) {
            VStack(spacing: 15) {
                Group {
                    if alreadyHaveAccount {
                        HStack(spacing: 4) {
                            Text("Don't have an account?")
                                .foregroundStyle(.gray)
                            
                            Button("Create an account") {
                                withAnimation(.snappy) {
                                    alreadyHaveAccount.toggle()
                                }
                            }
                            .tint(.red)
                        }
                        .transition(.push(from: .bottom))
                    } else {
                        HStack(spacing: 4) {
                            Text("Already have an account?")
                                .foregroundStyle(.gray)
                            
                            Button("Login") {
                                withAnimation(.snappy) {
                                    alreadyHaveAccount.toggle()
                                }
                            }
                            .tint(.red)
                        }
                        .transition(.push(from: .top))
                    }
                }
                .font(.callout)
                .textScale(.secondary)
                .padding(.bottom, alreadyHaveAccount ? 0 : 15)
                
                if !alreadyHaveAccount {
                    Text("By signing up, you're agreeing to our **[Terms & Condition](https://apple.com)** and **[Privacy Policy](https://apple.com)**")
                        .font(.caption)
                        .tint(.red)
                        .foregroundStyle(.gray)
                        .transition(.offset(y: 100))
                }
            }
            .padding(.bottom, 15)
            .padding(.horizontal, 20)
            .multilineTextAlignment(.center)
            .frame(width: size.width)
        }
        .frame(width: size.width)
        .heightChangePreference { height in
            sheetSecondPageHeight = height
            let diff = sheetSecondPageHeight - sheetFirstPageHeight
            sheetHeight = sheetFirstPageHeight + (diff * sheetScrollProgress)
        }
        .minXChangePreference { minX in
            let diff = sheetSecondPageHeight - sheetFirstPageHeight 
            /// Truncating Minx between (0 to Screen Width)
            let truncatedMinx = min(size.width - minX, size.width)
            guard truncatedMinx > 0 else { return }
            /// Converting MinX to Progress (0 - 1)
            let progress = truncatedMinx / size.width
            sheetScrollProgress = progress
            sheetHeight = sheetFirstPageHeight + (diff * progress)
        }
    }
}

struct DSCustomTextField: View {
    @Binding var text: String
    var hint: String
    var icon: String
    var isPassword: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if isPassword {
                SecureField(hint, text: $text)
            } else {
                TextField(hint, text: $text)
            }
            
            Divider()
        }
        .overlay(alignment: .trailing) {
            Image(systemName: icon)
                .foregroundStyle(.gray)
        }
    }
}


#Preview {
    DSContentView()
}
