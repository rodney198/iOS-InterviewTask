//
//  ListingsManager.swift
//  Tahudu
//

import Combine
import Foundation

/// Uses Combine only for `@Published` / `ObservableObject` (SwiftUI). Loading uses `async` / `await`.
final class ListingsManager: ObservableObject, BaseViewModel {
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
        fetchTask = Task { @MainActor in
            isLoading = true
            errorMessage = nil

            defer { isLoading = false }

            do {
                let records = try await client.fetchListings()
                guard !Task.isCancelled else { return }
                listings = records.map(SearchListing.init(listing:))
            } catch is CancellationError {
                return
            } catch let error as APIError {
                guard !Task.isCancelled else { return }
                errorMessage = error.localizedDescription
            } catch {
                guard !Task.isCancelled else { return }
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func clearError() {
        errorMessage = nil
    }
}
