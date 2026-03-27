//
//  FavouritesStore.swift
//  Tahudu
//

import Combine
import Foundation

@MainActor
final class FavouritesStore: ObservableObject {
    @Published private(set) var favouriteIDs: Set<String>

    private let userDefaults: UserDefaults
    private let storageKey = "com.tahudu.favouriteListingIDs"

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        if let stored = userDefaults.array(forKey: storageKey) as? [String] {
            favouriteIDs = Set(stored)
        } else {
            favouriteIDs = []
        }
    }

    func isFavourite(id: String) -> Bool {
        favouriteIDs.contains(id)
    }

    func toggle(id: String) {
        if favouriteIDs.contains(id) {
            favouriteIDs.remove(id)
        } else {
            favouriteIDs.insert(id)
        }
        persist()
    }

    private func persist() {
        userDefaults.set(Array(favouriteIDs.sorted()), forKey: storageKey)
    }
}
