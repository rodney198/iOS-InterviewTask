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
    
    /// Clears any current error message
    func clearError()
}

// MARK: - Default Implementation
extension BaseViewModel {
    func clearError() {
        // Default implementation - can be overridden by concrete ViewModels
    }
}

// MARK: - Reloadable ViewModel Protocol
protocol ReloadableViewModel: BaseViewModel {
    /// Refreshes the data from the source
    func refresh()
}
