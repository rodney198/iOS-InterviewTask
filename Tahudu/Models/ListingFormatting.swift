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

    static func priceLine(for listing: Listing) -> String {
        let num = priceFormatter.string(from: NSNumber(value: listing.price)) ?? "\(listing.price)"
        return "\(num) \(listing.currency)"
    }

    static func unitLine(bedrooms: Int?, bathrooms: Int, areaSqft: Int) -> String {
        let bedPart: String
        if let b = bedrooms {
            bedPart = "\(b) Beds"
        } else {
            bedPart = "Studio"
        }
        return "\(bedPart) · \(bathrooms) bath · \(areaSqft) sqft"
    }

    static func publishedLine(for date: Date) -> String {
        let relative = relativePublishedFormatter.localizedString(for: date, relativeTo: Date())
        return "Published \(relative)"
    }

    static func lastContactedLine(for date: Date?) -> String? {
        guard let date else { return nil }
        return "Last contacted: \(lastContactedFormatter.string(from: date))"
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
        self.init(
            id: listing.id,
            carouselImageNames: listing.images,
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
