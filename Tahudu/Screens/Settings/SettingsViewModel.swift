//
//  SettingsViewModel.swift
//  Tahudu
//

import Foundation

final class SettingsViewModel {
    
    enum Action {
        case openLanguageSettings
        case showCountrySelection
        case showNotification
        case showAbout
        case showFeedback
    }
    
    struct Row {
        let accessibilityIdentifier: String
        let title: String
        let detail: String?
        let systemImageName: String
        let usesValue1Style: Bool
        let action: Action
    }
    
    var tableSections: [[Row]] {
        let languageCode = Bundle.main.preferredLocalizations.first
            ?? Locale.current.languageCode
            ?? AppStrings.preferredLanguageFallbackCode
        let languageLabel = Locale.current.localizedString(forLanguageCode: languageCode)

        return [
            [
                Row(
                    accessibilityIdentifier: Accessibility.settingsCellLanguage,
                    title: AppStrings.settingsLanguage,
                    detail: languageLabel,
                    systemImageName: "textformat",
                    usesValue1Style: true,
                    action: .openLanguageSettings
                ),
                Row(
                    accessibilityIdentifier: Accessibility.settingsCellCountry,
                    title: AppStrings.settingsCountry,
                    detail: AppStrings.settingsCountryUAE,
                    systemImageName: "globe",
                    usesValue1Style: true,
                    action: .showCountrySelection
                ),
                Row(
                    accessibilityIdentifier: Accessibility.settingsCellNotifications,
                    title: AppStrings.settingsNotifications,
                    detail: nil,
                    systemImageName: "app.badge",
                    usesValue1Style: false,
                    action: .showNotification
                ),
            ],
            [
                Row(
                    accessibilityIdentifier: Accessibility.settingsCellAbout,
                    title: AppStrings.settingsAbout,
                    detail: nil,
                    systemImageName: "info.circle",
                    usesValue1Style: false,
                    action: .showAbout
                ),
                Row(
                    accessibilityIdentifier: Accessibility.settingsCellFeedback,
                    title: AppStrings.settingsFeedback,
                    detail: nil,
                    systemImageName: "text.bubble",
                    usesValue1Style: false,
                    action: .showFeedback
                ),
            ],
        ]
    }
}
