//
//  CLContentView.swift
//  SwiftUIAnimations
//
//  Created by Mohammad Afshar on 17/12/2024.
//

import SwiftUI

struct CLContentView: View {
    @State private var count: Int = 3
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVStack {
                    PickerView()
                    
                    CompositionalLayout(count: $count) {
                        ForEach(0..<50, id:\.self) { index in
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.pink.gradient)
                                .overlay {
                                    Text("\(index)")
                                        .font(.largeTitle.bold())
                                        .foregroundStyle(.white)
                                }
                        }
                    }
                    .animation(.bouncy, value: count)
                }
                .padding(15)
            }
            .navigationTitle("Compositional Grid")
        }
    }
    
    @ViewBuilder
    func PickerView() -> some View {
        Picker("", selection: $count) {
            ForEach(1...4, id:\.self) {
                Text("Count \($0)")
                    .tag($0)
            }
        }
        .pickerStyle(.segmented)
    }
}

#Preview {
    CLContentView()
}
