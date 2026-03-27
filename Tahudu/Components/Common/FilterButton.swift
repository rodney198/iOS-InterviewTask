//
//  FilterButton.swift
//  Tahudu
//

import SwiftUI

struct FilterButton: View {
    let systemName: String
    let action: () -> Void
    
    init(systemName: String, action: @escaping () -> Void) {
        self.systemName = systemName
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(Typography.buttons)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HStack(spacing: Spacing.md) {
        FilterButton(systemName: "line.3.horizontal.decrease.circle") {
            print("Filter tapped")
        }
        
        FilterButton(systemName: "arrow.up.arrow.down") {
            print("Sort tapped")
        }
        
        FilterButton(systemName: "star") {
            print("Favourites tapped")
        }
    }
    .foregroundColor(.accentColor)
    .padding()
}
