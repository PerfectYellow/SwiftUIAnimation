//
//  UniversalOverlay.swift
//  SwiftUIAnimations
//
//  Created by Mohammad Afshar on 15/12/2024.
//

import SwiftUI

struct RootView<Content: View>: View {
    var content: Content
    var properties = UniversalOverlayProperties()
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .environment(properties)
            .onAppear {
                if let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene), properties.window == nil {
                    let window = PassThroughWindow(windowScene: window)
                    window.isHidden = false
                    window.isUserInteractionEnabled = true
                    
                    let rootViewController = UIHostingController(
                        rootView: UniversalOverlayView().environment(
                            properties
                        )
                    )
                    rootViewController.view.backgroundColor = .clear
                    window.rootViewController = rootViewController
                    
                    properties.window = window
                }
            }
    }
}

@Observable
class UniversalOverlayProperties {
    var window: UIWindow?
    var views: [OverlayView] = []
    
    struct OverlayView: Identifiable {
        var id = UUID().uuidString
        var view: AnyView
    }
}

fileprivate class PassThroughWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let hitView = super.hitTest(point, with: event), let rootView = rootViewController?.view else {
            return nil
        }
        if #available(iOS 18, *) {
            for subview in rootView.subviews.reversed() {
                let pointInSubview = subview.convert(point, from: rootView)
                if subview.hitTest(pointInSubview, with: event) == subview {
                    return hitView
                }
            }
            
            return nil
        } else {
            return hitView == rootView ? nil : hitView
        }
    }
}

fileprivate struct UniversalOverlayModifier<ViewContent: View>: ViewModifier {
    var animation: Animation
    @Binding var show: Bool
    @ViewBuilder var viewContent: ViewContent
    /// Local View Properties
    @Environment(UniversalOverlayProperties.self) private var properties
    @State private var viewID: String?
    
    func body(content: Content) -> some View {
        content
            .onChange(of: show) { oldValue, newValue in
                if newValue {
                    addView()
                } else {
                    removeView()
                }
            }
    }
    
    private func addView() {
        if properties.window != nil, viewID == nil {
            viewID = UUID().uuidString
            guard let viewID else { return }
            
            withAnimation(animation) {
                properties.views.append(
                    .init(
                        id: viewID,
                        view: .init(viewContent)
                    )
                )
            }
        }
    }
    
    private func removeView() {
        withAnimation(animation) {
            properties.views.removeAll { $0.id == viewID }
        }
        self.viewID = nil
    }
}

extension View {
    @ViewBuilder
    public func universalOverlay<Content: View>(
        animation: Animation = .snappy,
        show: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self
            .modifier(
                UniversalOverlayModifier(
                    animation: animation,
                    show: show,
                    viewContent: content
                )
            )
    }
}

fileprivate struct UniversalOverlayView: View {
    @Environment(UniversalOverlayProperties.self) private var properties
    
    var body: some View {
        ZStack {
            ForEach(properties.views) {
                $0.view
            }
        }
    }
}

#Preview {
    RootView {
        UOContentView()
    }
}
