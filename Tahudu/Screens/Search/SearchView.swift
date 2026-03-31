//
//  SearchView.swift
//  Tahudu
//

import SwiftUI

private enum SearchListScrollAnchor {
    static let top = "searchListTop"
}

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
                } else if viewModel.showLoading {
                    LoadingView()
                } else if viewModel.showErrorWithNoListings {
                    Color.clear
                } else {
                    ScrollViewReader { proxy in
                        ScrollView {
                            LazyVStack(spacing: Spacing.lg) {
                                Color.clear
                                    .frame(height: 0)
                                    .id(SearchListScrollAnchor.top)

                                if let message = viewModel.noResultsMessage {
                                    Text(message)
                                        .font(Typography.emptyStateMessage)
                                        .multilineTextAlignment(.center)
                                        .frame(maxWidth: .infinity)
                                        .padding(.top, Spacing.xxl)
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
                            .padding(.horizontal, Spacing.lg)
                            .padding(.vertical, Spacing.lg)
                        }
                        .onChange(of: viewModel.showFavouritesOnly) { _ in
                            DispatchQueue.main.async {
                                withAnimation(.easeOut(duration: 0.2)) {
                                    proxy.scrollTo(SearchListScrollAnchor.top, anchor: .top)
                                }
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(SystemColors.groupedBackground.ignoresSafeArea())
            .onAppear { viewModel.refreshListings() }
        }
    }

    private var searchHeader: some View {
        VStack(spacing: Spacing.md) {
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
                ClearableTextField(
                    label: AppStrings.cityAreaBuildingPlaceholder,
                    symbol: "magnifyingglass",
                    text: $viewModel.searchText,
                    onClear: { viewModel.handleSearchClear() }
                )
                .disabled(!viewModel.isReady)
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
