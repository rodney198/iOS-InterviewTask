//
//  TagPillView.swift
//  Tahudu
//

import SwiftUI

struct TagPillView: View {
    let text: String
    let backgroundColor: Color
    
    init(text: String, backgroundColor: Color) {
        self.text = text
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        HStack(spacing: Spacing.xs) {
            Text(text)
                .font(Typography.tags)
                .fontWeight(FontWeights.semibold)
        }
        .foregroundColor(.white)
        .padding(.horizontal, Spacing.sm)
        .padding(.vertical, Spacing.xs)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: CornerRadius.small))
    }
}

#Preview {
    VStack(spacing: Spacing.sm) {
        TagPillView(text: "VERIFIED", backgroundColor: .green)
        TagPillView(text: "NEW CONSTRUCTION", backgroundColor: Color.black.opacity(Opacity.overlay))
        TagPillView(text: "LIVE VIEWING", backgroundColor: Color.black.opacity(Opacity.overlay))
    }
    .padding()
}
