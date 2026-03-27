//
//  SearchView.swift
//  Tahudu
//

import SwiftUI

struct SearchView: View {
    @StateObject private var listingManager = ListingsManager()
    @StateObject private var favouritesStore = FavouritesStore()
    @State private var searchText = ""
    @State private var showFavouritesOnly = false
    
    private var trimmedSearch: String {
        searchText.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var listingsAfterFavouritesFilter: [SearchListing] {
        if showFavouritesOnly {
            return listingManager.listings.filter { favouritesStore.isFavourite(id: $0.id) }
        }
        return listingManager.listings
    }

    private var visibleListings: [SearchListing]  {
        let base = listingsAfterFavouritesFilter
         let q = trimmedSearch
         guard !q.isEmpty else { return base }
         return base.filter { $0.location.localizedStandardContains(q) }
     }

    private var noResultsMessage: String? {
        guard !listingManager.listings.isEmpty, visibleListings.isEmpty else { return nil }
        if showFavouritesOnly {
            if !trimmedSearch.isEmpty {
                return "No favourites match your search."
            }
            if favouritesStore.favouriteIDs.isEmpty {
                return "No favourites yet. Tap the heart on a listing to save it here."
            }
            return "None of your favourites are in this list."
        }
        if !trimmedSearch.isEmpty {
            return "No matches for your search."
        }
        return nil
    }

    var body: some View {
        VStack(spacing: 0) {
            searchHeader
            
            if let message = listingManager.errorMessage {
                errorBanner(message)
            }
            ZStack {
                if !listingManager.isLoading, listingManager.listings.isEmpty, listingManager.errorMessage == nil {
                    VStack(spacing: 12) {
                        Image(systemName: "building.2")
                            .font(.largeTitle)
                            .foregroundColor(.secondary)
                        Text("No listings")
                            .font(.headline)
                        Text("Pull down to refresh or check your connection.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(24)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            if let message = noResultsMessage {
                                Text(message)
                                    .font(.caption)
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity)
                                    .padding(.top, 24)
                            }
                            
                            ForEach(visibleListings) { listing in
                                PropertyListingCardView(
                                    listing: listing,
                                    isFavourite: favouritesStore.isFavourite(id: listing.id),
                                    onHeartTap: {
                                        withAnimation(.spring(response: 0.32, dampingFraction: 0.65)) {
                                            favouritesStore.toggle(id: listing.id)
                                        }
                                    },
                                    onPhoneTap: { print("Phone contact — \(listing.id)") },
                                    onEmailTap: { print("Email contact — \(listing.id)") },
                                    onWhatsAppTap: { print("WhatsApp contact — \(listing.id)") }, onSmsTap: { print("SMS contact — \(listing.id)")}
                                )
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                    }
                }
                
                if listingManager.isLoading, listingManager.listings.isEmpty {
                    ProgressView()
                        .scaleEffect(1.2)
                }
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            .onAppear { listingManager.refreshListings() }
        }
    }

    private var searchHeader: some View {
        VStack(spacing: 12) {
            HStack(spacing: 16) {
                Button {
                    print("Filter tapped")
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .font(.title3)
                }
                .buttonStyle(.plain)

                Button {
                    print("Sort tapped")
                } label: {
                    Image(systemName: "arrow.up.arrow.down")
                        .font(.title3)
                }
                .buttonStyle(.plain)

                Spacer(minLength: 0)

            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    showFavouritesOnly.toggle()
                }
            } label: {
                Image(systemName: showFavouritesOnly ? "star.fill" : "star")
                    .font(.title3)
                //  .fontWeight(showFavouritesOnly ? .semibold : .regular)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(showFavouritesOnly ? "Show all listings" : "Show only favourites")
        }
        .foregroundColor(.accentColor)
        
        if showFavouritesOnly {
            Text("Showing favourites only")
                .font(.caption2.weight(.medium))
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }

            ClearableTextField(
                label: "City, area or building",
                symbol: "magnifyingglass",
                text: $searchText,
                onClear: { print("Search field cleared") }
            )
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
        .padding(.bottom, 12)
        .background(Color(.systemBackground))
    }
        
    private func errorBanner(_ message: String) -> some View {
        VStack(spacing: 8) {
            Text(message)
                .font(.caption)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 12)
            Button("Retry") {
                listingManager.refreshListings()
            }
            .font(.caption.weight(.semibold))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color.red.opacity(0.12))
    }
        
        
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .previewDisplayName("Search")
    }
}
