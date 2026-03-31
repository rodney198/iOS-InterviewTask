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
    @StateObject private var viewModel: PropertyListingCardViewModel
    
    // MARK: - Initialization
    // Using @StateObject ensures each PropertyListingCardView owns its ViewModel
    init(listing: SearchListing, 
         favouritesStore: FavouritesStore,
         onContact: @escaping (String, ContactType) -> Void) {
        self.listing = listing
        self._viewModel = StateObject(wrappedValue: PropertyListingCardViewModel(
            listing: listing,
            favouritesStore: favouritesStore,
            onContact: onContact
        ))
    }
    

    var body: some View {
        
        VStack(alignment: .leading) {
            carouselSection
            
            VStack(alignment: .leading, spacing: 12) {
                
                HStack(alignment: .center, spacing: Spacing.sm) {
                    Text(viewModel.propertyType)
                        .font(Typography.metadata)
                        .foregroundColor(.secondary)
                    DeliveryChip(year: viewModel.deliveryYear)
                }
                
                Text(viewModel.priceLine)
                    .font(Typography.price)
                    .foregroundColor(.primary)
                
                
                HStack(spacing: Spacing.xs) {
                    Image(systemName: "location.fill")
                        .font(Typography.metadata)
                        .foregroundColor(.secondary)
                    Text(viewModel.location)
                        .font(Typography.location)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                
                
                HStack(spacing: Spacing.xs) {
                    Image(systemName: "bed.double.fill")
                        .font(Typography.metadata)
                        .foregroundColor(.secondary)
                    Text(viewModel.unitLine)
                        .font(Typography.metadata)
                        .foregroundColor(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, Spacing.lg)
            .padding(.top, Spacing.md)
            .padding(.bottom, Spacing.md)
            
                
                footerDivider
                
                HStack(alignment: .center, spacing: Spacing.sm) {
                    Text(viewModel.publishedLine)
                        .font(Typography.published)
                        .foregroundColor(.secondary)
                    Spacer(minLength: Spacing.sm)
                    HStack(spacing: Spacing.sm) {
                        ForEach(viewModel.contactOptions, id: \.self) {type in
                            contactButton(for: type)
                        }

                    }
                }
                .padding(.horizontal, Spacing.lg)
                .padding(.top, Spacing.xs)
                .padding(.bottom, viewModel.lastContactedLine == nil ? Spacing.lg : Spacing.sm)
            

            if let line = viewModel.lastContactedLine {
                lastContactedBanner(text: line)
            }
        }
        .background(SystemColors.background)
        .clipShape(RoundedRectangle(cornerRadius: CornerRadius.large))
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.large)
                .stroke(Color(UIColor.separator).opacity(Opacity.separator), lineWidth: Stroke.width)
        )
        .shadow(color: Shadow.card, radius: Shadow.cardRadius, x: Shadow.cardOffset.width, y: Shadow.cardOffset.height)
    }
    
    @ViewBuilder
    private func contactButton(for type: ContactType) -> some View {
        switch type {
        case .phone:
            ContactButton(.phone, action: { viewModel.handleContact(type: .phone) })
                .clipShape(Rectangle())
        case .email:
            ContactButton(.email, action: { viewModel.handleContact(type: .email) })
                .clipShape(Rectangle())
        case .whatsApp:
            ContactButton(.whatsApp, action: { viewModel.handleContact(type: .whatsApp) })
                .clipShape(Rectangle())
        case .sms:
            ContactButton(.whatsApp, action: { viewModel.handleContact(type: .sms) })
                .clipShape(Rectangle())
        }
    }

    private var footerDivider: some View {
        Rectangle()
            .fill(Color(UIColor.separator))
            .frame(height: Divider.height)
            .frame(maxWidth: .infinity)
    }

    private var carouselSection: some View {
        CarouselImageView(
            imageNames: viewModel.carouselImageNames,
            overlayContent: AnyView(
                HStack(alignment: .top) {
                    ForEach(Array(viewModel.tagLabels.enumerated()), id: \.offset) { _, label in
                        TagPillView(
                            text: label,
                            backgroundColor: viewModel.tagBackgroundColor(for: label)
                        )
                    }
                    Spacer(minLength: 0)
                    heartButton
                }
            )
        )
    }
    

    private var heartButton: some View {
        Button(action: { viewModel.toggleFavourite() }) {
            Image(systemName: viewModel.isFavourite ? "heart.fill" : "heart")
                .font(FontSizes.body.weight(FontWeights.medium))
                .foregroundColor(.white)
                .frame(width: Sizing.heartButtonSize, height: Sizing.heartButtonSize)
                .background(Circle().fill(Color.black.opacity(Opacity.heartBackground)))
                .animation(.spring(response: 0.32, dampingFraction: 0.65), value: viewModel.isFavourite)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(viewModel.isFavourite ? Accessibility.removeFromFavourite : Accessibility.addToFavourite)
    }


    private func lastContactedBanner(text: String) -> some View {
        HStack(spacing: Spacing.sm) {
            Image(systemName: "phone.fill")
                .font(Typography.metadata)
            Text(text)
                .font(Typography.metadata)
        }
        .foregroundColor(.primary)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, Spacing.sm)
        .padding(.vertical, Spacing.sm)
        .background(Color.yellow.opacity(Opacity.contactBanner))
        .clipShape(RoundedRectangle(cornerRadius: CornerRadius.small))
    }
}

struct PropertyListingCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PropertyListingCardView(
                listing: SearchListing(
                    id: "preview",
                    carouselImageNames: ["FirstImage", "SecondImage"],
                    tagLabels: ["VERIFIED", "NEW CONSTRUCTION"],
                    location: "Dubai",
                    propertyType: "Apartment",
                    deliveryYear: 2022,
                    priceLine: "2,575,000 AED",
                    unitLine: "Studio · 1 bath · 1356 sqft",
                    publishedLine: "Published 3 days ago",
                    lastContactedLine: "Last contacted: 28 Jul 2021",
                    contactOptions: [.phone, .email, .whatsApp]
                ),
                favouritesStore: FavouritesStore(),
                onContact: { _, _ in }
            )
            .padding()
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Not favourite")

            PropertyListingCardView(
                listing: SearchListing(
                    id: "preview-fav",
                    carouselImageNames: ["FirstImage", "SecondImage"],
                    tagLabels: ["VERIFIED", "NEW CONSTRUCTION"],
                    location: "Dubai",
                    propertyType: "Apartment",
                    deliveryYear: 2022,
                    priceLine: "2,575,000 AED",
                    unitLine: "Studio · 1 bath · 1356 sqft",
                    publishedLine: "Published 3 days ago",
                    lastContactedLine: "Last contacted: 28 Jul 2021",
                    contactOptions: [.phone, .email, .whatsApp]
                ),
                favouritesStore: FavouritesStore(),
                onContact: { _, _ in }
            )
            .padding()
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Favourite")
        }
    }
}
