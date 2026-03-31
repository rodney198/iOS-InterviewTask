//
//  AppError.swift
//  Tahudu
//

import Foundation

/// Centralized error types for the application
enum AppError: LocalizedError {
    case networkError(String)
    case dataParsingError
    case validationError(String)
    case unknownError(String)
    
    var errorDescription: String? {
        switch self {
        case .networkError(let message):
            return "Network Error: \(message)"
        case .dataParsingError:
            return "Failed to parse data from server"
        case .validationError(let message):
            return "Validation Error: \(message)"
        case .unknownError(let message):
            return "An unexpected error occurred: \(message)"
        }
    }
    
}
