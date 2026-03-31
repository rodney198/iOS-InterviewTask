//
//  SearchView.swift
//  Tahudu
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel: SearchViewModel
    
    init(favouritesStore: FavouritesStore) {
        _viewModel = StateObject(wrappedValue: SearchViewModel(favouritesStore: favouritesStore))
    }
    
    // MARK: - Performance Notes
    // - @StateObject keeps SearchViewModel alive for the screen; FavouritesStore is owned above (tab) and injected.

    var body: some View {
        VStack(spacing: 0) {
            searchHeader
            
            if let message = viewModel.errorMessage {
                ErrorBannerView(message: message, onRetry: {
                    viewModel.retryLoadListings()
                })
            }
            ZStack {
                if viewModel.showEmptyState {
                    EmptyStateView(
                        systemImage: "building.2",
                        title: AppStrings.noListings,
                        message: AppStrings.noListingsMessage
                    )
                } else if !viewModel.isReady {
                    LoadingView()
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
                                    favouritesStore: viewModel.favouritesStore,
                                    onContact: { listingId, type in
                                        viewModel.handleContact(listingId: listingId, type: type)
                                    }
                                )
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                    }
                }
                
                if viewModel.showLoading {
                    LoadingView()
                }
            }
            .background(SystemColors.groupedBackground.ignoresSafeArea())
            .onAppear { viewModel.refreshListings() }
        }
    }

    private var searchHeader: some View {
        VStack(spacing: 12) {
            HStack(spacing: Spacing.md) {
                FilterButton(systemName: "line.3.horizontal.decrease.circle") {
                    viewModel.handleFilterTap()
                }

                FilterButton(systemName: "arrow.up.arrow.down") {
                    viewModel.handleSortTap()
                }

                Spacer(minLength: 0)

            FilterButton(
                systemName: viewModel.showFavouritesOnly ? "star.fill" : "star"
            ) {
                withAnimation(.easeInOut(duration: 0.2)) {
                    viewModel.showFavouritesOnly.toggle()
                }
            }
            .accessibilityLabel(viewModel.showFavouritesOnly ? Accessibility.showAllListings : Accessibility.showOnlyFavourites)
        }
        .foregroundColor(.accentColor)
        
        if viewModel.showFavouritesOnly {
            Text(AppStrings.showingFavouritesOnly)
                .font(Typography.favouritesLabel)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }

            HStack {
                if viewModel.isReady {
                    ClearableTextField(
                        label: AppStrings.cityAreaBuildingPlaceholder,
                        symbol: "magnifyingglass",
                        text: $viewModel.searchText,
                        onClear: { viewModel.handleSearchClear() }
                    )
                } else {
                    ClearableTextField(
                        label: AppStrings.cityAreaBuildingPlaceholder,
                        symbol: "magnifyingglass",
                        text: $viewModel.searchText,
                        onClear: { viewModel.handleSearchClear() }
                    )
                    .disabled(true)
                }
            }
        }
        .padding(.horizontal, Spacing.lg)
        .padding(.top, Spacing.sm)
        .padding(.bottom, Spacing.md)
        .background(SystemColors.background)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(favouritesStore: FavouritesStore())
            .previewDisplayName("Search")
    }
}
