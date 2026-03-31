//
//  Colors.swift
//  Tahudu
//

import SwiftUI

extension UIColor {
    static let accentColor = UIColor(named: "Accent") ?? UIColor.systemBlue
    static let brand = UIColor(named: "Brand") ?? UIColor.systemRed
    
    // MARK: Status Colors
    static let error = UIColor.systemRed
    static let success = UIColor.systemGreen

    /// Listing card “last contacted” banner; adapts for light/dark.
    static let lastContactedBannerBackground = UIColor { traits in
        let alpha = traits.userInterfaceStyle == .dark ? 0.28 : CGFloat(Opacity.contactBanner)
        return UIColor.systemYellow.withAlphaComponent(alpha)
    }

    // MARK: Social Media

    static let whatsApp = UIColor(named: "WhatsApp") ?? UIColor.systemGreen
}

extension Color {
    // Due to the "Global Accent Color Name" setting, AccentColor can already be found under Color.accentColor
    static let brand = Color("Brand")
    
    // MARK: Status Colors
    static let error = Color(.systemRed)
    static let success = Color(.systemGreen)

    static let lastContactedBannerBackground = Color(UIColor.lastContactedBannerBackground)

    // MARK: Social Media

    static let whatsApp = Color("WhatsApp")
}
