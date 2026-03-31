//
//  APIManager.swift
//  Tahudu
//

import Foundation

enum APIError: Error {
    case invalidResponse
    case httpStatusError(code: Int)
    case decoding(Error)
    case underlying(URLError)
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response format"
        case let .httpStatusError(code):
            return "Request Failed HTTP status code: \(code)"
        case let .decoding(error):
            return "Failed to decode response: \(error.localizedDescription)"
        case let .underlying(urlError):
            return urlError.localizedDescription
        }
    }
}

protocol APIManagerProtocol {
    func request<T: Decodable>(_ url: URL, as type: T.Type) async throws -> T
}

final class APIManager: APIManagerProtocol {
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared, decoder: JSONDecoder? = nil) {
        self.session = session
        self.decoder = decoder ?? APIManager.makeListingDecoder()
    }
    
    static func makeListingDecoder() -> JSONDecoder {
        var decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
    
    func request<T: Decodable>(_ url: URL, as type: T.Type) async throws -> T {
        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await session.data(from: url)
        } catch let urlSessionError as URLError {
            throw APIError.underlying(urlSessionError)
        } catch {
            throw APIError.underlying(URLError(.cannotLoadFromNetwork))
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.httpStatusError(code: httpResponse.statusCode)
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.decoding(error)
        }
    }
}
