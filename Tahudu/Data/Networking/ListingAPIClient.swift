//
//  ListingAPIClient.swift
//  Tahudu
//

import Foundation

final class ListingAPIClient {
    private let apiManager: APIManagerProtocol
    private let baseURL = URL(string: API.listingsEndpoint)!
    
    init(apiManager: APIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    func fetchListings() async throws -> [Listing] {
        let responseData = try await apiManager.request(baseURL, as: ListingResponse.self)
        return responseData.listings
    }
}
