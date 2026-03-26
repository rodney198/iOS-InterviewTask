//
//  PropertyListingCardView.swift
//  Tahudu
//

import SwiftUI

struct SearchListing: Identifiable {
    let id: String
    let carouselImageNames: [String]
    let tagLabels: [String]
    let location: String
    let propertyType: String
    let deliveryYear: Int
    let priceLine: String
    let unitLine: String
    let publishedLine: String
    let lastContactedLine: String?
    let contactOptions: [ContactType]
}

struct PropertyListingCardView: View {
    let listing: SearchListing
    let onHeartTap: () -> Void
    let onPhoneTap: () -> Void
    let onEmailTap: () -> Void
    let onWhatsAppTap: () -> Void
    let onSmsTap: () -> Void
    

    var body: some View {
        
        VStack(alignment: .leading) {
            carouselSection
            
            VStack(alignment: .leading, spacing: 12) {
                
                HStack(alignment: .center, spacing: 8) {
                    Text(listing.propertyType)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    deliveryChip
                }
                
                Text(listing.priceLine)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                
                HStack(spacing: 4) {
                    Image(systemName: "location.fill")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(listing.location)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                
                
                HStack(spacing: 4) {
                    Image(systemName: "bed.double.fill")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(listing.unitLine)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.top, 12)
            .padding(.bottom, 12)
            
                
                footerDivider
                
                HStack(alignment: .center, spacing: 12) {
                    Text(listing.publishedLine)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer(minLength: 8)
                    HStack(spacing: 12) {
                        ForEach(listing.contactOptions, id: \.self) {type in
                            contactButton(for: type)
                        }

                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 4)
                .padding(.bottom, listing.lastContactedLine == nil ? 16 : 10)
            

            if let line = listing.lastContactedLine {
                lastContactedBanner(text: line)
            }
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(UIColor.separator).opacity(0.35), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 4)
    }
    
    @ViewBuilder
    private func contactButton(for type: ContactType) -> some View {
        switch type {
        case .phone:
            ContactButton(.phone, action: onPhoneTap)
                .clipShape(Rectangle())
        case .email:
            ContactButton(.email, action: onEmailTap)
                .clipShape(Rectangle())
        case .whatsApp:
            ContactButton(.whatsApp, action: onWhatsAppTap)
                .clipShape(Rectangle())
        case .sms:
            ContactButton(.whatsApp, action: onSmsTap)
                .clipShape(Rectangle())
        }
    }

    private var footerDivider: some View {
        Rectangle()
            .fill(Color(UIColor.separator))
            .frame(height: 1)
            .frame(maxWidth: .infinity)
    }

    private var carouselSection: some View {
        ZStack(alignment: .top) {
            TabView {
                ForEach(listing.carouselImageNames, id: \.self) { name in
                    Image(name)
                        .resizable()
                        .scaledToFill()
                }
            }
            .frame(height: 200)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .clipped()

            HStack(alignment: .top) {
                ForEach(Array(listing.tagLabels.enumerated()), id: \.offset) { _, label in
                    tagPill(label)
                }
                Spacer(minLength: 0)
                heartButton
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(8)
        }
    }
    
    private func tagPill(_ text: String) -> some View {
        let isVerified = text == "VERIFIED"
        return HStack(spacing: 4) {
            Text(text)
                .font(.caption2)
                .fontWeight(.semibold)
        }
        .foregroundColor(.white)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(isVerified ? Color.green : Color.black.opacity(0.55))
        .clipShape(RoundedRectangle(cornerRadius: 4))
                        
    }

    private var verifiedPill: some View {
        Text("VERIFIED")
            .font(.caption2)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.green)
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }

    private var heartButton: some View {
        Button(action: onHeartTap) {
            Image(systemName: "heart")
                .font(.body.weight(.medium))
                .foregroundColor(.white)
                .frame(width: 36, height: 36)
                .background(Circle().fill(Color.black.opacity(0.35)))
        }
        .buttonStyle(.plain)
    }

    private var deliveryChip: some View {
        Text("Delivery: \(String(listing.deliveryYear))")
            .font(.caption)
            .foregroundColor(Color.purple)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.purple.opacity(0.12))
            .clipShape(Capsule())
    }

    private func lastContactedBanner(text: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: "phone.fill")
                .font(.caption)
            Text(text)
                .font(.caption)
        }
        .foregroundColor(.primary)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.yellow.opacity(0.45))
        .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

struct PropertyListingCardView_Previews: PreviewProvider {
    static var previews: some View {
        PropertyListingCardView(
            listing: SearchListing(
                id: "preview",
                carouselImageNames: ["FirstImage", "SecondImage"],
                tagLabels: ["Verified", "New Construction"],
                location: "Dubai",
                propertyType: "Apartment",
                deliveryYear: 2022,
                priceLine: "2,575,000 AED",
                unitLine: "Studio",
                publishedLine: "Published 3 days ago",
                lastContactedLine: "Last contacted: 28 Jul 2021",
                contactOptions: [.phone, .email, .sms]
            ),
            onHeartTap: {},
            onPhoneTap: {},
            onEmailTap: {},
            onWhatsAppTap: {},
            onSmsTap: {}
        )
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
