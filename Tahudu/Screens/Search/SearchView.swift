//
//  SearchView.swift
//  Tahudu
//

import SwiftUI

struct SearchView: View {
    @StateObject private var listingManager = ListingsManager()
    @State private var searchText = ""

    private var visibleListings: [SearchListing]  {
        let q = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !q.isEmpty else { return listingManager.listings }
        return listingManager.listings.filter {
            $0.location.localizedStandardContains(q)
        }
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
                            if visibleListings.isEmpty, !listingManager.listings.isEmpty {
                                Text("No matches for your search found")
                                    .font(.caption)
                                    .frame(maxWidth: .infinity)
                                    .padding(.top, 24)
                            }
                            
                            ForEach(visibleListings) { listing in
                                PropertyListingCardView(
                                    listing: listing,
                                    onHeartTap: { print("Heart tapped — \(listing.id)") },
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
                    print("Favourites tapped")
                } label: {
                    Image(systemName: "star")
                        .font(.title3)
                }
                .buttonStyle(.plain)
            }
            .foregroundColor(.accentColor)

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
