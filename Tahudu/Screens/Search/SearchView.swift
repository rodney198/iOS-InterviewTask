//
//  SearchView.swift
//  Tahudu
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel: SearchViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: SearchViewModel())
    }
    

    var body: some View {
        VStack(spacing: 0) {
            searchHeader
            
            if let message = viewModel.errorMessage {
                errorBanner(message)
            }
            ZStack {
                if viewModel.showEmptyState {
                    VStack(spacing: 12) {
                        Image(systemName: "building.2")
                            .font(.largeTitle)
                            .foregroundColor(.secondary)
                        Text(Copy.noListings)
                            .font(Typography.emptyStateTitle)
                        Text(Copy.noListingsMessage)
                            .font(Typography.emptyStateMessage)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(24)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            if let message = viewModel.noResultsMessage {
                                Text(message)
                                    .font(Typography.emptyStateMessage)
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity)
                                    .padding(.top, 24)
                            }
                            
                            ForEach(viewModel.visibleListings) { listing in
                                PropertyListingCardView(
                                    listing: listing,
                                    viewModel: PropertyListingCardViewModel(
                                        listing: listing,
                                        favouritesStore: viewModel.favouritesStore,
                                        onContact: { listingId, type in
                                            viewModel.handleContact(listingId: listingId, type: type)
                                        }
                                    )
                                )
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                    }
                }
                
                if viewModel.showLoading {
                    ProgressView()
                        .scaleEffect(1.2)
                }
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            .onAppear { viewModel.refreshListings() }
        }
    }

    private var searchHeader: some View {
        VStack(spacing: 12) {
            HStack(spacing: 16) {
                Button {
                    viewModel.handleFilterTap()
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .font(Typography.buttons)
                }
                .buttonStyle(.plain)

                Button {
                    viewModel.handleSortTap()
                } label: {
                    Image(systemName: "arrow.up.arrow.down")
                        .font(Typography.buttons)
                }
                .buttonStyle(.plain)

                Spacer(minLength: 0)

            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    viewModel.showFavouritesOnly.toggle()
                }
            } label: {
                Image(systemName: viewModel.showFavouritesOnly ? "star.fill" : "star")
                    .font(Typography.buttons)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(viewModel.showFavouritesOnly ? Accessibility.showAllListings : Accessibility.showOnlyFavourites)
        }
        .foregroundColor(.accentColor)
        
        if viewModel.showFavouritesOnly {
            Text(Copy.showingFavouritesOnly)
                .font(Typography.favouritesLabel)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }

            ClearableTextField(
                label: Copy.cityAreaBuildingPlaceholder,
                symbol: "magnifyingglass",
                text: $viewModel.searchText,
                onClear: { viewModel.handleSearchClear() }
            )
        }
        .padding(.horizontal, Spacing.lg)
        .padding(.top, Spacing.sm)
        .padding(.bottom, Spacing.md)
        .background(Color(.systemBackground))
    }
        
    private func errorBanner(_ message: String) -> some View {
        VStack(spacing: Spacing.sm) {
            Text(message)
                .font(Typography.errorMessage)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Spacing.sm)
            Button(Copy.retry) {
                viewModel.retryLoadListings()
            }
            .font(Typography.retryButton)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Spacing.sm)
        .background(Color.red.opacity(Opacity.errorBackground))
    }
        
        
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .previewDisplayName("Search")
    }
}
