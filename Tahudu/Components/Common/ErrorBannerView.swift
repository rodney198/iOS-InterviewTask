//
//  ErrorBannerView.swift
//  Tahudu
//

import SwiftUI

struct ErrorBannerView: View {
    let message: String
    let onRetry: () -> Void
    
    init(message: String, onRetry: @escaping () -> Void) {
        self.message = message
        self.onRetry = onRetry
    }
    
    var body: some View {
        VStack(spacing: Spacing.sm) {
            Text(message)
                .font(Typography.errorMessage)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Spacing.sm)
            Button(AppStrings.retry) {
                onRetry()
            }
            .font(Typography.retryButton)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Spacing.sm)
        .background(Color.error.opacity(Opacity.errorBackground))
    }
}

#Preview {
    VStack(spacing: Spacing.lg) {
        ErrorBannerView(message: "Network error occurred") {
            print("Retry tapped")
        }
        
        ErrorBannerView(message: "Failed to load listings") {
            print("Retry tapped")
        }
    }
    .padding()
}
