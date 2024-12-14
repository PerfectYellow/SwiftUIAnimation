//
//  ScrollDetector.swift
//  SwiftUIAnimations
//
//  Created by Mohammad Afshar on 14/12/2024.
//

import SwiftUI

/// Extracting UIScrollview from SwiftUI ScrollView for monitoring offset and velocity
struct ScrollDetector: UIViewRepresentable {
    var onScroll: (CGFloat) -> ()
    /// Offset, Velocity
    var onDraggingEnd: (CGFloat, CGFloat) -> ()
    
    func makeUIView(context: Context) -> UIView {
        return UIView()
    }
    
//    @MainActor
    func updateUIView(_ uiView: UIViewType, context: Context) {
//        DispatchQueue.main.async {
        Task { //@MainActor in
            /// Background -> .background{} -> VStack{} -> ScrollView{}
            if let scrollView = uiView.superview?.superview?.superview as? UIScrollView {
                scrollView.delegate = context.coordinator
                context.coordinator.isDelegateAdded = true
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}

extension ScrollDetector {
    /// ScrollView Delegate Methods
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: ScrollDetector
        var isDelegateAdded: Bool = false
        
        init(parent: ScrollDetector) {
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.onScroll(scrollView.contentOffset.y)
        }
        
        func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            parent.onDraggingEnd(targetContentOffset.pointee.y, velocity.y)
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let velocity = scrollView.panGestureRecognizer.velocity(in: scrollView.panGestureRecognizer.view)
            parent.onDraggingEnd(scrollView.contentOffset.y, velocity.y)
        }
    }
}
