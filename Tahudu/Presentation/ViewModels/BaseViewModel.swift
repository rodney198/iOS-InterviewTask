//
//  BaseViewModel.swift
//  Tahudu
//


// Base protocol for ViewModels in MVVM architecture
import Combine
import Foundation

// MARK: - Base ViewModel Protocol
protocol BaseViewModel: ObservableObject {
    /// Indicates if the ViewModel is currently loading data
    var isLoading: Bool { get }
    
    /// Contains any error message that should be displayed to the user
    var errorMessage: String? { get }
    
    /// Indicates if the ViewModel has an active error
    var hasError: Bool { get }
    
    /// Clears any current error message
    func clearError()
    
    /// Sets an error message
    func setError(_ message: String?)
}

// MARK: - Default Implementation
extension BaseViewModel {
    func clearError() {
        // Default implementation - should be overridden by concrete ViewModels
        // that have @Published errorMessage property
    }
    
    func setError(_ message: String?) {
        // Default implementation - should be overridden by concrete ViewModels
        // that have @Published errorMessage property
    }
    
    func setError(_ error: Error?) {
        if let error = error {
            setError(error.localizedDescription)
        } else {
            clearError()
        }
    }
    
    func setError(_ appError: AppError) {
        setError(appError.localizedDescription)
    }
    
    var hasError: Bool {
        errorMessage != nil
    }
    
    /// Indicates if the ViewModel is ready for user interaction
    var isReady: Bool {
        !isLoading && !hasError
    }
}

// MARK: - Reloadable ViewModel Protocol
protocol ReloadableViewModel: BaseViewModel {
    /// Refreshes the data from the source
    func refresh()
}
