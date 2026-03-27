//
//  FontConstants.swift
//  Tahudu
//

//  Centralized typography constants
import SwiftUI

// MARK: - Font Sizes
struct FontSizes {
    static let caption2: Font = .caption2
    static let caption: Font = .caption
    static let headline: Font = .headline
    static let largeTitle: Font = .largeTitle
    static let title3: Font = .title3
    static let body: Font = .body
}

// MARK: - Font Weights
struct FontWeights {
    static let medium: Font.Weight = .medium
    static let semibold: Font.Weight = .semibold
    static let regular: Font.Weight = .regular
}

// MARK: - Typography Styles
struct Typography {
    static let tags = FontSizes.caption2.weight(FontWeights.semibold)
    static let price = FontSizes.headline
    static let metadata = FontSizes.caption
    static let location = FontSizes.caption
    static let published = FontSizes.caption
    static let buttons = FontSizes.title3
    static let emptyStateTitle = FontSizes.headline
    static let emptyStateMessage = FontSizes.caption
    static let errorMessage = FontSizes.caption
    static let retryButton = FontSizes.caption.weight(FontWeights.semibold)
    static let favouritesLabel = FontSizes.caption2.weight(FontWeights.medium)
}
