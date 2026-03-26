//
//  SearchView.swift
//  Tahudu
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""

    private let mockListings: [SearchListing] = [
        SearchListing(
            id: "prop_001",
            carouselImageNames: ["FirstImage", "SecondImage"],
            tagLabels: ["Verified", "New Construction"],
            location: "Dubai",
            propertyType: "Apartment",
            deliveryYear: 2022,
            priceLine: "2,575,000 AED",
            unitLine: "Studio",
            publishedLine: "Published 3 days ago",
            lastContactedLine: "Last contacted: 28 Jul 2021",
            contactOptions: [.phone, .email, .sms]
        ),
        SearchListing(
            id: "prop_002",
            carouselImageNames: ["SecondImage", "FirstImage"],
            tagLabels: ["Verified", "New Construction"],
            location: "Dubai",
            propertyType: "Apartment",
            deliveryYear: 2023,
            priceLine: "1,850,000 AED",
            unitLine: "1 Beds",
            publishedLine: "Published 5 days ago",
            lastContactedLine: nil,
            contactOptions: [.phone, .email, .sms]
        ),
    ]

    var body: some View {
        VStack(spacing: 0) {
            searchHeader
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(mockListings) { listing in
                        PropertyListingCardView(
                            listing: listing,
                            onHeartTap: { print("Heart tapped — \(listing.id)") },
                            onPhoneTap: { print("Phone contact — \(listing.id)") },
                            onEmailTap: { print("Email contact — \(listing.id)") },
                            onWhatsAppTap: { print("WhatsApp contact — \(listing.id)") }
                        )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
            }
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
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
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .previewDisplayName("Search")
    }
}
