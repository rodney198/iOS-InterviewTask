//
//  DesignConstants.swift
//  Tahudu
//

//  Centralized design system constants for spacing, sizing, and styling
import SwiftUI

// MARK: - Spacing
struct Spacing {
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let lg: CGFloat = 16
    static let xl: CGFloat = 20
    static let xxl: CGFloat = 24
}

// MARK: - Corner Radius
struct CornerRadius {
    static let small: CGFloat = 4
    static let medium: CGFloat = 8
    static let large: CGFloat = 12
    static let round: CGFloat = 50
}

// MARK: - Sizing
struct Sizing {
    static let buttonHeight: CGFloat = 36
    static let carouselHeight: CGFloat = 200
    static let heartButtonSize: CGFloat = 36
    static let iconSize: CGFloat = 24
}

// MARK: - Shadow
struct Shadow {
    static let card = Color.black.opacity(0.06)
    static let cardRadius: CGFloat = 8
    static let cardOffset = CGSize(width: 0, height: 4)
}

// MARK: - Opacity
struct Opacity {
    static let disabled: CGFloat = 0.25
    static let separator: CGFloat = 0.35
    static let overlay: CGFloat = 0.55
    static let verifiedBackground: CGFloat = 0.12
    static let contactBanner: CGFloat = 0.45
    static let errorBackground: CGFloat = 0.12
    static let heartBackground: CGFloat = 0.35
}

// MARK: - System Colors
struct SystemColors {
    static let background = Color(.systemBackground)
    static let groupedBackground = Color(.systemGroupedBackground)
    static let separator = Color(UIColor.separator)
}

// MARK: - Divider
struct Divider {
    static let height: CGFloat = 1
}

// MARK: - Stroke
struct Stroke {
    static let width: CGFloat = 1
}
