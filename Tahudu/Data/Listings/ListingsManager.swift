//
//  ListingsManager.swift
//  Tahudu
//

import Combine
import Foundation

/// Fetches listings and publishes state consumed by SearchViewModel (data layer, not a screen ViewModel).
final class ListingsManager: ObservableObject {
    @Published private(set) var listings: [SearchListing] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    private let client: ListingAPIClient
    private var fetchTask: Task<Void, Never>?

    init(client: ListingAPIClient = ListingAPIClient()) {
        self.client = client
    }

    func refreshListings() {
        fetchTask?.cancel()
        isLoading = true
        errorMessage = nil
        fetchTask = Task { @MainActor in
            defer { isLoading = false }

            do {
                let records = try await client.fetchListings()
                guard !Task.isCancelled else { return }
                listings = records.map(SearchListing.init(listing:))
            } catch is CancellationError {
                return
            } catch let error as APIError {
                guard !Task.isCancelled else { return }
                setError(AppError.networkError(error.localizedDescription))
            } catch {
                guard !Task.isCancelled else { return }
                setError(AppError.unknownError(error.localizedDescription))
            }
        }
    }
    
    func clearError() {
        errorMessage = nil
    }
    
    func setError(_ message: String?) {
        errorMessage = message
    }
    
    func setError(_ appError: AppError) {
        errorMessage = appError.localizedDescription
    }
}
