//
//  SContentView.swift
//  SwiftUIAnimations
//
//  Created by Mohammad Afshar on 17/12/2024.
//

import SwiftUI

struct SContentView: View {
    @State var trigger: Bool = false
    @State var snapshot: UIImage?
    
    var body: some View {
        if false {
            VStack(spacing: 25) {
                Button("Take Snapshot") {
                    trigger.toggle()
                }
                .buttonStyle(.borderedProminent)
                
                VStack {
                    Image(systemName: "person")
                        .font(.largeTitle)
                    Text("Hello, World!")
                        .font(.title3)
                }
                .foregroundStyle(.white)
                .padding()
                .background(.red.gradient, in: .rect(cornerRadius: 15))
                .snapshot(trigger: trigger) {
                    snapshot = $0
                }
                
                if let snapshot {
                    Image(uiImage: snapshot)
                        .aspectRatio(contentMode: .fit)
                        .shadow(radius: 10)
                }
            }
        } else {
            NavigationStack {
                List {
                    ForEach(1...25, id: \.self) {
                        Text("\($0)")
                    }
                }
//                .snapshot(trigger: trigger) { image in
//                    snapshot = image
//                }
                .navigationTitle("Snapshot")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Snapshot") {
                            trigger.toggle()
                        }
                    }
                }
            }
            .snapshot(trigger: trigger) { image in
                snapshot = image
            }
            .overlay {
                if let snapshot {
                    Image(uiImage: snapshot)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(15)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background {
                            Rectangle()
                                .fill(Color.black.opacity(0.5))
                                .ignoresSafeArea()
                                .onTapGesture {
                                    self.snapshot = nil
                                }
                        }
                }
            }
        }
    }
}

#Preview {
    SContentView()
}
