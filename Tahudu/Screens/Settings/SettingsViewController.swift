//
//  SettingsViewController.swift
//  Tahudu
//

import Foundation
import UIKit

private final class SettingsValue1Cell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        nil
    }
}

private final class SettingsDefaultCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        nil
    }
}

class SettingsViewController: UITableViewController {

    private let viewModel = SettingsViewModel()

    private static let value1ReuseID = SettingsTable.value1ReuseID
    private static let defaultReuseID = SettingsTable.defaultReuseID

    override func loadView() {
        super.loadView()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemGroupedBackground
        tableView.tableFooterView = UIView()

        tableView.register(SettingsValue1Cell.self, forCellReuseIdentifier: Self.value1ReuseID)
        tableView.register(SettingsDefaultCell.self, forCellReuseIdentifier: Self.defaultReuseID)
    }

    override func numberOfSections(in _: UITableView) -> Int {
        viewModel.tableSections.count
    }

    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tableSections[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = viewModel.tableSections[indexPath.section][indexPath.row]
        let identifier = row.usesValue1Style ? Self.value1ReuseID : Self.defaultReuseID
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        applyBaseAppearance(to: cell, for: row)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let action = viewModel.tableSections[indexPath.section][indexPath.row].action
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

    private func applyBaseAppearance(to cell: UITableViewCell, for row: SettingsViewModel.Row) {
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
