//
//  PropertyListingCardViewModel.swift
//  Tahudu
//


import Foundation
import SwiftUI

@MainActor
final class PropertyListingCardViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var isFavourite: Bool
    
    // MARK: - Properties
    private let listing: SearchListing
    private let favouritesStore: FavouritesStore
    private let onContact: (String, ContactType) -> Void
    
    // MARK: - Computed Properties
    var tagLabels: [String] {
        listing.tagLabels
    }
    
    var carouselImageNames: [String] {
        listing.carouselImageNames
    }
    
    var propertyType: String {
        listing.propertyType
    }
    
    var deliveryYear: Int {
        listing.deliveryYear
    }
    
    var priceLine: String {
        listing.priceLine
    }
    
    var unitLine: String {
        listing.unitLine
    }
    
    var location: String {
        listing.location
    }
    
    var publishedLine: String {
        listing.publishedLine
    }
    
    var lastContactedLine: String? {
        listing.lastContactedLine
    }
    
    var contactOptions: [ContactType] {
        listing.contactOptions
    }
    
    // MARK: - Initialization
    init(listing: SearchListing,
         favouritesStore: FavouritesStore,
         onContact: @escaping (String, ContactType) -> Void) {
        self.listing = listing
        self.favouritesStore = favouritesStore
        self.onContact = onContact
        self.isFavourite = favouritesStore.isFavourite(id: listing.id)
    }
    
    // MARK: - Public Methods
    func toggleFavourite() {
        isFavourite.toggle()
        favouritesStore.toggle(id: listing.id)
    }
    
    func handleContact(type: ContactType) {
        onContact(listing.id, type)
    }
    
    // MARK: - Helper Methods
    func isVerifiedTag(_ tag: String) -> Bool {
        tag == AppStrings.verified
    }
    
    func tagBackgroundColor(for tag: String) -> Color {
        isVerifiedTag(tag) ? .green : Color.black.opacity(Opacity.overlay)
    }
}
