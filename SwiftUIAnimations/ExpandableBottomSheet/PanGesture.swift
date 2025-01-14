//
//  PanGesture.swift
//  SwiftUIAnimations
//
//  Created by Mohammad Afshar on 21/12/2024.
//

import SwiftUI

struct PanGesture: UIGestureRecognizerRepresentable {
    var onChange: (Value) -> ()
    var onEnd: (Value) -> Void
    
    func makeUIGestureRecognizer(context: Context) -> UIPanGestureRecognizer {
        let gesture = UIPanGestureRecognizer()
        return gesture
    }
    
    func updateUIGestureRecognizer(_ recognizer: UIPanGestureRecognizer, context: Context) {
        
    }
    
    func handleUIGestureRecognizerAction(_ recognizer: UIGestureRecognizerType, context: Context) {
        let state = recognizer.state
        let transition = recognizer.translation(in: recognizer.view).toSize()
        let velocity = recognizer.velocity(in: recognizer.view).toSize()
        let value = Value(translation: transition, velocity: velocity)
        
        if state == .began || state == .changed {
            onChange(value)
        } else {
            onEnd(value)
        }
    }
    
    struct Value {
        var translation: CGSize
        var velocity: CGSize
    }
}

extension CGPoint {
    func toSize() -> CGSize {
        .init(width: x, height: y)
    }
}
