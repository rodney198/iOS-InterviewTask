//
//  TahuduTabView.swift
//  Tahudu
//

import SwiftUI

struct TahuduTabView: View {
    @State private var selectedTab = Tabs.search.rawValue

    var body: some View {
        TabView(selection: $selectedTab) {
            SearchView()
                .tag(Tabs.search.rawValue)
                .tabItem {
                    Label(AppStrings.tabSearch, systemImage: "magnifyingglass")
                }
            SettingsView()
                .tag(Tabs.settings.rawValue)
                .tabItem {
                    Label(AppStrings.myAccount, systemImage: selectedTab == Tabs.settings.rawValue ? "person.fill" : "person")
                }
                .edgesIgnoringSafeArea(.all)
        }
    }
}

enum Tabs: Int, CaseIterable {
    case search = 0
    case settings

    var name: String {
        switch self {
        case .search:
            return AppStrings.tabSearch
        case .settings:
            return AppStrings.tabSettings
        }
    }
}

struct TahuduTabView_Previews: PreviewProvider {
    static var previews: some View {
        TahuduTabView()
    }
}
