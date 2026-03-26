//
//  ListingAPIClient.swift
//  Tahudu
//

import Foundation

final class ListingAPIClient {
    private let apiManager: APIManagerProtocol
    private let baseURL = URL(string: "https://simplejsoncms.com/api/m6nfoc4jlw")!
    
    init(apiManager: APIManagerProtocol, baseURL: URL) {
        self.apiManager = apiManager
    }
    
    func fetchListings() async throws -> [Listing] {
        let responseData = try await apiManager.request(baseURL, as: ListingResponse.self)
        return responseData.listingData
    }
}

