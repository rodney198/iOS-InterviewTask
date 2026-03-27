//
//  CarouselImageView.swift
//  Tahudu
//

import SwiftUI

struct CarouselImageView: View {
    let imageNames: [String]
    let overlayContent: AnyView?
    
    init(imageNames: [String], overlayContent: AnyView? = nil) {
        self.imageNames = imageNames
        self.overlayContent = overlayContent
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
            
            if let overlay = overlayContent {
                overlay
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(Spacing.sm)
            }
        }
    }
}

#Preview {
    VStack(spacing: Spacing.lg) {
        CarouselImageView(imageNames: ["FirstImage", "SecondImage"])
        
        CarouselImageView(
            imageNames: ["FirstImage", "SecondImage"],
            overlayContent: AnyView(
                HStack {
                    TagPillView(text: "VERIFIED", backgroundColor: .green)
                    Spacer()
                    FilterButton(systemName: "heart") { }
                }
            )
        )
    }
    .padding()
}
