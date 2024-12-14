//
//  SH3ContentView.swift
//  SwiftUIAnimations
//
//  Created by Mohammad Afshar on 14/12/2024.
//

import SwiftUI

struct SH3ContentView: View {
    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            let safeAreaInsets = geo.safeAreaInsets
            
            SHHome(size: size, safeArea: safeAreaInsets)
                .ignoresSafeArea(.all, edges: .top)
        }
    }
}

#Preview {
    SH3ContentView()
}
