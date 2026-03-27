//
//  LoadingView.swift
//  Tahudu
//

import SwiftUI

struct LoadingView: View {
    let scale: CGFloat
    
    init(scale: CGFloat = 1.2) {
        self.scale = scale
    }
    
    var body: some View {
        ProgressView()
            .scaleEffect(scale)
    }
}

#Preview {
    VStack(spacing: Spacing.lg) {
        LoadingView()
        LoadingView(scale: 1.5)
        LoadingView(scale: 0.8)
    }
    .padding()
}
