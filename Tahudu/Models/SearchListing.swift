//
//  SearchListing.swift
//  Tahudu
//

import SwiftUI

struct SearchListing: Identifiable {
    let id: String
    let carouselImageNames: [String]
    let tagLabels: [String]
    let location: String
    let propertyType: String
    let deliveryYear: Int
    let priceLine: String
    let unitLine: String
    let publishedLine: String
    let lastContactedLine: String?
    let contactOptions: [ContactType]
}

extension SearchListing {
    func tagBackgroundColor(for tag: String) -> Color {
        tag == AppStrings.verified ? .green : Color.black.opacity(Opacity.overlay)
    }
}
