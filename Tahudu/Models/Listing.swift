//
//  Listing.swift
//  Tahudu
//
//  Created by Rodney Pinto on 27/03/26.
//

import Foundation

struct ListingResponse: Decodable {
    let listings: [Listing]
}


// MARK: - Listing
struct Listing: Decodable, Identifiable {
    let id: String
    let type: String
    let deliveryYear, price: Int
    let currency: String
    let priceInclusive: Bool
    let location: String
    let bedrooms: Int?
    let bathrooms, areaSqft: Int
    let publishedAt: Date
    let lastContactedAt: Date?
    let tags: [String]
    let images: [String]
    let contactOptions: [String]
}
