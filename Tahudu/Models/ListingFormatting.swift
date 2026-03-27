//
//  ListingFormatting.swift
//  Tahudu
//

import Foundation

enum ListingPresentation {
    private static let priceFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.groupingSeparator = ","
        f.maximumFractionDigits = 0
        return f
    }()

    private static let lastContactedFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "en_US_POSIX")
        f.dateFormat = "d MMM yyyy"
        return f
    }()

    private static let relativePublishedFormatter: RelativeDateTimeFormatter = {
        let f = RelativeDateTimeFormatter()
        f.unitsStyle = .full
        return f
    }()

    static func tagLabel(for raw: String) -> String {
        raw
            .replacingOccurrences(of: "_", with: " ")
            .uppercased()
    }
    
    /// Turns snake_case API keys into PascalCase asset names, e.g. `first_image` → `FirstImage`.
    /// If there is no `_`, the string is returned unchanged (e.g. already `FirstImage`).
    static func carouselAssetName(for raw: String) -> String {
        let trimmed = raw.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return raw }

        let segments = trimmed.split(separator: "_", omittingEmptySubsequences: true)
        guard !segments.isEmpty else { return raw }

        // Single segment and no underscore: assume it is already an asset/catalog name.
        if segments.count == 1, !trimmed.contains("_") {
            return String(segments[0])
        }

        return segments.map { segment -> String in
            let s = String(segment)
            guard let first = s.first else { return "" }
            return String(first).uppercased() + s.dropFirst().lowercased()
        }.joined()
    }

    static func priceLine(for listing: Listing) -> String {
        let num = priceFormatter.string(from: NSNumber(value: listing.price)) ?? "\(listing.price)"
        return "\(num) \(listing.currency)"
    }

    static func unitLine(bedrooms: Int?, bathrooms: Int, areaSqft: Int) -> String {
        let bedPart: String
        if let b = bedrooms {
            bedPart = "\(b) \(AppStrings.beds)"
        } else {
            bedPart = AppStrings.studio
        }
        return "\(bedPart) · \(bathrooms) \(AppStrings.bath) · \(areaSqft) \(AppStrings.sqft)"
    }

    static func publishedLine(for date: Date) -> String {
        let relative = relativePublishedFormatter.localizedString(for: date, relativeTo: Date())
        return "\(AppStrings.published) \(relative)"
    }

    static func lastContactedLine(for date: Date?) -> String? {
        guard let date else { return nil }
        return "\(AppStrings.lastContacted) \(lastContactedFormatter.string(from: date))"
    }
}

extension ContactType {
    init?(apiRawValue: String) {
        switch apiRawValue.lowercased() {
        case "phone":
            self = .phone
        case "email":
            self = .email
        case "whatsapp":
            self = .whatsApp
        default:
            return nil
        }
    }
}

extension SearchListing {
    init(listing: Listing) {
        let tagLabels = listing.tags.map(ListingPresentation.tagLabel(for:))
        let contactOptions = listing.contactOptions.compactMap(ContactType.init(apiRawValue:))
        let carouselNames = listing.images.map(ListingPresentation.carouselAssetName(for:))
        self.init(
            id: listing.id,
            carouselImageNames: carouselNames,
            tagLabels: tagLabels,
            location: listing.location,
            propertyType: listing.type,
            deliveryYear: listing.deliveryYear,
            priceLine: ListingPresentation.priceLine(for: listing),
            unitLine: ListingPresentation.unitLine(
                bedrooms: listing.bedrooms,
                bathrooms: listing.bathrooms,
                areaSqft: listing.areaSqft
            ),
            publishedLine: ListingPresentation.publishedLine(for: listing.publishedAt),
            lastContactedLine: ListingPresentation.lastContactedLine(for: listing.lastContactedAt),
            contactOptions: contactOptions
        )
    }
}
