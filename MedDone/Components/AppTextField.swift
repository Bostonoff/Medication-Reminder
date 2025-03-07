//
//  AppTextField.swift
//  MediMind
//
//  Created by Mukhammad Bustonov on 04/03/25.
//

import SwiftUI

struct AppTextField: View {
    private let title: String
    private let text: Binding<String>
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self.text = text
    }
    
    var body: some View {
        TextField(title, text: text)
            .padding(.vertical, 5)
            .background(Color.clear)
    }
    
}

#Preview {
    AppTextField("sameple", text: .constant("Text"))
}
