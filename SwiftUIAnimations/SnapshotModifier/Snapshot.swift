//
//  Snapshot.swift
//  SwiftUIAnimations
//
//  Created by Mohammad Afshar on 17/12/2024.
//

import SwiftUI

extension View {
    func snapshot(trigger: Bool, onComplete: @escaping (UIImage) -> ()) -> some View {
        self
            .modifier(SnapshotModifier(trigger: trigger, onComplete: onComplete))
    }
}

fileprivate struct SnapshotModifier: ViewModifier {
    @State private var view: UIView = .init(frame: .zero)
    var trigger: Bool
    var onComplete: (UIImage) -> ()
    
    func body(content: Content) -> some View {
        if #available(iOS 16, *) {
            content
                .background(ViewExtractor(view: view))
                .compositingGroup()
                .onChange(of: trigger) { oldValue, newValue in
                    generateSnapshot()
                }
        } else {
            content
                .background(ViewExtractor(view: view))
                .compositingGroup()
                .onChange(of: trigger) { trigger in
                    generateSnapshot()
                }
        }
    }
    
    private func generateSnapshot() {
        if let superView = view.superview?.superview {
            print(superView)
            let renderer = UIGraphicsImageRenderer(size: superView.bounds.size)
            let image = renderer.image { _ in
                superView.drawHierarchy(in: superView.bounds, afterScreenUpdates: true)
            }
            
            onComplete(image)
        }
    }
}

struct ViewExtractor: UIViewRepresentable {
    let view: UIView
    
    func makeUIView(context: Context) -> UIView {
        view.backgroundColor = .clear
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

#Preview {
    SContentView()
}
