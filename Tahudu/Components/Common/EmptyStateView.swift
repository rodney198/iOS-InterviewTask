//
//  EmptyStateView.swift
//  Tahudu
//

import SwiftUI

struct EmptyStateView: View {
    let systemImage: String
    let title: String
    let message: String
    
    init(systemImage: String, title: String, message: String) {
        self.systemImage = systemImage
        self.title = title
        self.message = message
    }
    
    var body: some View {
        VStack(spacing: Spacing.md) {
            Image(systemName: systemImage)
                .font(FontSizes.largeTitle)
                .foregroundColor(.secondary)
            Text(title)
                .font(Typography.emptyStateTitle)
            Text(message)
                .font(Typography.emptyStateMessage)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(Spacing.xxl)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    EmptyStateView(
        systemImage: "building.2",
        title: Copy.noListings,
        message: Copy.noListingsMessage
    )
}
