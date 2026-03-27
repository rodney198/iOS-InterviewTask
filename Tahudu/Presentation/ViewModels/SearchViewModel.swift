//
//  SearchViewModel.swift
//  Tahudu
//


import Combine
import Foundation
import SwiftUI

@MainActor
final class SearchViewModel: ObservableObject, BaseViewModel {
    
    // MARK: - Published Properties
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?
    @Published var searchText = ""
    @Published var showFavouritesOnly = false
    
    // MARK: - Dependencies
    private let listingsManager: ListingsManager
    let favouritesStore: FavouritesStore
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Computed Properties
    private var trimmedSearch: String {
        searchText.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var visibleListings: [SearchListing] {
        let base = listingsAfterFavouritesFilter
        let q = trimmedSearch
        guard !q.isEmpty else { return base }
        return base.filter { $0.location.localizedStandardContains(q) }
    }
    
    private var listingsAfterFavouritesFilter: [SearchListing] {
        if showFavouritesOnly {
            return listingsManager.listings.filter { favouritesStore.isFavourite(id: $0.id) }
        }
        return listingsManager.listings
    }
    
    var noResultsMessage: String? {
        guard !listingsManager.listings.isEmpty, visibleListings.isEmpty else { return nil }
        if showFavouritesOnly {
            if !trimmedSearch.isEmpty {
                return Copy.noFavouritesSearchResults
            }
            if favouritesStore.favouriteIDs.isEmpty {
                return Copy.noFavourites
            }
            return Copy.noFavouritesInList
        }
        if !trimmedSearch.isEmpty {
            return Copy.noSearchResults
        }
        return nil
    }
    
    var showEmptyState: Bool {
        !listingsManager.isLoading && 
        listingsManager.listings.isEmpty && 
        listingsManager.errorMessage == nil
    }
    
    var showLoading: Bool {
        listingsManager.isLoading && listingsManager.listings.isEmpty
    }
    
    // MARK: - Initialization
    init(listingsManager: ListingsManager = ListingsManager(), 
         favouritesStore: FavouritesStore? = nil) {
        self.listingsManager = listingsManager
        self.favouritesStore = favouritesStore ?? FavouritesStore()
        
        // Subscribe to listings manager updates
        listingsManager.objectWillChange
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
        
        // Subscribe to favourites store updates
        favouritesStore?.objectWillChange
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Public Methods
    func refreshListings() {
        listingsManager.refreshListings()
    }
    
    func toggleFavourite(for listingId: String) {
        favouritesStore.toggle(id: listingId)
    }
    
    func isFavourite(_ listingId: String) -> Bool {
        favouritesStore.isFavourite(id: listingId)
    }
    
    func handleFilterTap() {
        print("Filter tapped")
    }
    
    func handleSortTap() {
        print("Sort tapped")
    }
    
    func handleSearchClear() {
        print("Search field cleared")
    }
    
    func handleContact(listingId: String, type: ContactType) {
        switch type {
        case .phone:
            print("Phone contact — \(listingId)")
        case .email:
            print("Email contact — \(listingId)")
        case .whatsApp:
            print("WhatsApp contact — \(listingId)")
        case .sms:
            print("SMS contact — \(listingId)")
        }
    }
    
    func clearError() {
        errorMessage = nil
    }
    
    func retryLoadListings() {
        refreshListings()
    }
}
