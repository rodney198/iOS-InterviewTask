//
//  ClearableTextField.swift
//  Tahudu
//

import SwiftUI

struct ClearableTextFieldStyle: TextFieldStyle {
    @Binding var text: String
    var symbol: String?
    @Binding var focused: Bool
    var onClear: (() -> Void)?

    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .modifier(TextFieldClearButton(text: $text, symbol: symbol, onClear: onClear))
            .multilineTextAlignment(.leading)
            .padding()
            .background(RoundedRectangle(cornerRadius: 8)
                            .stroke(focused ? Color.accentColor : Color(UIColor.lightGray), lineWidth: 1))
    }
}

struct ClearableTextField: View {
    @State private var editing = false

    let label: String
    let symbol: String?
    @Binding var text: String
    var onEditingChanged: ((Bool) -> Void)?
    var onClear: (() -> Void)?

    var body: some View {
        TextField(label, text: $text, onEditingChanged: { edit in
            self.editing = edit
            onEditingChanged?(edit)
        })
            .textFieldStyle(ClearableTextFieldStyle(text: $text, symbol: symbol, focused: $editing, onClear: onClear))
    }

    init(label: String,
         symbol: String? = nil,
         text: Binding<String>,
         onEditingChanged: ((Bool) -> Void)? = nil,
         onClear: (() -> Void)? = nil) {
        self.label = label
        self.symbol = symbol
        _text = text
        self.onEditingChanged = onEditingChanged
        self.onClear = onClear
    }
}

struct TextFieldClearButton: ViewModifier {
    @Environment(\.layoutDirection) var direction
    @Binding var text: String
    var symbol: String?
    var onClear: (() -> Void)?

    func body(content: Content) -> some View {
        HStack {
            if let icon = symbol {
                Image(systemName: icon).foregroundColor(Color(UIColor.lightGray))
            }
            content
            if !text.isEmpty {
                Button(action: {
                    self.text = ""
                    onClear?()
                }, label: {
                    Image(systemName: direction == .leftToRight ? "delete.left" : "delete.right")
                        .foregroundColor(.accentColor)
                })
            }
        }
    }
}

