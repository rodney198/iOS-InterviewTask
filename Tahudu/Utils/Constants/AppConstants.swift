//
//  AppConstants.swift
//  Tahudu
//

//  Centralized application constants
import Foundation

// MARK: - API
struct API {
    static let listingsEndpoint = "https://simplejsoncms.com/api/m6nfoc4jlw"
}

// MARK: - Storage Keys
struct StorageKeys {
    static let favouriteListingIDs = "com.tahudu.favouriteListingIDs"
}

// MARK: - Accessibility
struct Accessibility {
    static let showAllListings = "Show all listings"
    static let showOnlyFavourites = "Show only favourites"
    static let removeFromFavourite = "Remove from Favourite"
    static let addToFavourite = "Add to Favourite"
    static let filter = "Filter"
    static let sort = "Sort"
}

// MARK: - Copy Text
struct Copy {
    static let noListings = "No listings"
    static let noListingsMessage = "Pull down to refresh or check your connection."
    static let noFavourites = "No favourites yet. Tap the heart on a listing to save it here."
    static let noFavouritesInList = "None of your favourites are in this list."
    static let noSearchResults = "No matches for your search."
    static let noFavouritesSearchResults = "No favourites match your search."
    static let showingFavouritesOnly = "Showing favourites only"
    static let cityAreaBuildingPlaceholder = "City, area or building"
    static let retry = "Retry"
    static let delivery = "Delivery:"
    static let lastContacted = "Last contacted:"
    static let published = "Published"
    static let studio = "Studio"
    static let beds = "Beds"
    static let bath = "bath"
    static let sqft = "sqft"
    static let verified = "VERIFIED"
    static let newConstruction = "NEW CONSTRUCTION"
    static let liveViewing = "LIVE VIEWING"
}
