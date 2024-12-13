//
//  ContentView.swift
//  SwiftUIAnimations
//
//  Created by Mohammad Afshar on 10/12/2024.
//

import SwiftUI

struct PlaceholderStackTextView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("SwiftUI: Building Beautiful Apps")
                .font(.largeTitle)
            
            Text("SwiftUI is a declarative framework introduced by Apple, making it easier than ever to build beautiful and responsive apps for iOS, macOS, watchOS, and tvOS. With its powerful and intuitive syntax, developers can create complex UIs with simple, readable code.")
            
            Text("History of SwiftUI")
                .font(.largeTitle)
            
            Text( "SwiftUI was introduced at WWDC 2019, marking a new era in iOS development. Designed to be interoperable with UIKit and AppKit, SwiftUI represents a major shift toward a more modern, cross-platform UI design approach.")
            
            Text("Why Use SwiftUI?")
                .font(.largeTitle)
            
            Text("SwiftUI brings a declarative approach to building UI, making it easy to read, maintain, and update. Its seamless integration with Swift allows developers to leverage powerful tools like Combine and Swift Concurrency to handle data flow and asynchronous programming with ease.")
            
            Text("In addition to simplifying UI code, SwiftUI introduces powerful preview features in Xcode, enabling developers to see changes in real-time as they code. This makes SwiftUI an essential tool for building fast, responsive, and visually appealing applications for all Apple platforms.")
        }
        .lineSpacing(6)
        .privacySensitive(true)
        .redacted(reason:.privacy)
    }
}

#Preview {
    ContainerView()
}
