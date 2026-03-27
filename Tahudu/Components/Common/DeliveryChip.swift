//
//  DeliveryChip.swift
//  Tahudu
//

import SwiftUI

struct DeliveryChip: View {
    let year: Int
    
    init(year: Int) {
        self.year = year
    }
    
    var body: some View {
        Text("\(AppStrings.delivery) \(String(year))")
            .font(Typography.metadata)
            .foregroundColor(Color.purple)
            .padding(.horizontal, Spacing.sm)
            .padding(.vertical, Spacing.xs)
            .background(Color.purple.opacity(Opacity.verifiedBackground))
            .clipShape(Capsule())
    }
}

#Preview {
    VStack(spacing: Spacing.sm) {
        DeliveryChip(year: 2022)
        DeliveryChip(year: 2023)
        DeliveryChip(year: 2024)
    }
    .padding()
}
