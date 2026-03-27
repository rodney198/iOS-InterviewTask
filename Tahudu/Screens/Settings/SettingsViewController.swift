//
//  SettingsViewController.swift
//  Tahudu
//

import Foundation
import UIKit

class SettingsViewController: UITableViewController {

    private enum SettingsAction {
        case openLanguageSettings
        case showCountrySelection
        case showNotification
        case showAbout
        case showFeedback
    }

    private struct SettingsRow {
        let accessibilityIdentifier: String
        let title: String
        let detail: String?
        let systemImageName: String
        let usesValue1Style: Bool
        let action: SettingsAction
    }

    //MARK: - Seperate reuse identifier ids to manage cell - so reused cell stays value 1 vs default as intended
    private static let value1ReuseID = "SettingsCellValue1"
    private static let defaultReuseID = "SettingsCellDefault"

    /// Single source of truth for sections, rows, copy, SF Symbols, accessibility IDs, and tap actions.
    private var tableSections: [[SettingsRow]] {
        let languageCode = Bundle.main.preferredLocalizations.first
            ?? Locale.current.languageCode
            ?? "en"
        let languageLabel = Locale.current.localizedString(forLanguageCode: languageCode)

        return [
            [
                SettingsRow(
                    accessibilityIdentifier: "SettingsCell_language",
                    title: "Language",
                    detail: languageLabel,
                    systemImageName: "textformat",
                    usesValue1Style: true,
                    action: .openLanguageSettings
                ),
                SettingsRow(
                    accessibilityIdentifier: "SettingsCell_country",
                    title: "Country",
                    detail: "United Arab Emirates",
                    systemImageName: "globe",
                    usesValue1Style: true,
                    action: .showCountrySelection
                ),
                SettingsRow(
                    accessibilityIdentifier: "SettingsCell_notifications",
                    title: "Notifications",
                    detail: nil,
                    systemImageName: "app.badge",
                    usesValue1Style: false,
                    action: .showNotification
                ),
            ],
            [
                SettingsRow(
                    accessibilityIdentifier: "SettingsCell_about",
                    title: "About",
                    detail: nil,
                    systemImageName: "info.circle",
                    usesValue1Style: false,
                    action: .showAbout
                ),
                SettingsRow(
                    accessibilityIdentifier: "SettingsCell_feedback",
                    title: "Feedback",
                    detail: nil,
                    systemImageName: "text.bubble",
                    usesValue1Style: false,
                    action: .showFeedback
                ),
            ],
        ]
    }

    override func loadView() {
        super.loadView()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemGroupedBackground
        tableView.tableFooterView = UIView()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SettingsCell")
    }

    override func numberOfSections(in _: UITableView) -> Int {
        tableSections.count
    }

    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableSections[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = tableSections[indexPath.section][indexPath.row]
        let identifier = row.usesValue1Style ? Self.value1ReuseID : Self.defaultReuseID
        let style: UITableViewCell.CellStyle = row.usesValue1Style ? .value1 : .default
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
            ?? UITableViewCell(style: style, reuseIdentifier: identifier)
        applyBaseAppearance(to: cell, for: row)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //MARK: - Using switch we can check which cell is clicked - duplicate indexpath tree removed
         let action = tableSections[indexPath.section][indexPath.row].action
        switch action {
        case .openLanguageSettings:
            openSystemSettings()
        case .showCountrySelection:
            showCountrySelectionScreen()
        case .showNotification:
            showNotificationScreen()
        case .showAbout:
            showAboutScreen()
        case .showFeedback:
            showFeedbackScreen()
        }
    }

    //MARK: - Centralized the Repeated line of Code that was in cell for row at
    private func applyBaseAppearance(to cell: UITableViewCell, for row: SettingsRow) {
        cell.accessibilityIdentifier = row.accessibilityIdentifier
        cell.backgroundColor = .systemBackground
        cell.selectionStyle = .default
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(systemName: row.systemImageName)
        cell.textLabel?.text = row.title
        cell.textLabel?.textColor = .label
        cell.textLabel?.textAlignment = .natural
        if let detail = row.detail {
            cell.detailTextLabel?.text = detail
            cell.detailTextLabel?.textColor = .secondaryLabel
        } else {
            cell.detailTextLabel?.text = nil
        }
    }
}

// ===============================

/// NO NEED TO TUOCH THIS!!!
extension SettingsViewController {
    private func openSystemSettings() {
        print(#function)
    }

    private func showCountrySelectionScreen() {
        print(#function)
    }

    private func showNotificationScreen() {
        print(#function)
    }

    private func showAboutScreen() {
        print(#function)
    }

    private func showFeedbackScreen() {
        print(#function)
    }
}
