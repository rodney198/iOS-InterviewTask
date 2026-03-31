//
//  CarouselImageView.swift
//  Tahudu
//

import SwiftUI

struct CarouselImageView<Overlay: View>: View {
    let imageNames: [String]
    private let overlay: () -> Overlay

    init(imageNames: [String], @ViewBuilder overlay: @escaping () -> Overlay) {
        self.imageNames = imageNames
        self.overlay = overlay
    }

    var body: some View {
        ZStack(alignment: .top) {
            TabView {
                ForEach(imageNames, id: \.self) { name in
                    Image(name)
                        .resizable()
                        .scaledToFill()
                }
            }
            .frame(height: Sizing.carouselHeight)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .clipped()

            overlay()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(Spacing.sm)
        }
    }
}

extension CarouselImageView where Overlay == EmptyView {
    init(imageNames: [String]) {
        self.init(imageNames: imageNames) { EmptyView() }
    }
}

#Preview {
    VStack(spacing: Spacing.lg) {
        CarouselImageView(imageNames: ["FirstImage", "SecondImage"])

        CarouselImageView(imageNames: ["FirstImage", "SecondImage"]) {
            HStack {
                TagPillView(text: "VERIFIED", backgroundColor: .green)
                Spacer()
                FilterButton(systemName: "heart") { }
            }
        }
    }
    .padding()
}
